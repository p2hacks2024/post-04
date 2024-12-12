import 'dart:async';
import 'dart:convert';

import 'package:epsilon_app/model/const/device_id.dart';
import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/state/serial_service_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

part 'foreground_serial_service.g.dart';

@Riverpod(keepAlive: true)
class SerialService extends _$SerialService {
  ForegroundSerialService? foregroundSerialService;
  Timer? connectAttemptTimer;
  bool _timerAsyncLock = false;
  @override
  SerialServiceState build() {
    whenDisconnected() {
      state = state.copyWith(isConnected: false);
      _initTimer();
      //#TODO isConnectedがfalseになったら，connect画面に戻った方がいい気がする
    }

    whenConnected() {
      state = state.copyWith(isConnected: true);
    }

    foregroundSerialService = ForegroundSerialService();
    foregroundSerialService!.disconnectListerners.add(whenDisconnected);
    foregroundSerialService!.connectListerners.add(whenConnected);

    ref.onDispose(() {
      connectAttemptTimer?.cancel();
    });

    _initTimer();

    return const SerialServiceState();
  }

  void _initTimer() {
    connectAttemptTimer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (_timerAsyncLock) return;
      _timerAsyncLock = true;
      if (state.isConnected) {
        timer.cancel();
      } else {
        var result = await foregroundSerialService!._getPorts();
        debugPrint('isConnected: $result');
        if (result) {
          state = state.copyWith(isConnected: true);
        }
      }
      _timerAsyncLock = false;
    });
  }

  void setConnected(bool value) {
    state = state.copyWith(isConnected: value);
  }
}

class ForegroundSerialService {
  UsbPort? _port;

  List<Function()> disconnectListerners = [];
  List<Function()> connectListerners = [];

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;
  List<Function(String value)> _listeners = [];
  ForegroundSerialService() {
    UsbSerial.usbEventStream?.listen((UsbEvent msg) async {
      if (msg.event == UsbEvent.ACTION_USB_DETACHED) {
        if (_device != null && msg.device == _device) {
          for (var action in disconnectListerners) {
            action();
          }
        }
      } else if (msg.event == UsbEvent.ACTION_USB_ATTACHED) {
        if (_device != null && msg.device == _device) {
          for (var action in connectListerners) {
            action();
          }
        }
      }
    });
  }

  // こいつを実行してやれば，arduinoとの接続ができる．(手動)
  Future<bool> _getPorts() async {
    print('getPorts() start.');
    List<UsbDevice> devices = await UsbSerial.listDevices();

    print('getPorts() devices=$devices.');
    if (devices.isEmpty) {
      return false;
    }

    Iterator<UsbDevice>? deviceIterator = devices.iterator;
    UsbDevice? searchDevice = null;
    bool searchRet = false;

    while (deviceIterator.moveNext()) {
      searchDevice = deviceIterator.current;

      // ArduinoのVendorIdだよ。
      if (searchDevice.vid == DeviceId.arduinoVendorId) {
        searchRet = true;
        break;
      }
    }

    if (!searchRet) {
      _connectTo(null);
      return false;
    } else {
      _connectTo(searchDevice);
      return true;
    }
  }

  Future<ArduinoMessage?> send(String value, {Function()? beforeOk, Function()? afterOk}) async {
    if (_port == null) {
      print('Send() _port=null return.');
      return null;
    }

    if (beforeOk != null) {
      beforeOk();
    }

    value = '$value\r\n';
    ArduinoMessage? message;
    bool isDone = false;

    listenerFunc(String value) {
      if (isDone) return;
      message = ArduinoMessage.fromMessage(value.trim());
      if (message == null) return;
      debugPrint('type: ${message!.type}');
      if (message!.type == 'OK.') {
        if (afterOk != null) {
          afterOk();
        }
        return;
      }
      if (afterOk != null) {
        afterOk();
      }
      isDone = true;
    }

    _listeners.add(listenerFunc);
    //await _port!.write(Uint8List.fromList(value.codeUnits));
    await _port!.write(Uint8List.fromList(ascii.encode(value)));
    // #TODO ここをいい感じにする．
    while (isDone == false) {
      await Future.delayed(const Duration(milliseconds: 10));
    }
    return message;
  }

  Future<bool> _connectTo(device) async {
    print('connect to device: $device');

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      _device = null;
      print('connectTo() device=null return.');
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      print('connectTo() failed to open port.');
      return false;
    }
    print('connectTo() device=$device.');
    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(_port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    // Arduinoからのデータ受信
    _subscription = _transaction!.stream.listen((String line) {
      FlutterForegroundTask.sendDataToMain(line);
      debugPrint('from Arduino:$line');
      var message = ArduinoMessage.fromMessage(line);
      for (var value in _listeners) {
        value(line);
      }
      //if (message is ArduinoColorMessage) {
      //  print(message.colorString);
      //  // #TODO ここで色を保存する．
      //}
    });

    print('connectTo() end.');
    return true;
  }
}

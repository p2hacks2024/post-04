import 'dart:async';

import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/state/serial_service_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

part 'foreground_serial_service.g.dart';

@riverpod
class SerialService extends _$SerialService {
  ForegroundSerialService? _foregroundSerialService;
  Timer? connectAttemptTimer;
  bool _timerAsyncLock = false;
  @override
  SerialServiceState build() {
    _foregroundSerialService = ForegroundSerialService();
    connectAttemptTimer = Timer.periodic(const Duration(seconds: 5), (timer) async {
      if(_timerAsyncLock) return;
      _timerAsyncLock = true;
      if(state.isConnected) {
        timer.cancel();
      }else{
        var result = await _foregroundSerialService!._getPorts();
        if(result) {
          state = state.copyWith(isConnected: true);
        }
      }
      _timerAsyncLock = false;
    });
    return const SerialServiceState();
  }


}

class ForegroundSerialService {
  String _status = "Idle";
  UsbPort? _port;

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;
  List<Function(String value)> _listeners = [];
  ForegroundSerialService() {
    _getPorts();
  }
  // こいつを実行してやれば，arduinoとの接続ができる．(手動)
  Future<bool> _getPorts() async {
    print('getPorts() start.');
    List<UsbDevice> devices = await UsbSerial.listDevices();

    print('getPorts() devices=$devices.');
    if (devices.isEmpty) {
      _status = "No devices";
      return false;
    } else {
      _status = "Searching";
    }

    Iterator<UsbDevice>? deviceIterator = devices.iterator;
    UsbDevice? searchDevice = null;
    bool searchRet = false;

    while (deviceIterator.moveNext()) {
      searchDevice = deviceIterator.current;

      // ArduinoのVendorIdだよ。
      if (searchDevice.vid == 9025) {
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

  Future<void> send(String value) async {
    if (_port == null) {
      print('Send() _port=null return.');
      return null;
    }

    // ArduinoMessage? message;
    // _listeners.add((String value) {
    //   print(value);
    //   message = ArduinoMessage.fromMessage(value);
    // });
    // await _port!.write(Uint8List.fromList(value.codeUnits));
    // while (message == null) {
    //   await Future.delayed(Duration(milliseconds: 100));
    // }
  }

  Future<bool> _connectTo(device) async {
    print("connect to device: $device");

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
      _status = "Disconnected";
      print('connectTo() device=null return.');
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      _status = "Failed to open port";
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
      var message = ArduinoMessage.fromMessage(line);
      for (var value in _listeners) {
        value(line);
      }
      if (message is ArduinoColorMessage) {
        print(message.colorString);
        // #TODO ここで色を保存する．
      }
      print(message.type);
    });

    _status = "Connected";
    print('connectTo() end.');
    return true;
  }
}

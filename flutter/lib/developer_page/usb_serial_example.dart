import 'dart:async';

import 'package:epsilon_app/model/const/device_id.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';

class UsbSerialSample extends StatefulWidget {
  final String title;

  const UsbSerialSample({super.key, required this.title});

  @override
  State<UsbSerialSample> createState() => _UsbSerialSampleState();
}

class _UsbSerialSampleState extends State<UsbSerialSample> {
  UsbPort? _port;
  String _status = 'Idle';
  bool _init = false;
  List<Widget> _serialData = [];
  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;

  final TextEditingController _controller = TextEditingController();
  String reply = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(children: <Widget>[
        Text(_init == false ? 'No serial devices available' : 'Available Serial Ports', style: Theme.of(context).textTheme.titleLarge),
        Text('Status: $_status\n'),
        Text('info: ${_port.toString()}\n'),
        ListTile(
          title: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Text To Send',
            ),
          ),
          trailing: ElevatedButton(
            onPressed: _port == null
                ? null
                : () async {
                    if (_port == null) {
                      return;
                    }
                    String data = _controller.text + '\r\n';
                    await _port!.write(Uint8List.fromList(data.codeUnits));
                    _controller.text = '';
                  },
            child: const Text('Send'),
          ),
        ),
        Text('Result Data', style: Theme.of(context).textTheme.titleLarge),
        ..._serialData,
      ])),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _connectTo(null);
  }

  @override
  void initState() {
    super.initState();
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });

    _getPorts();
    _init = true;
    setState(() {});
  }

  Future<bool> _connectTo(device) async {
    _serialData.clear();

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
      setState(() {
        _status = 'Disconnected';
      });
      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      setState(() {
        _status = 'Failed to open port';
      });
      return false;
    }
    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(9600, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(_port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    _subscription = _transaction!.stream.listen((String line) {
      setState(() {
        _serialData.add(Text(line));
        if (_serialData.length > 20) {
          _serialData.removeAt(0);
        }
      });
    });

    setState(() {
      _status = 'Connected';
    });
    return true;
  }

  void _getPorts() async {
    List<UsbDevice> devices = await UsbSerial.listDevices();

    if (devices.isEmpty) {
      _status = 'No devices';
    } else {
      _status = 'Searching';
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
    } else {
      _connectTo(searchDevice);
    }

    setState(() {});
  }
}

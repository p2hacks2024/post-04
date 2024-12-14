import 'dart:isolate';

import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  ForegroundSerialService? serialService;
  int _count = 0;
  @override
  Future<void> onDestroy(DateTime timestamp) async {
  }

  @override
  void onReceiveData(Object data) {
    serialService?.send(data.toString());
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    serialService = ForegroundSerialService();
  }

  void _incrementCount() {
    _count++;
    // Update notification content.
    FlutterForegroundTask.updateService(
      notificationTitle: 'Hello MyTaskHandler :)',
      notificationText: 'count: $_count',
    );
    // Send data to main isolate.
    FlutterForegroundTask.sendDataToMain(_count);
  }

  @override
  void onNotificationButtonPressed(String id) {
    FlutterForegroundTask.restartService();
  }
}

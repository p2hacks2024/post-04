import 'dart:isolate';

import 'package:epsilon_app/service/serial_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  print("startCallback");
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
  SerialService? serialService;
  int _count = 0;
  @override
  Future<void> onDestroy(DateTime timestamp) async {
    debugPrint("service destroyed");
    print("service destroyed");
  }

  @override
  void onRepeatEvent(DateTime timestamp) {
    debugPrint(timestamp.toString());
    print(timestamp.toIso8601String());
    FlutterForegroundTask.sendDataToMain(timestamp.toString());
  }

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {
    debugPrint("service started");
    serialService = SerialService();
    print("service started");
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
    debugPrint(id);
    FlutterForegroundTask.launchApp();
  }
}

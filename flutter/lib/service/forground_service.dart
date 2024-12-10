import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';

@pragma('vm:entry-point')
void startCallback() {
  FlutterForegroundTask.setTaskHandler(MyTaskHandler());
}

class MyTaskHandler extends TaskHandler {
  SendPort? _sendPort;
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

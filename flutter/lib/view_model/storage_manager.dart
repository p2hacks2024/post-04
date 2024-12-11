import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StorageManager extends ChangeNotifier {
  static final StorageManager _instance = StorageManager._internal();
  late final SharedPreferences prefs;
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';

  StorageManager._internal();

  factory StorageManager() {
    return _instance;
  }

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
    notifyListeners();
  }

  Future<void> addData({required Color inputColor}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(history)) {
      prefs.setStringList(history, <String>[]);
    }
    List<String> historyList = prefs.getStringList(history)!;
    Map<String, String> addedMap = {
      color:
          '#${inputColor.value.toRadixString(16).substring(2)}', //カラーコードの先頭2桁は透明度を表すため、除外
      created: formatStringToTime(time: DateTime.now())
    };
    historyList.add(jsonEncode(addedMap));
    await prefs.setStringList(history, historyList);
    await prefs.setString(updated, formatStringToTime(time: DateTime.now()));
  }

  //historyIndexに-1を入れると、最新のデータを取得できる
  Future<String> getData(
      {required String key, int? historyIndex, String? historyKey}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey(key)) return 'null';
    if (key == history && historyIndex != null) {
      if (historyIndex == -1) {
        historyIndex = prefs.getStringList(history)!.length - 1;
      }
      return (jsonDecode(prefs.getStringList(history)![historyIndex])
          as Map)[historyKey];
    }
    return prefs.get(key) as String;
  }

  String formatStringToTime({required DateTime time}) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    return formatter.format(time);
  }

  DateTime parseTimeFromString({required String timeString}) {
    final DateFormat formatter = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    //
    return formatter.parse('$timeString.0');
  }

  Future<void> deleteAllStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    notifyListeners();
  }
}

import 'dart:convert';

import 'package:epsilon_app/state/storage_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:shared_preferences/shared_preferences.dart';

part 'storage_manager.g.dart';

@riverpod
class StorageManager extends _$StorageManager {
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';

  @override
  Future<StorageState> build() async {
    return this;
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

  Future<String> getAllDataString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String text = '';
    for (String key in prefs.getKeys()) {
      var value = prefs.get(key);
      if (value is List<String>) {
        String tmp = '';
        for (String entry in value) {
          tmp += '$entry, ';
        }
        value = '[${tmp.substring(0, tmp.length-2)}]';
      }
      text += '$key: $value\n';
    }
    debugPrint(text);
    return text;
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
  }
}

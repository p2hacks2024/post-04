import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:shared_preferences/shared_preferences.dart';

//まだfetchedは実装していない
class StorageExample extends StatefulWidget {
  const StorageExample({super.key});
  @override
  State<StorageExample> createState() => _StorageExampleState();
}

class _StorageExampleState extends State<StorageExample> {
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadStorage(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          final snapshotData = snapshot.data!;
          String storageData = '';
          for (String key in snapshotData.getKeys()) {
            var value = snapshotData.get(key);
            if (value is List<String>) {
              String tmp = '';
              for (String entry in value) {
                tmp += '$entry, ';
              }
              value = '[$tmp]';
            }
            storageData += '$key: $value\n';
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('ストレージデモ'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'storage\n$storageData',
                    style: const TextStyle(fontSize: 30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      _colorButton(color: Colors.red),
                      _colorButton(color: Colors.green),
                      _colorButton(color: Colors.blue)
                    ],
                  ),
                  IconButton(
                    onPressed: () {
                      deleteAllStorage();
                    },
                    icon: const Icon(Icons.delete),
                  ),
                  //デバッグ用ボタン
                  IconButton(
                    onPressed: () async {
                      String updatedData = await getData(key: updated);
                      String latestColor = await getData(
                          key: history, historyIndex: -1, historyKey: color);
                      String latestCreated = await getData(
                          key: history, historyIndex: -1, historyKey: created);
                      debugPrint('$updated: $updatedData');
                      debugPrint('latestColor: $latestColor');
                      debugPrint('LatestCreated: $latestCreated');
                    },
                    icon: const Icon(Icons.description),
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Widget _colorButton({required Color color}) {
    final Map<Color, String> colorMap = {
      Colors.red: '赤',
      Colors.blue: '青',
      Colors.green: '緑'
    };
    return Container(
      color: color,
      child: ElevatedButton(
        onPressed: () {
          addData(inputColor: color);
          setState(() {});
        },
        child: Text(
          colorMap[color]!,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Future<SharedPreferences> loadStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
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
    setState(() {});
  }
}

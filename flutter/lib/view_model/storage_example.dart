import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shared_preferences/shared_preferences.dart';

class StorageExample extends StatelessWidget {
  const StorageExample({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadColorHistory(),
      builder: (context, snapshot) {
        if (snapshot.data == null) {
          return const CircularProgressIndicator();
        } else {
          final snapshotData = snapshot.data!;
          String storageData = "";
          for (String key in snapshotData.getKeys()) {
            var value = snapshotData.get(key);
            if (value is List<String>) {
              String tmp = "";
              for (String entry in value) {
                tmp += "$entry, ";
              }
              value = "[$tmp]";
            }
            storageData += "$key: $value\n";
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('ストレージ実験'),
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
                      colorButton(color: Colors.red),
                      colorButton(color: Colors.green),
                      colorButton(color: Colors.blue)
                    ],
                  ),
                  IconButton(
                      onPressed: () {
                        _deleteAllStorage();
                      },
                      icon: const Icon(Icons.delete))
                ],
              ),
            ),
          );
        }
      },
    );
  }

  Future<SharedPreferences> _loadColorHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  Future<void> _addColor({required Color color}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    const String history = "history";
    if (!prefs.containsKey(history)) {
      prefs.setStringList(history, <String>[]);
    }
    String text = "#${color.value.toRadixString(16).substring(2)}";
    debugPrint("addedColor: $text");
    prefs.getStringList(history)!.add(text);
  }

  Widget colorButton({required Color color}) {
    final Map<Color, String> colorMap = {
      Colors.red: '赤',
      Colors.blue: '青',
      Colors.green: '緑'
    };
    return Container(
      color: color,
      child: ElevatedButton(
        onPressed: () {
          _addColor(color: color);
        },
        child: Text(
          colorMap[color]!,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }

  Future<void> _deleteAllStorage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}

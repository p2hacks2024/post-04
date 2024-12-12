import 'package:flutter/material.dart';
import 'package:epsilon_app/util/storage_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//まだfetchedは実装していない
class StorageExample extends ConsumerWidget {
  const StorageExample({super.key});
  final String history = 'history';
  final String color = 'color';
  final String created = 'created';
  final String updated = 'updated';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    debugPrint('3: StorageExample.build() state: ${ref.read(storageManagerProvider.notifier).state.history}');
    ref.read(storageManagerProvider.notifier).save();
    ref.listenManual(storageManagerProvider,(prev, next) {
      debugPrint("更新されたゾ:${next.updated}");
    });
    return Scaffold(
      appBar: AppBar(
        title: const Text('ストレージデモ'),
        
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'latestHistory: ${ref.watch(storageManagerProvider).history}\nupdated: ${ref.watch(storageManagerProvider).updated}\nfetched: ${ref.watch(storageManagerProvider).fetched}',
              style: const TextStyle(fontSize: 30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _colorButton(ref: ref, color: Colors.red),
                _colorButton(ref: ref, color: Colors.green),
                _colorButton(ref: ref, color: Colors.blue)
              ],
            ),
            IconButton(
              onPressed: () {
                ref
                    .watch(storageManagerProvider.notifier)
                    .deleteHistory();
              },
              icon: const Icon(Icons.delete),
            ),
            //デバッグ用ボタン
            IconButton(
              onPressed: () async {
                debugPrint('${ref.watch(storageManagerProvider)}');
              },
              icon: const Icon(Icons.description),
            )
          ],
        ),
      ),
    );
  }

  Widget _colorButton({required WidgetRef ref, required Color color}) {
    final Map<Color, String> colorMap = {
      Colors.red: '赤',
      Colors.blue: '青',
      Colors.green: '緑'
    };
    return Container(
      color: color,
      child: ElevatedButton(
        onPressed: () {
          ref.watch(storageManagerProvider.notifier).addColor(inputColor: color);
        },
        child: Text(
          colorMap[color]!,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

        // if (true) {
        // } else {
        //   final storageData = ref.watch(storageManagerProvider.notifier).prefs;
        //   String storageText = '';
        //   for (String key in storageData.getKeys()) {
        //     var value = storageData.get(key);
        //     if (value is List<String>) {
        //       String tmp = '';
        //       for (String entry in value) {
        //         tmp += '$entry, ';
        //       }
        //       value = '[$tmp]';
        //     }
        //     storageText += '$key: $value\n';
        //   }
        // }

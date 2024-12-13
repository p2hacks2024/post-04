import 'package:flutter/material.dart';
import 'package:epsilon_app/repository/storage_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//まだfetchedは実装していない
class StorageExample extends ConsumerWidget {
  const StorageExample({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(storageManagerProvider.notifier).save();
    return Scaffold(
      appBar: AppBar(
        title: const Text('ストレージデモ'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '''latestHistory: ${ref.watch(storageManagerProvider).history!.isNotEmpty ? ref.watch(storageManagerProvider).history!.last : ''}
              updated: ${ref.watch(storageManagerProvider).updated}
              fetched: ${ref.watch(storageManagerProvider).fetched}''',
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
                ref.watch(storageManagerProvider.notifier).deleteHistory();
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
          ref
              .watch(storageManagerProvider.notifier)
              .addColor(inputColor: color);
        },
        child: Text(
          colorMap[color]!,
          style: const TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}
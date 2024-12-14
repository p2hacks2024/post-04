import 'package:epsilon_app/view_model/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConnectedPage extends ConsumerWidget {
  final Color? color;
  const ConnectedPage({super.key, this.color});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(playViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state.isPressed && !state.isSending) {
        context.pushReplacement('/play/charge');
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: color != null ? const Text('Connected') : Text("Share"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text('人'),
          ElevatedButton(
              onPressed: () async {
                await ref.read(playViewModelProvider.notifier).start();
              },
              child: const Text('SET')),
          if (state.isSending) const Text('メッセージの送信中です'),
        ],
      ),
    );
  }
}

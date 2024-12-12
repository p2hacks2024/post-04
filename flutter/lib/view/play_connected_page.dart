import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:epsilon_app/viewmodel/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConnectedPage extends ConsumerWidget {
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
        title: const Text('Connected'),
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

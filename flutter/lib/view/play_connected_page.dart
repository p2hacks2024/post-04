import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ConnectedPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var state = ref.watch(serialServiceProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (state.response == null) return;
      if (state.response is ArduinoColorMessage) {
        var color = (state.response as ArduinoColorMessage).color;
        context.go('/play/flash/${color.value}');
      } else {
        if (state.response!.type == ArduinoMessageType.invalid || state.response!.type == ArduinoMessageType.waitAMoment) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("メッセージが不正です")));
        }
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
          const Text("人"),
          ElevatedButton(
              onPressed: () async {
                await ref.read(serialServiceProvider.notifier).start();
              },
              child: const Text("SET")),
          if (state.isConnecting) const Text("メッセージの送信中です"),
        ],
      ),
    );
  }
}
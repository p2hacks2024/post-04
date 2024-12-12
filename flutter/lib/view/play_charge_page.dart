import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/state/play_state.dart';
import 'package:epsilon_app/viewmodel/play_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChargePage extends ConsumerWidget {
  const ChargePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    PlayState state = ref.watch(playViewModelProvider);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //#TODO ここを次のページに移す
      if (state.response == null) return;
      if (state.response is ArduinoColorMessage) {
        var color = (state.response as ArduinoColorMessage).color;
        context.pushReplacement('/play/flash/${color.value}');
      } else {
        if (state.response!.type == ArduinoMessageType.invalid || state.response!.type == ArduinoMessageType.waitAMoment) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('メッセージが不正です')));
        }
      }
    });
    return const Scaffold(
      body: Center(
        child: Text('charge'),
      ),
    );
  }
}

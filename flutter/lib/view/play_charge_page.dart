import 'package:design_sync/design_sync.dart';
import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/state/play_state.dart';
import 'package:epsilon_app/view_model/play_view_model.dart';
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
        var color = state.color;
        context.pushReplacement('/play/flash/${color!.value}');
      } else {
        if (state.response!.type == ArduinoMessageType.invalid || state.response!.type == ArduinoMessageType.waitAMoment) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('メッセージが不正です')));
        }
      }
    });
    return Scaffold(
      body: Center(
        child: Text(
          'Charge…',
          style: TextStyle(
            fontSize: 32.adaptedFontSize,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

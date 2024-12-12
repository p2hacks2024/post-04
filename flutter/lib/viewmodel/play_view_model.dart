import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/service/foreground_serial_service.dart';
import 'package:epsilon_app/state/play_state.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'play_view_model.g.dart';

@riverpod
class PlayViewModel extends _$PlayViewModel {
  ForegroundSerialService? _foregroundSerialService;
  @override
  PlayState build() {
    _foregroundSerialService = ref.read(serialServiceProvider.notifier).foregroundSerialService;
    return const PlayState();
  }

  Future<void> start() async {
    ArduinoMessage? result = await _foregroundSerialService?.send('RDY 0', beforeOk: () {
      state = state.copyWith(isSending: true);
    }, afterOk: () {
      state = state.copyWith(isSending: false);
    });
    if (result == null) return;
    if (result is ArduinoColorMessage) {
      debugPrint('result is : type: ${result.type}, value: ${result.color.toString()}');
    }
    state = state.copyWith(response: result);
  }
}

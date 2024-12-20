import 'dart:ui';

import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:epsilon_app/repository/storage_manager.dart';
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

  Future<void> start({Color? color}) async {
    if (color == null) {
      ArduinoMessage? result = await _foregroundSerialService?.send('CRG 0', beforeOk: () {
        state = state.copyWith(isSending: true, isPressed: true);
      }, afterOk: () {
        state = state.copyWith(isSending: false);
      });
      if (result == null) return;
      if (result is ArduinoColorMessage) {
        // #TODO ここで色を保存する．
        ref.read(storageManagerProvider.notifier).addColor(inputColor: result.color);
        // state = state.copyWith(color: result.color);
        await ref.read(storageManagerProvider.notifier).save();
        ref.read(playViewModelProvider.notifier).setColor(result.color);
      }

      state = state.copyWith(response: result);
      // 色をシェアされた時
    } else {
      ArduinoMessage? result = await _foregroundSerialService?.send('SET ${color.value.toRadixString(16)}', beforeOk: () {
        state = state.copyWith(isSending: true, isPressed: true);
      }, afterOk: () {
        state = state.copyWith(isSending: false);
      });
      debugPrint('SET ${color.value.toRadixString(16)}');
      if (result == null) return;
      if (result is ArduinoColorMessage) {
        // #TODO ここで色を保存する．
        ref.read(storageManagerProvider.notifier).addColor(inputColor: result.color);
        // state = state.copyWith(color: result.color);
        await ref.read(storageManagerProvider.notifier).save();
        ref.read(playViewModelProvider.notifier).setColor(result.color);
      }

      state = state.copyWith(response: result);
    }
  }

  void setColor(Color color) {
    state = state.copyWith(color: color);
  }
}

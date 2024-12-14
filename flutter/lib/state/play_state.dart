import 'dart:ui';

import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'play_state.freezed.dart';

@freezed
class PlayState with _$PlayState {
  const factory PlayState({
    @Default(false) bool isSending,
    @Default(false) bool isPressed,
    Color? color,
    ArduinoMessage? response,
  }) = _PlayState;
}

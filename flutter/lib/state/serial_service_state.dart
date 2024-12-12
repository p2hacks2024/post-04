import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'serial_service_state.freezed.dart';

@freezed
class SerialServiceState with _$SerialServiceState {
  const factory SerialServiceState({
    // Arduinoが接続された(readyではない)
    @Default(false) bool isConnected,
    // ArduinoからPWR 0の信号を受け取ってら
    @Default(false) bool isArduinoReady,
    @Default(false) bool isSet,
  }) = _SerialerviceState;
}

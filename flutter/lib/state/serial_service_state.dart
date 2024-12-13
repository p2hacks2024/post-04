import 'package:freezed_annotation/freezed_annotation.dart';

part 'serial_service_state.freezed.dart';

@freezed
class SerialServiceState with _$SerialServiceState {
  const factory SerialServiceState({
    // Arduinoが接続された(readyではない)
    @Default(false) bool isConnected,
    @Default(false) bool isSet,
  }) = _SerialServiceState;
}

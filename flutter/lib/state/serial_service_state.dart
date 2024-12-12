import 'package:epsilon_app/model/enums/arduino_message_type_enum.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'serial_service_state.freezed.dart';

@freezed
class SerialServiceState with _$SerialServiceState {
  const factory SerialServiceState({
    @Default(false)bool isConnected,
    @Default(false)bool isSet,
    ArduinoMessage? response,
  }) = _SerialerviceState;
}

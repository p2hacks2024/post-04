// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'serial_service_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$SerialServiceState {
// Arduinoが接続された(readyではない)
  bool get isConnected =>
      throw _privateConstructorUsedError; // ArduinoからPWR 0の信号を受け取ってら
  bool get isArduinoReady => throw _privateConstructorUsedError;
  bool get isSet => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SerialServiceStateCopyWith<SerialServiceState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SerialServiceStateCopyWith<$Res> {
  factory $SerialServiceStateCopyWith(
          SerialServiceState value, $Res Function(SerialServiceState) then) =
      _$SerialServiceStateCopyWithImpl<$Res, SerialServiceState>;
  @useResult
  $Res call({bool isConnected, bool isArduinoReady, bool isSet});
}

/// @nodoc
class _$SerialServiceStateCopyWithImpl<$Res, $Val extends SerialServiceState>
    implements $SerialServiceStateCopyWith<$Res> {
  _$SerialServiceStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isArduinoReady = null,
    Object? isSet = null,
  }) {
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isArduinoReady: null == isArduinoReady
          ? _value.isArduinoReady
          : isArduinoReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isSet: null == isSet
          ? _value.isSet
          : isSet // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SerialerviceStateImplCopyWith<$Res>
    implements $SerialServiceStateCopyWith<$Res> {
  factory _$$SerialerviceStateImplCopyWith(_$SerialerviceStateImpl value,
          $Res Function(_$SerialerviceStateImpl) then) =
      __$$SerialerviceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isConnected, bool isArduinoReady, bool isSet});
}

/// @nodoc
class __$$SerialerviceStateImplCopyWithImpl<$Res>
    extends _$SerialServiceStateCopyWithImpl<$Res, _$SerialerviceStateImpl>
    implements _$$SerialerviceStateImplCopyWith<$Res> {
  __$$SerialerviceStateImplCopyWithImpl(_$SerialerviceStateImpl _value,
      $Res Function(_$SerialerviceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isArduinoReady = null,
    Object? isSet = null,
  }) {
    return _then(_$SerialerviceStateImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isArduinoReady: null == isArduinoReady
          ? _value.isArduinoReady
          : isArduinoReady // ignore: cast_nullable_to_non_nullable
              as bool,
      isSet: null == isSet
          ? _value.isSet
          : isSet // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SerialerviceStateImpl implements _SerialerviceState {
  const _$SerialerviceStateImpl(
      {this.isConnected = false,
      this.isArduinoReady = false,
      this.isSet = false});

// Arduinoが接続された(readyではない)
  @override
  @JsonKey()
  final bool isConnected;
// ArduinoからPWR 0の信号を受け取ってら
  @override
  @JsonKey()
  final bool isArduinoReady;
  @override
  @JsonKey()
  final bool isSet;

  @override
  String toString() {
    return 'SerialServiceState(isConnected: $isConnected, isArduinoReady: $isArduinoReady, isSet: $isSet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SerialerviceStateImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isArduinoReady, isArduinoReady) ||
                other.isArduinoReady == isArduinoReady) &&
            (identical(other.isSet, isSet) || other.isSet == isSet));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isConnected, isArduinoReady, isSet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SerialerviceStateImplCopyWith<_$SerialerviceStateImpl> get copyWith =>
      __$$SerialerviceStateImplCopyWithImpl<_$SerialerviceStateImpl>(
          this, _$identity);
}

abstract class _SerialerviceState implements SerialServiceState {
  const factory _SerialerviceState(
      {final bool isConnected,
      final bool isArduinoReady,
      final bool isSet}) = _$SerialerviceStateImpl;

  @override // Arduinoが接続された(readyではない)
  bool get isConnected;
  @override // ArduinoからPWR 0の信号を受け取ってら
  bool get isArduinoReady;
  @override
  bool get isSet;
  @override
  @JsonKey(ignore: true)
  _$$SerialerviceStateImplCopyWith<_$SerialerviceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

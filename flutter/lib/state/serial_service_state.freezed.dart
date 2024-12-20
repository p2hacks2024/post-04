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
  bool get isConnected => throw _privateConstructorUsedError;
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
  $Res call({bool isConnected, bool isSet});
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
    Object? isSet = null,
  }) {
    return _then(_value.copyWith(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isSet: null == isSet
          ? _value.isSet
          : isSet // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SerialServiceStateImplCopyWith<$Res>
    implements $SerialServiceStateCopyWith<$Res> {
  factory _$$SerialServiceStateImplCopyWith(_$SerialServiceStateImpl value,
          $Res Function(_$SerialServiceStateImpl) then) =
      __$$SerialServiceStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool isConnected, bool isSet});
}

/// @nodoc
class __$$SerialServiceStateImplCopyWithImpl<$Res>
    extends _$SerialServiceStateCopyWithImpl<$Res, _$SerialServiceStateImpl>
    implements _$$SerialServiceStateImplCopyWith<$Res> {
  __$$SerialServiceStateImplCopyWithImpl(_$SerialServiceStateImpl _value,
      $Res Function(_$SerialServiceStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isConnected = null,
    Object? isSet = null,
  }) {
    return _then(_$SerialServiceStateImpl(
      isConnected: null == isConnected
          ? _value.isConnected
          : isConnected // ignore: cast_nullable_to_non_nullable
              as bool,
      isSet: null == isSet
          ? _value.isSet
          : isSet // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$SerialServiceStateImpl implements _SerialServiceState {
  const _$SerialServiceStateImpl(
      {this.isConnected = false, this.isSet = false});

// Arduinoが接続された(readyではない)
  @override
  @JsonKey()
  final bool isConnected;
  @override
  @JsonKey()
  final bool isSet;

  @override
  String toString() {
    return 'SerialServiceState(isConnected: $isConnected, isSet: $isSet)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SerialServiceStateImpl &&
            (identical(other.isConnected, isConnected) ||
                other.isConnected == isConnected) &&
            (identical(other.isSet, isSet) || other.isSet == isSet));
  }

  @override
  int get hashCode => Object.hash(runtimeType, isConnected, isSet);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SerialServiceStateImplCopyWith<_$SerialServiceStateImpl> get copyWith =>
      __$$SerialServiceStateImplCopyWithImpl<_$SerialServiceStateImpl>(
          this, _$identity);
}

abstract class _SerialServiceState implements SerialServiceState {
  const factory _SerialServiceState(
      {final bool isConnected, final bool isSet}) = _$SerialServiceStateImpl;

  @override // Arduinoが接続された(readyではない)
  bool get isConnected;
  @override
  bool get isSet;
  @override
  @JsonKey(ignore: true)
  _$$SerialServiceStateImplCopyWith<_$SerialServiceStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

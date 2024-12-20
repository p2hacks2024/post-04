// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'play_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$PlayState {
  bool get isSending => throw _privateConstructorUsedError;
  bool get isPressed => throw _privateConstructorUsedError;
  Color? get color => throw _privateConstructorUsedError;
  ArduinoMessage? get response => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PlayStateCopyWith<PlayState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PlayStateCopyWith<$Res> {
  factory $PlayStateCopyWith(PlayState value, $Res Function(PlayState) then) =
      _$PlayStateCopyWithImpl<$Res, PlayState>;
  @useResult
  $Res call(
      {bool isSending, bool isPressed, Color? color, ArduinoMessage? response});
}

/// @nodoc
class _$PlayStateCopyWithImpl<$Res, $Val extends PlayState>
    implements $PlayStateCopyWith<$Res> {
  _$PlayStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSending = null,
    Object? isPressed = null,
    Object? color = freezed,
    Object? response = freezed,
  }) {
    return _then(_value.copyWith(
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isPressed: null == isPressed
          ? _value.isPressed
          : isPressed // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ArduinoMessage?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PlayStateImplCopyWith<$Res>
    implements $PlayStateCopyWith<$Res> {
  factory _$$PlayStateImplCopyWith(
          _$PlayStateImpl value, $Res Function(_$PlayStateImpl) then) =
      __$$PlayStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isSending, bool isPressed, Color? color, ArduinoMessage? response});
}

/// @nodoc
class __$$PlayStateImplCopyWithImpl<$Res>
    extends _$PlayStateCopyWithImpl<$Res, _$PlayStateImpl>
    implements _$$PlayStateImplCopyWith<$Res> {
  __$$PlayStateImplCopyWithImpl(
      _$PlayStateImpl _value, $Res Function(_$PlayStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isSending = null,
    Object? isPressed = null,
    Object? color = freezed,
    Object? response = freezed,
  }) {
    return _then(_$PlayStateImpl(
      isSending: null == isSending
          ? _value.isSending
          : isSending // ignore: cast_nullable_to_non_nullable
              as bool,
      isPressed: null == isPressed
          ? _value.isPressed
          : isPressed // ignore: cast_nullable_to_non_nullable
              as bool,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as Color?,
      response: freezed == response
          ? _value.response
          : response // ignore: cast_nullable_to_non_nullable
              as ArduinoMessage?,
    ));
  }
}

/// @nodoc

class _$PlayStateImpl implements _PlayState {
  const _$PlayStateImpl(
      {this.isSending = false,
      this.isPressed = false,
      this.color,
      this.response});

  @override
  @JsonKey()
  final bool isSending;
  @override
  @JsonKey()
  final bool isPressed;
  @override
  final Color? color;
  @override
  final ArduinoMessage? response;

  @override
  String toString() {
    return 'PlayState(isSending: $isSending, isPressed: $isPressed, color: $color, response: $response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PlayStateImpl &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.isPressed, isPressed) ||
                other.isPressed == isPressed) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.response, response) ||
                other.response == response));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, isSending, isPressed, color, response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PlayStateImplCopyWith<_$PlayStateImpl> get copyWith =>
      __$$PlayStateImplCopyWithImpl<_$PlayStateImpl>(this, _$identity);
}

abstract class _PlayState implements PlayState {
  const factory _PlayState(
      {final bool isSending,
      final bool isPressed,
      final Color? color,
      final ArduinoMessage? response}) = _$PlayStateImpl;

  @override
  bool get isSending;
  @override
  bool get isPressed;
  @override
  Color? get color;
  @override
  ArduinoMessage? get response;
  @override
  @JsonKey(ignore: true)
  _$$PlayStateImplCopyWith<_$PlayStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

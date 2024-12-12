// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'storage_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StorageState {
  List<HistoryModel> get history => throw _privateConstructorUsedError;
  DateTime? get updated => throw _privateConstructorUsedError;
  DateTime? get fetched => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StorageStateCopyWith<StorageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StorageStateCopyWith<$Res> {
  factory $StorageStateCopyWith(
          StorageState value, $Res Function(StorageState) then) =
      _$StorageStateCopyWithImpl<$Res, StorageState>;
  @useResult
  $Res call({List<HistoryModel> history, DateTime? updated, DateTime? fetched});
}

/// @nodoc
class _$StorageStateCopyWithImpl<$Res, $Val extends StorageState>
    implements $StorageStateCopyWith<$Res> {
  _$StorageStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
    Object? updated = freezed,
    Object? fetched = freezed,
  }) {
    return _then(_value.copyWith(
      history: null == history
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<HistoryModel>,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fetched: freezed == fetched
          ? _value.fetched
          : fetched // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StorageStateImplCopyWith<$Res>
    implements $StorageStateCopyWith<$Res> {
  factory _$$StorageStateImplCopyWith(
          _$StorageStateImpl value, $Res Function(_$StorageStateImpl) then) =
      __$$StorageStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<HistoryModel> history, DateTime? updated, DateTime? fetched});
}

/// @nodoc
class __$$StorageStateImplCopyWithImpl<$Res>
    extends _$StorageStateCopyWithImpl<$Res, _$StorageStateImpl>
    implements _$$StorageStateImplCopyWith<$Res> {
  __$$StorageStateImplCopyWithImpl(
      _$StorageStateImpl _value, $Res Function(_$StorageStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? history = null,
    Object? updated = freezed,
    Object? fetched = freezed,
  }) {
    return _then(_$StorageStateImpl(
      history: null == history
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<HistoryModel>,
      updated: freezed == updated
          ? _value.updated
          : updated // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fetched: freezed == fetched
          ? _value.fetched
          : fetched // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$StorageStateImpl implements _StorageState {
  const _$StorageStateImpl(
      {final List<HistoryModel> history = const [], this.updated, this.fetched})
      : _history = history;

  final List<HistoryModel> _history;
  @override
  @JsonKey()
  List<HistoryModel> get history {
    if (_history is EqualUnmodifiableListView) return _history;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  final DateTime? updated;
  @override
  final DateTime? fetched;

  @override
  String toString() {
    return 'StorageState(history: $history, updated: $updated, fetched: $fetched)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StorageStateImpl &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            (identical(other.updated, updated) || other.updated == updated) &&
            (identical(other.fetched, fetched) || other.fetched == fetched));
  }

  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_history), updated, fetched);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StorageStateImplCopyWith<_$StorageStateImpl> get copyWith =>
      __$$StorageStateImplCopyWithImpl<_$StorageStateImpl>(this, _$identity);
}

abstract class _StorageState implements StorageState {
  const factory _StorageState(
      {final List<HistoryModel> history,
      final DateTime? updated,
      final DateTime? fetched}) = _$StorageStateImpl;

  @override
  List<HistoryModel> get history;
  @override
  DateTime? get updated;
  @override
  DateTime? get fetched;
  @override
  @JsonKey(ignore: true)
  _$$StorageStateImplCopyWith<_$StorageStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

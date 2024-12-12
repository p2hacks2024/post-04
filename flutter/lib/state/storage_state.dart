import 'package:epsilon_app/model/history_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';


part 'storage_state.freezed.dart';

@freezed
class StorageState with _$StorageState {
  const factory StorageState({
    List<HistoryModel>? history,
    DateTime? updated,
    DateTime? fetched,
  }) = _StorageState;
}
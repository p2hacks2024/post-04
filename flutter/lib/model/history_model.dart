import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_model.freezed.dart';
part 'history_model.g.dart';

@freezed
class HistoryModel with _$HistoryModel {
  const factory HistoryModel({
    required String colorCode,
    required DateTime created,
  }) = _HistoryModel;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => _$HistoryModelFromJson(json);
}
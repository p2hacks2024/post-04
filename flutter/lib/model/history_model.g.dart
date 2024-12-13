// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HistoryModelImpl _$$HistoryModelImplFromJson(Map<String, dynamic> json) =>
    _$HistoryModelImpl(
      colorCode: json['colorCode'] as String,
      created: DateTime.parse(json['created'] as String),
    );

Map<String, dynamic> _$$HistoryModelImplToJson(_$HistoryModelImpl instance) =>
    <String, dynamic>{
      'colorCode': instance.colorCode,
      'created': instance.created.toIso8601String(),
    };

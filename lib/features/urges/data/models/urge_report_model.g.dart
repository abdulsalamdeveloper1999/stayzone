// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'urge_report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UrgeReportModelImpl _$$UrgeReportModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UrgeReportModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      interventionType: json['intervention_type'] as String,
      reportedAt: DateTime.parse(json['reported_at'] as String),
      content: json['content'] as String?,
    );

Map<String, dynamic> _$$UrgeReportModelImplToJson(
        _$UrgeReportModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'intervention_type': instance.interventionType,
      'reported_at': instance.reportedAt.toIso8601String(),
      'content': instance.content,
    };

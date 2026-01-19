// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'focus_session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FocusSessionModelImpl _$$FocusSessionModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FocusSessionModelImpl(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      activityType: json['activity_type'] as String,
      durationMinutes: (json['duration_minutes'] as num).toInt(),
      completedMinutes: (json['completed_minutes'] as num).toInt(),
      startedAt: DateTime.parse(json['started_at'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
      title: json['title'] as String?,
      wasCompleted: json['was_completed'] as bool? ?? false,
    );

Map<String, dynamic> _$$FocusSessionModelImplToJson(
        _$FocusSessionModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'activity_type': instance.activityType,
      'duration_minutes': instance.durationMinutes,
      'completed_minutes': instance.completedMinutes,
      'started_at': instance.startedAt.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
      'title': instance.title,
      'was_completed': instance.wasCompleted,
    };

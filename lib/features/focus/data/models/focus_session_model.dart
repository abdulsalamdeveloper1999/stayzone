import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/focus_session.dart';

part 'focus_session_model.freezed.dart';
part 'focus_session_model.g.dart';

@freezed
class FocusSessionModel with _$FocusSessionModel {
  const FocusSessionModel._();

  const factory FocusSessionModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'activity_type') required String activityType,
    @JsonKey(name: 'duration_minutes') required int durationMinutes,
    @JsonKey(name: 'completed_minutes') required int completedMinutes,
    @JsonKey(name: 'started_at') required DateTime startedAt,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
    String? title,
    @JsonKey(name: 'was_completed') @Default(false) bool wasCompleted,
  }) = _FocusSessionModel;

  factory FocusSessionModel.fromJson(Map<String, dynamic> json) =>
      _$FocusSessionModelFromJson(json);

  FocusSessionEntity toEntity() {
    return FocusSessionEntity(
      id: id,
      userId: userId,
      activityType: activityType,
      durationMinutes: durationMinutes,
      completedMinutes: completedMinutes,
      startedAt: startedAt,
      completedAt: completedAt,
      title: title,
      wasCompleted: wasCompleted,
    );
  }
}

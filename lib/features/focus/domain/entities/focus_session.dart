class FocusSessionEntity {
  final String id;
  final String userId;
  final String activityType;
  final int durationMinutes;
  final int completedMinutes;
  final DateTime startedAt;
  final DateTime? completedAt;
  final String? title;
  final bool wasCompleted;

  const FocusSessionEntity({
    required this.id,
    required this.userId,
    required this.activityType,
    required this.durationMinutes,
    required this.completedMinutes,
    required this.startedAt,
    this.completedAt,
    this.title,
    this.wasCompleted = false,
  });
}

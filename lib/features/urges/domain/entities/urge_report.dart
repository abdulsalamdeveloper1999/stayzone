class UrgeReportEntity {
  final String id;
  final String userId;
  final String interventionType;
  final DateTime reportedAt;
  final String? content;

  const UrgeReportEntity({
    required this.id,
    required this.userId,
    required this.interventionType,
    required this.reportedAt,
    this.content,
  });
}

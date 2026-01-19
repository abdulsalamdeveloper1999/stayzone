import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/urge_report.dart';

part 'urge_report_model.freezed.dart';
part 'urge_report_model.g.dart';

@freezed
class UrgeReportModel with _$UrgeReportModel {
  const UrgeReportModel._();

  const factory UrgeReportModel({
    required String id,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'intervention_type') required String interventionType,
    @JsonKey(name: 'reported_at') required DateTime reportedAt,
    String? content,
  }) = _UrgeReportModel;

  factory UrgeReportModel.fromJson(Map<String, dynamic> json) =>
      _$UrgeReportModelFromJson(json);

  UrgeReportEntity toEntity() {
    return UrgeReportEntity(
      id: id,
      userId: userId,
      interventionType: interventionType,
      reportedAt: reportedAt,
      content: content,
    );
  }
}

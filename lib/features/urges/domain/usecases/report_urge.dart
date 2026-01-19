import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/urge_report.dart';
import '../repositories/urge_repository.dart';

@lazySingleton
class ReportUrge implements UseCase<UrgeReportEntity, ReportUrgeParams> {
  final UrgeRepository repository;

  ReportUrge(this.repository);

  @override
  Future<Either<Failure, UrgeReportEntity>> call(ReportUrgeParams params) {
    return repository.reportUrge(
      userId: params.userId,
      interventionType: params.interventionType,
      content: params.content,
    );
  }
}

class ReportUrgeParams {
  final String userId;
  final String interventionType;
  final String? content;

  ReportUrgeParams({
    required this.userId,
    required this.interventionType,
    this.content,
  });
}

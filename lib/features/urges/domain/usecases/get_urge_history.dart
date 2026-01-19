import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/urge_report.dart';
import '../repositories/urge_repository.dart';

@lazySingleton
class GetUrgeHistory implements UseCase<List<UrgeReportEntity>, String> {
  final UrgeRepository repository;

  GetUrgeHistory(this.repository);

  @override
  Future<Either<Failure, List<UrgeReportEntity>>> call(String userId) async {
    return await repository.getUrgeHistory(userId);
  }
}

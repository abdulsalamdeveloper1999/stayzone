import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/urge_report.dart';

abstract class UrgeRepository {
  Future<Either<Failure, UrgeReportEntity>> reportUrge({
    required String userId,
    required String interventionType,
  });

  Future<Either<Failure, int>> getTodayUrgesCount(String userId);
}

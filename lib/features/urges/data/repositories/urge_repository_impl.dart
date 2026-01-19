import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/urge_report.dart';
import '../../domain/repositories/urge_repository.dart';
import '../datasources/urge_remote_data_source.dart';

@LazySingleton(as: UrgeRepository)
class UrgeRepositoryImpl implements UrgeRepository {
  final UrgeRemoteDataSource remoteDataSource;

  UrgeRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UrgeReportEntity>> reportUrge({
    required String userId,
    required String interventionType,
    String? content,
  }) async {
    try {
      final model = await remoteDataSource.reportUrge(
        userId: userId,
        interventionType: interventionType,
        content: content,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTodayUrgesCount(String userId) async {
    try {
      final count = await remoteDataSource.getTodayUrgesCount(userId);
      return Right(count);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<UrgeReportEntity>>> getUrgeHistory(
    String userId,
  ) async {
    try {
      final models = await remoteDataSource.getUrgeHistory(userId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

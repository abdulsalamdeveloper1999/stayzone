import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/focus_session.dart';
import '../../domain/repositories/focus_repository.dart';
import '../datasources/focus_remote_data_source.dart';

@LazySingleton(as: FocusRepository)
class FocusRepositoryImpl implements FocusRepository {
  final FocusRemoteDataSource remoteDataSource;

  FocusRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, FocusSessionEntity>> createSession({
    required String userId,
    required String activityType,
    required int durationMinutes,
  }) async {
    try {
      final model = await remoteDataSource.createSession(
        userId: userId,
        activityType: activityType,
        durationMinutes: durationMinutes,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, FocusSessionEntity>> completeSession({
    required String sessionId,
    required int completedMinutes,
  }) async {
    try {
      final model = await remoteDataSource.completeSession(
        sessionId: sessionId,
        completedMinutes: completedMinutes,
      );
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getTodaysFocusMinutes(String userId) async {
    try {
      final minutes = await remoteDataSource.getTodaysFocusMinutes(userId);
      return Right(minutes);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, int>> getUserStreak(String userId) async {
    try {
      final streak = await remoteDataSource.getUserStreak(userId);
      return Right(streak);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

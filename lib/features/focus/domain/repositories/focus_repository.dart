import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/focus_session.dart';

abstract class FocusRepository {
  Future<Either<Failure, FocusSessionEntity>> createSession({
    required String userId,
    required String activityType,
    required int durationMinutes,
  });

  Future<Either<Failure, FocusSessionEntity>> completeSession({
    required String sessionId,
    required int completedMinutes,
  });

  Future<Either<Failure, int>> getTodaysFocusMinutes(String userId);

  Future<Either<Failure, int>> getUserStreak(String userId);
}

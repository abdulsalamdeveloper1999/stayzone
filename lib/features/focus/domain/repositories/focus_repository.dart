import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/focus_session.dart';
import '../entities/monk_stats.dart';

abstract class FocusRepository {
  Future<Either<Failure, FocusSessionEntity>> createSession({
    required String userId,
    required String activityType,
    required int durationMinutes,
    String? title,
  });

  Future<Either<Failure, FocusSessionEntity>> completeSession({
    required String sessionId,
    required int completedMinutes,
  });

  Future<Either<Failure, int>> getTodaysFocusMinutes(String userId);

  Future<Either<Failure, int>> getUserStreak(String userId);

  Future<Either<Failure, List<FocusSessionEntity>>> getFocusHistory(
    String userId,
  );

  Future<Either<Failure, MonkStatsEntity>> getMonkStats();
}

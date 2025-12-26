import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';

@lazySingleton
class CreateFocusSession
    implements UseCase<FocusSessionEntity, CreateFocusSessionParams> {
  final FocusRepository repository;

  CreateFocusSession(this.repository);

  @override
  Future<Either<Failure, FocusSessionEntity>> call(
    CreateFocusSessionParams params,
  ) {
    return repository.createSession(
      userId: params.userId,
      activityType: params.activityType,
      durationMinutes: params.durationMinutes,
    );
  }
}

class CreateFocusSessionParams {
  final String userId;
  final String activityType;
  final int durationMinutes;

  CreateFocusSessionParams({
    required this.userId,
    required this.activityType,
    required this.durationMinutes,
  });
}

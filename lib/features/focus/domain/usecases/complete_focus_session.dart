import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';

@lazySingleton
class CompleteFocusSession
    implements UseCase<FocusSessionEntity, CompleteFocusSessionParams> {
  final FocusRepository repository;

  CompleteFocusSession(this.repository);

  @override
  Future<Either<Failure, FocusSessionEntity>> call(
    CompleteFocusSessionParams params,
  ) {
    return repository.completeSession(
      sessionId: params.sessionId,
      completedMinutes: params.completedMinutes,
    );
  }
}

class CompleteFocusSessionParams {
  final String sessionId;
  final int completedMinutes;

  CompleteFocusSessionParams({
    required this.sessionId,
    required this.completedMinutes,
  });
}

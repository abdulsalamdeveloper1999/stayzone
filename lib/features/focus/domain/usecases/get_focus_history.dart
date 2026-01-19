import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/focus_session.dart';
import '../repositories/focus_repository.dart';

@lazySingleton
class GetFocusHistory implements UseCase<List<FocusSessionEntity>, String> {
  final FocusRepository repository;

  GetFocusHistory(this.repository);

  @override
  Future<Either<Failure, List<FocusSessionEntity>>> call(String userId) async {
    return await repository.getFocusHistory(userId);
  }
}

import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/focus_repository.dart';

@lazySingleton
class GetUserStreak implements UseCase<int, String> {
  final FocusRepository repository;

  GetUserStreak(this.repository);

  @override
  Future<Either<Failure, int>> call(String userId) {
    return repository.getUserStreak(userId);
  }
}

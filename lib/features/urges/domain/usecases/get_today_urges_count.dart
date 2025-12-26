import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/urge_repository.dart';

@lazySingleton
class GetTodayUrgesCount implements UseCase<int, String> {
  final UrgeRepository repository;

  GetTodayUrgesCount(this.repository);

  @override
  Future<Either<Failure, int>> call(String userId) {
    return repository.getTodayUrgesCount(userId);
  }
}

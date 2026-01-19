import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/monk_stats.dart';
import '../repositories/focus_repository.dart';

@lazySingleton
class GetMonkStats implements UseCase<MonkStatsEntity, NoParams> {
  final FocusRepository repository;

  GetMonkStats(this.repository);

  @override
  Future<Either<Failure, MonkStatsEntity>> call(NoParams params) {
    return repository.getMonkStats();
  }
}

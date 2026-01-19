import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/subscription_repository.dart';

@injectable
class HasPremiumAccess implements UseCase<bool, NoParams> {
  final SubscriptionRepository repository;

  HasPremiumAccess(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.hasPremiumAccess();
  }
}

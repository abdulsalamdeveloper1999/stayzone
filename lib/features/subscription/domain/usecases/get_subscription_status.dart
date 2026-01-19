import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

@injectable
class GetSubscriptionStatus implements UseCase<SubscriptionEntity, NoParams> {
  final SubscriptionRepository repository;

  GetSubscriptionStatus(this.repository);

  @override
  Future<Either<Failure, SubscriptionEntity>> call(NoParams params) async {
    return repository.getSubscriptionStatus();
  }
}

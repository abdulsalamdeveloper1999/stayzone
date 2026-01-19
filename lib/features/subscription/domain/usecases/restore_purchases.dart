import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/subscription_entity.dart';
import '../repositories/subscription_repository.dart';

@injectable
class RestorePurchases implements UseCase<SubscriptionEntity, NoParams> {
  final SubscriptionRepository repository;

  RestorePurchases(this.repository);

  @override
  Future<Either<Failure, SubscriptionEntity>> call(NoParams params) async {
    return await repository.restorePurchases();
  }
}

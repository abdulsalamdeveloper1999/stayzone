import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/subscription_product.dart';
import '../repositories/subscription_repository.dart';

class PurchaseSubscriptionParams {
  final SubscriptionProduct product;

  PurchaseSubscriptionParams(this.product);
}

@injectable
class PurchaseSubscription
    implements UseCase<void, PurchaseSubscriptionParams> {
  final SubscriptionRepository repository;

  PurchaseSubscription(this.repository);

  @override
  Future<Either<Failure, void>> call(PurchaseSubscriptionParams params) async {
    return await repository.purchaseSubscription(params.product);
  }
}

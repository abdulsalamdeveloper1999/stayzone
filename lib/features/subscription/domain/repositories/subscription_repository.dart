import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/subscription_entity.dart';
import '../entities/subscription_product.dart';

abstract class SubscriptionRepository {
  /// Get available subscription products (offerings)
  Future<Either<Failure, List<SubscriptionProduct>>> getOfferings();

  /// Get current subscription status for the logged-in user
  Future<Either<Failure, SubscriptionEntity>> getSubscriptionStatus();

  /// Purchase a subscription
  Future<Either<Failure, SubscriptionEntity>> purchaseSubscription(
    SubscriptionProduct product,
  );

  /// Restore previous purchases
  Future<Either<Failure, SubscriptionEntity>> restorePurchases();

  /// Cancel/update subscription (for management)
  Future<Either<Failure, void>> cancelSubscription();

  /// Check if user has premium access
  Future<Either<Failure, bool>> hasPremiumAccess();
}

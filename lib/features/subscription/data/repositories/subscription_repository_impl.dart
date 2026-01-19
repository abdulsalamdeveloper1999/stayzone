import 'package:fpdart/fpdart.dart';
import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/subscription_product.dart';
import '../../domain/entities/subscription_status.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../datasources/subscription_remote_data_source.dart';

@LazySingleton(as: SubscriptionRepository)
class SubscriptionRepositoryImpl implements SubscriptionRepository {
  final SubscriptionRemoteDataSource remoteDataSource;

  SubscriptionRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<SubscriptionProduct>>> getOfferings() async {
    try {
      final offerings = await Purchases.getOfferings();
      final current = offerings.current;

      if (current == null) {
        return Right([]);
        // return Left(ServerFailure('No offerings configured in RevenueCat'));
      }

      final products = <SubscriptionProduct>[];

      void addProduct(Package? package) {
        if (package != null) {
          final product = package.storeProduct;
          products.add(
            SubscriptionProduct(
              id: product.identifier,
              title: product.title,
              description: product.description,
              price: product.price.toString(),
              priceString: product.priceString,
              introPrice: product.introductoryPrice?.priceString,
              introPricePeriod: product.introductoryPrice?.period,
              introPricePeriodUnit: product.introductoryPrice?.periodUnit.name,
              introPricePeriodNumberOfUnits:
                  product.introductoryPrice?.periodNumberOfUnits,
              hasFreeTrial:
                  product.introductoryPrice != null &&
                  product.introductoryPrice!.price == 0,
              originalPackage: package,
            ),
          );
        }
      }

      addProduct(current.annual);
      addProduct(current.monthly);
      // addProduct(current.weekly); // Add if needed

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Failed to fetch offerings: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity>> getSubscriptionStatus() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return Right(_customerInfoToSubscription(customerInfo));
    } catch (e) {
      return Left(ServerFailure('Failed to get subscription: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, bool>> hasPremiumAccess() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      final hasPremium =
          customerInfo.entitlements.active.containsKey(
            'pro', // Using 'pro' as standard entitlement identifier
          ) ||
          customerInfo.entitlements.active.containsKey('premium');
      return Right(hasPremium);
    } catch (e) {
      return Left(
        ServerFailure('Failed to check premium access: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity>> purchaseSubscription(
    SubscriptionProduct product,
  ) async {
    try {
      final package = product.originalPackage as Package?;
      if (package == null) {
        return Left(ServerFailure('Invalid product package'));
      }

      final customerInfo = await Purchases.purchasePackage(package);
      return Right(_customerInfoToSubscription(customerInfo));
    } catch (e) {
      return Left(ServerFailure('Purchase failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, SubscriptionEntity>> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      return Right(_customerInfoToSubscription(customerInfo));
    } catch (e) {
      return Left(ServerFailure('Restore failed: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> cancelSubscription() async {
    return Left(
      ServerFailure(
        'Please cancel your subscription through the App Store or Play Store',
      ),
    );
  }

  SubscriptionEntity _customerInfoToSubscription(CustomerInfo customerInfo) {
    // Check for both 'pro' and 'premium' to be safe
    final hasEntitlement =
        customerInfo.entitlements.active.containsKey('pro') ||
        customerInfo.entitlements.active.containsKey('premium');

    if (!hasEntitlement) {
      return SubscriptionEntity(
        id: customerInfo.originalAppUserId,
        userId: customerInfo.originalAppUserId,
        status: SubscriptionStatus.free,
        platform: '',
        createdAt: DateTime.now(),
      );
    }

    final entitlement =
        customerInfo.entitlements.active['pro'] ??
        customerInfo.entitlements.active['premium'];

    // Fallback if somehow null despite check
    if (entitlement == null) {
      return SubscriptionEntity(
        id: customerInfo.originalAppUserId,
        userId: customerInfo.originalAppUserId,
        status: SubscriptionStatus.free,
        platform: '',
        createdAt: DateTime.now(),
      );
    }

    final expiresAt = entitlement.expirationDate;
    final productId = entitlement.productIdentifier;

    SubscriptionStatus status = SubscriptionStatus.free; // Default

    // Simple heuristic - rely on product ID containing string
    if (productId.toLowerCase().contains('monthly')) {
      status = SubscriptionStatus.premiumMonthly;
    } else if (productId.toLowerCase().contains('yearly') ||
        productId.toLowerCase().contains('annual')) {
      status = SubscriptionStatus.premiumYearly;
    } else {
      // If we can't determine type but have entitlement, default to Monthly or similar to show active state
      status = SubscriptionStatus.premiumMonthly;
    }

    return SubscriptionEntity(
      id: customerInfo.originalAppUserId,
      userId: customerInfo.originalAppUserId,
      status: status,
      expiresAt: expiresAt != null ? DateTime.parse(expiresAt) : null,
      transactionId: entitlement.identifier,
      platform: entitlement.store.name,
      createdAt: DateTime.now(),
    );
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/subscription_product.dart';
import '../../domain/repositories/subscription_repository.dart';
import '../../domain/usecases/get_subscription_status.dart';
import '../../domain/usecases/has_premium_access.dart';
import '../../domain/usecases/purchase_subscription.dart';
import '../../domain/usecases/restore_purchases.dart';
import 'subscription_state.dart';

@injectable
class SubscriptionCubit extends Cubit<SubscriptionState> {
  final GetSubscriptionStatus _getSubscriptionStatus;
  final HasPremiumAccess _hasPremiumAccess;
  final PurchaseSubscription _purchaseSubscription;
  final RestorePurchases _restorePurchases;
  final SubscriptionRepository
  _repository; // Direct usage for getOfferings if usecase not created

  SubscriptionCubit(
    this._getSubscriptionStatus,
    this._hasPremiumAccess,
    this._purchaseSubscription,
    this._restorePurchases,
    this._repository,
  ) : super(SubscriptionInitial());

  /// Load offerings (products)
  Future<void> loadOfferings() async {
    emit(SubscriptionLoading());
    final result = await _repository.getOfferings();
    result.fold(
      (failure) => emit(SubscriptionError(failure.message)),
      (products) => emit(SubscriptionLoadedOfferings(products)),
    );
  }

  /// Load current subscription status
  Future<void> loadSubscriptionStatus() async {
    emit(SubscriptionLoading());
    final result = await _getSubscriptionStatus(NoParams());
    result.fold(
      (failure) => emit(SubscriptionError(failure.message)),
      (subscription) => emit(SubscriptionLoaded(subscription)),
    );
  }

  /// Check if user has premium access
  Future<bool> checkPremiumAccess() async {
    final result = await _hasPremiumAccess(NoParams());
    return result.fold((_) => false, (isPremium) => isPremium);
  }

  /// Purchase a subscription
  Future<void> purchaseSubscription(SubscriptionProduct product) async {
    emit(SubscriptionPurchasing());
    final result = await _purchaseSubscription(
      PurchaseSubscriptionParams(product),
    );
    result.fold(
      (failure) => emit(SubscriptionError(failure.message)),
      (_) => emit(const SubscriptionPurchaseSuccess()),
    );
  }

  /// Restore previous purchases
  Future<void> restorePurchases() async {
    emit(SubscriptionRestoring());
    final result = await _restorePurchases(NoParams());
    result.fold(
      (failure) => emit(SubscriptionError(failure.message)),
      (subscription) => emit(SubscriptionRestoreSuccess(subscription)),
    );
  }
}

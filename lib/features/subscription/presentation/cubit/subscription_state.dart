import 'package:equatable/equatable.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/subscription_product.dart';

abstract class SubscriptionState extends Equatable {
  const SubscriptionState();

  @override
  List<Object?> get props => [];
}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState {}

class SubscriptionLoadedOfferings extends SubscriptionState {
  final List<SubscriptionProduct> products;

  const SubscriptionLoadedOfferings(this.products);

  @override
  List<Object> get props => [products];
}

class SubscriptionLoaded extends SubscriptionState {
  final SubscriptionEntity subscription;

  const SubscriptionLoaded(this.subscription);

  bool get isPremium => subscription.isActive;

  @override
  List<Object> get props => [subscription];
}

class SubscriptionPurchasing extends SubscriptionState {}

class SubscriptionPurchaseSuccess extends SubscriptionState {
  const SubscriptionPurchaseSuccess();
}

class SubscriptionRestoring extends SubscriptionState {}

class SubscriptionRestoreSuccess extends SubscriptionState {
  final SubscriptionEntity subscription;

  const SubscriptionRestoreSuccess(this.subscription);

  @override
  List<Object> get props => [subscription];
}

class SubscriptionError extends SubscriptionState {
  final String message;

  const SubscriptionError(this.message);

  @override
  List<Object> get props => [message];
}

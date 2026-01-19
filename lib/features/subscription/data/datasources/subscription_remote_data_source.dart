import 'package:injectable/injectable.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/subscription_entity.dart';
import '../../domain/entities/subscription_status.dart';

abstract class SubscriptionRemoteDataSource {
  Future<SubscriptionEntity> getSubscriptionStatus(String userId);
  Future<SubscriptionEntity> syncSubscriptionToSupabase(
    String userId,
    CustomerInfo customerInfo,
  );
}

@LazySingleton(as: SubscriptionRemoteDataSource)
class SubscriptionRemoteDataSourceImpl implements SubscriptionRemoteDataSource {
  final SupabaseClient supabaseClient;

  SubscriptionRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<SubscriptionEntity> getSubscriptionStatus(String userId) async {
    try {
      final response = await supabaseClient
          .from('subscriptions')
          .select()
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(1)
          .maybeSingle();

      if (response == null) {
        // Return free tier for users without subscriptions
        return SubscriptionEntity(
          id: '',
          userId: userId,
          status: SubscriptionStatus.free,
          platform: '',
          createdAt: DateTime.now(),
        );
      }

      return _subscriptionFromJson(response);
    } catch (e) {
      throw ServerFailure('Failed to get subscription status: ${e.toString()}');
    }
  }

  @override
  Future<SubscriptionEntity> syncSubscriptionToSupabase(
    String userId,
    CustomerInfo customerInfo,
  ) async {
    try {
      final hasPremium = customerInfo.entitlements.active.containsKey(
        'premium',
      );

      if (!hasPremium) {
        return SubscriptionEntity(
          id: userId,
          userId: userId,
          status: SubscriptionStatus.free,
          platform: '',
          createdAt: DateTime.now(),
        );
      }

      final entitlement = customerInfo.entitlements.active['premium']!;
      final expiresAt = entitlement.expirationDate;
      final productId = entitlement.productIdentifier;

      // Determine subscription type
      SubscriptionStatus status = SubscriptionStatus.free;
      if (productId.contains('monthly')) {
        status = SubscriptionStatus.premiumMonthly;
      } else if (productId.contains('yearly') || productId.contains('annual')) {
        status = SubscriptionStatus.premiumYearly;
      }

      // Sync to Supabase
      final response = await supabaseClient
          .from('subscriptions')
          .upsert({
            'user_id': userId,
            'status': status.name,
            'platform': entitlement.store.name,
            'transaction_id': entitlement.identifier,
            'expires_at': expiresAt,
          })
          .select()
          .single();

      return _subscriptionFromJson(response);
    } catch (e) {
      throw ServerFailure('Failed to sync subscription: ${e.toString()}');
    }
  }

  SubscriptionEntity _subscriptionFromJson(Map<String, dynamic> json) {
    return SubscriptionEntity(
      id: json['id'] ?? '',
      userId: json['user_id'],
      status: SubscriptionStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => SubscriptionStatus.free,
      ),
      expiresAt: json['expires_at'] != null
          ? DateTime.parse(json['expires_at'])
          : null,
      transactionId: json['transaction_id'],
      platform: json['platform'] ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
    );
  }
}

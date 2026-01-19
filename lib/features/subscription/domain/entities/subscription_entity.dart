import 'subscription_status.dart';

class SubscriptionEntity {
  final String id;
  final String userId;
  final SubscriptionStatus status;
  final DateTime? expiresAt;
  final String? transactionId;
  final String platform; // 'ios' or 'android'
  final DateTime createdAt;

  const SubscriptionEntity({
    required this.id,
    required this.userId,
    required this.status,
    this.expiresAt,
    this.transactionId,
    required this.platform,
    required this.createdAt,
  });

  bool get isPremium => status.isPremium;

  bool get isExpired {
    if (expiresAt == null) return status == SubscriptionStatus.free;
    return DateTime.now().isAfter(expiresAt!);
  }

  bool get isActive => isPremium && !isExpired;

  // Calculate days until expiry
  int? get daysUntilExpiry {
    if (expiresAt == null) return null;
    return expiresAt!.difference(DateTime.now()).inDays;
  }
}

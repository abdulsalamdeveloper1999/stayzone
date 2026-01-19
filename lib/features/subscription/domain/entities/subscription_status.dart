enum SubscriptionStatus {
  free,
  premiumMonthly,
  premiumYearly;

  bool get isPremium => this != SubscriptionStatus.free;

  String get displayName {
    switch (this) {
      case SubscriptionStatus.free:
        return 'Free';
      case SubscriptionStatus.premiumMonthly:
        return 'Premium Monthly';
      case SubscriptionStatus.premiumYearly:
        return 'Premium Yearly';
    }
  }

  String get priceId {
    switch (this) {
      case SubscriptionStatus.free:
        return '';
      case SubscriptionStatus.premiumMonthly:
        return 'stayzone_premium_monthly';
      case SubscriptionStatus.premiumYearly:
        return 'stayzone_premium_yearly';
    }
  }

  double get monthlyPrice {
    switch (this) {
      case SubscriptionStatus.free:
        return 0.0;
      case SubscriptionStatus.premiumMonthly:
        return 4.99;
      case SubscriptionStatus.premiumYearly:
        return 3.33; // 39.99/12
    }
  }

  double get yearlyPrice {
    switch (this) {
      case SubscriptionStatus.free:
        return 0.0;
      case SubscriptionStatus.premiumMonthly:
        return 59.88;
      case SubscriptionStatus.premiumYearly:
        return 39.99;
    }
  }
}

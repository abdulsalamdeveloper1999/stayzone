class SubscriptionProduct {
  final String id;
  final String title;
  final String description;
  final String price;
  final String priceString;
  final String? introPrice; // e.g. "Free" or "$1.99"
  final String? introPricePeriod; // e.g. "P1W" (ISO 8601) or "1 week"
  final String? introPricePeriodUnit; // e.g. "DAY", "WEEK", "MONTH", "YEAR"
  final int? introPricePeriodNumberOfUnits;
  final bool hasFreeTrial; // Derived convenience
  final dynamic
  originalPackage; // Kept for passing back to purchase method (leaky abstraction but pragmatic)

  const SubscriptionProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.priceString,
    this.introPrice,
    this.introPricePeriod,
    this.introPricePeriodUnit,
    this.introPricePeriodNumberOfUnits,
    this.hasFreeTrial = false,
    this.originalPackage,
  });
}

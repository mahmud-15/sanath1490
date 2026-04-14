class SubscriptionModel {
  final String name;
  final String monthlyPrice;
  final String annualPrice;
  final String listingLimit;
  final List<String> features;
  final bool isCurrentPlan;
  final bool isMostPopular;

  const SubscriptionModel({
    required this.name,
    required this.monthlyPrice,
    required this.annualPrice,
    required this.listingLimit,
    required this.features,
    this.isCurrentPlan = false,
    this.isMostPopular = false,
  });
}

class CurrentPlanModel {
  final String planName;
  final String nextBillingDate;
  final String amount;

  const CurrentPlanModel({
    required this.planName,
    required this.nextBillingDate,
    required this.amount,
  });
}
import 'package:get/get.dart';

import '../../../../../../utils/log_print.dart';
import '../model/subscriptionModel.dart';

class SubscriptionController extends GetxController {
  // ─── Billing Toggle ───────────────────────────────
  // 0 = Monthly, 1 = Annual
  final RxInt selectedBillingIndex = 0.obs;

  bool get isAnnual => selectedBillingIndex.value == 1;

  void onBillingToggle(int index) {
    try {
      selectedBillingIndex.value = index;
    } catch (e) {
      errorLog('onBillingToggle', e);
    }
  }

  // ─── Current Plan ─────────────────────────────────
  final currentPlan = const CurrentPlanModel(
    planName: 'Professional',
    nextBillingDate: 'April 10, 2024',
    amount: '£99.00',
  );

  // ─── Plans ────────────────────────────────────────
  final List<SubscriptionModel> plans = const [
    SubscriptionModel(
      name: 'Basic',
      monthlyPrice: '£49',
      annualPrice: '£400',
      listingLimit: 'Up to 10 listings',
      features: [
        'Up to 10 property listings',
        'Basic analytics',
        'Email support',
        'Property alerts',
        'Mobile app access',
      ],
      isCurrentPlan: false,
      isMostPopular: false,
    ),
    SubscriptionModel(
      name: 'Professional',
      monthlyPrice: '£99',
      annualPrice: '£1000',
      listingLimit: 'Up to 50 listings',
      features: [
        'Up to 50 property listings',
        '5 featured listings per month',
        'Advanced analytics & insights',
        'Priority email & phone support',
        'Lead management tools',
        'Custom branding',
        'Mobile app access',
      ],
      isCurrentPlan: true,
      isMostPopular: true,
    ),
  ];

  // ─── Actions ──────────────────────────────────────
  void onBillingHistoryTap() {
    try {
      // Get.toNamed(AppRoutes.billingHistory);
    } catch (e) {
      errorLog('onBillingHistoryTap', e);
    }
  }

  void onUpgradeTap(SubscriptionModel plan) {
    try {
      // Get.toNamed(AppRoutes.payment, arguments: plan);
    } catch (e) {
      errorLog('onUpgradeTap', e);
    }
  }
}
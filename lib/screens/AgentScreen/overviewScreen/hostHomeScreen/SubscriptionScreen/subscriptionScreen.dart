import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/overviewScreen/hostHomeScreen/SubscriptionScreen/widget/billingToggle.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/overviewScreen/hostHomeScreen/SubscriptionScreen/widget/currentPlanBanner.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/overviewScreen/hostHomeScreen/SubscriptionScreen/widget/subscriptionPlanCard.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import 'controller/subscriptionController.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // ─── App Bar ──────────────────────────
          SliverToBoxAdapter(
            child: _SubscriptionAppBar(),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          // ─── Current Plan Banner ──────────────
          SliverToBoxAdapter(
            child: CurrentPlanBanner(
              plan: controller.currentPlan,
              onBillingHistoryTap: controller.onBillingHistoryTap,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // ─── Billing Toggle ───────────────────
          SliverToBoxAdapter(
            child: Obx(() => BillingToggle(
              selectedIndex: controller.selectedBillingIndex.value,
              onToggle: controller.onBillingToggle,
            )),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // ─── Plan Cards ───────────────────────
          SliverToBoxAdapter(
            child:  ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemCount: controller.plans.length,
              separatorBuilder: (_, __) => SizedBox(height: 24.h),
              itemBuilder: (context, index) {
                final plan = controller.plans[index];
                return SubscriptionPlanCard(
                  plan: plan,
                  isAnnual: controller.isAnnual,
                  onUpgradeTap: () => controller.onUpgradeTap(plan),
                );
              },
            )),


          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _SubscriptionAppBar extends StatelessWidget {
  const _SubscriptionAppBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        bottom: 16.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        children: [
          // ─── Back Button ───────────────────
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.white,
                size: 18.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),

          // ─── Title ─────────────────────────
          CustomText(
            title: ConstString.subscription,
            textColor: Colors.white,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
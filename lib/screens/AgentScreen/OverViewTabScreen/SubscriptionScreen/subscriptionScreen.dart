import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/SubscriptionScreen/widget/billingToggle.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/SubscriptionScreen/widget/currentPlanBanner.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/SubscriptionScreen/widget/subscriptionPlanCard.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AuthAppBar/global_app_bar.dart';
import 'controller/subscriptionController.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SubscriptionController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,

      appBar: const GlobalAppBar(title: ConstString.subscription),

      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: SizedBox(height: 16.h)),

          SliverToBoxAdapter(
            child: CurrentPlanBanner(
              plan: controller.currentPlan,
              onBillingHistoryTap: controller.onBillingHistoryTap,
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          SliverToBoxAdapter(
            child: Obx(() => BillingToggle(
              selectedIndex: controller.selectedBillingIndex.value,
              onToggle: controller.onBillingToggle,
            )),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          SliverToBoxAdapter(
            child: Obx(() {
              final isAnnual = controller.selectedBillingIndex.value == 1;

              return ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.plans.length,
                separatorBuilder: (_, _) => SizedBox(height: 24.h),
                itemBuilder: (context, index) {
                  final plan = controller.plans[index];
                  return SubscriptionPlanCard(
                    plan: plan,
                    isAnnual: isAnnual,
                    onUpgradeTap: () => controller.onUpgradeTap(plan),
                  );
                },
              );
            }),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}
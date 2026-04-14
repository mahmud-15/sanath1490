import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../constant/const_string.dart';
import '../../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../model/subscriptionModel.dart';

class SubscriptionPlanCard extends StatelessWidget {
  final SubscriptionModel plan;
  final bool isAnnual;
  final VoidCallback onUpgradeTap;

  const SubscriptionPlanCard({
    super.key,
    required this.plan,
    required this.isAnnual,
    required this.onUpgradeTap,
  });

  @override
  Widget build(BuildContext context) {
    final String price = isAnnual ? plan.annualPrice : plan.monthlyPrice;
    final String period = isAnnual ? 'per year' : 'per month';

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(14.r),
        border: Border.all(
          color: plan.isMostPopular
              ? ConstColor.primaryColor
              : ConstColor.borderColor,
          width: plan.isMostPopular ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Most Popular Badge ───────────────
          if (plan.isMostPopular)
            Align(
              alignment: Alignment.topCenter,
              child: Transform.translate(
                offset: Offset(0, -14.h),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: CustomText(
                    title: 'Most Popular',
                    textColor: Colors.white,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
              ),
            ),

          // ─── Card Content ─────────────────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, plan.isMostPopular ? 0 : 16.h, 16.w, 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ─── Plan Name ─────────────────
                CustomText(
                  title: plan.name,
                  textColor: ConstColor.titleColor,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),

                // ─── Price ─────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomText(
                      title: price,
                      textColor: ConstColor.titleColor,
                      textSize: 28.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(width: 4.w),
                    Padding(
                      padding: EdgeInsets.only(bottom: 4.h),
                      child: CustomText(
                        title: period,
                        textColor: ConstColor.bodyColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),

                // ─── Listing Limit ─────────────
                CustomText(
                  title: plan.listingLimit,
                  textColor: ConstColor.bodyColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
                SizedBox(height: 14.h),

                // ─── Features ──────────────────
                ...plan.features.map(
                      (feature) => Padding(
                    padding: EdgeInsets.only(bottom: 8.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_rounded,
                          color: ConstColor.primaryColor,
                          size: 16.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: CustomText(
                            title: feature,
                            textColor: ConstColor.titleColor,
                            textSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 16.h),

                // ─── Action Button ─────────────
                CustomElevatedButton(
                  onPressed: plan.isCurrentPlan ? () {} : onUpgradeTap,
                  color: plan.isCurrentPlan
                      ? ConstColor.white
                      : ConstColor.primaryColor,
                  height: 48,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomText(
                    title: plan.isCurrentPlan
                        ? ConstString.currentPlan
                        : ConstString.upgradeNow,
                    textColor: plan.isCurrentPlan
                        ? ConstColor.bodyColor
                        : Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
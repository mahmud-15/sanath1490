import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/text/custom_text.dart';
import '../model/subscriptionModel.dart';

class CurrentPlanBanner extends StatelessWidget {
  final CurrentPlanModel plan;
  final VoidCallback onBillingHistoryTap;

  const CurrentPlanBanner({
    super.key,
    required this.plan,
    required this.onBillingHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ConstColor.primaryColor,
            ConstColor.primaryDeepColor,
          ],
          stops: const [0.2, 1.0],
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Plan Name ────────────────────────
          CustomText(
            title: 'Current Plan: ${plan.planName}',
            textColor: Colors.white,
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
          SizedBox(height: 4.h),

          // ─── Billing Info ─────────────────────
          CustomText(
            title: 'Next billing date: ${plan.nextBillingDate} • ${plan.amount}',
            textColor: Colors.white.withAlpha(200),
            textSize: 12.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
          SizedBox(height: 14.h),

          // ─── Billing History Button ───────────
          GestureDetector(
            onTap: onBillingHistoryTap,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
              decoration: BoxDecoration(
                // color: Colors.white.withAlpha(30),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SvgPicture.asset("assets/icons/billing_history.svg"),
                  // Icon(Icons.receipt_outlined, color: Colors.white, size: 14.sp),
                  SizedBox(width: 6.w),
                  CustomText(
                    title: ConstString.billingHistory,
                    textColor: Colors.white,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
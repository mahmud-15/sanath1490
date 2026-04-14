import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
class PremiumPlanBanner extends StatelessWidget {
  final String planText;
  final VoidCallback onManageTap;

  const PremiumPlanBanner({
    super.key,
    required this.planText,
    required this.onManageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryDeepColor,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          Icon(Icons.star_rounded, color: Colors.amber, size: 18.sp),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              title: planText,
              textColor: Colors.white,
              textSize: 13.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),
          GestureDetector(
            onTap: onManageTap,
            child: CustomText(
              title: 'Manage',
              textColor: Colors.white,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}
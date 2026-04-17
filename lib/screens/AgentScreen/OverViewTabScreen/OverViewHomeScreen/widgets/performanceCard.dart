import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';

class PerformanceCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String value;
  final Color iconColor;
  final Color iconBgColor;

  const PerformanceCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.value,
    required this.iconColor,
    required this.iconBgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: ConstColor.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.borderColor, width: 1),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: SvgPicture.asset(
                iconPath,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(
                  iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: label,
                  textColor: ConstColor.bodyColor,
                  textSize: 11.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: value,
                  textColor: ConstColor.titleColor,
                  textSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
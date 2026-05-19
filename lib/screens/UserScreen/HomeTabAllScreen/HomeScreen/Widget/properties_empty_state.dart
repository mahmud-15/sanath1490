import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';

class PropertiesEmptyState extends StatelessWidget {
  const PropertiesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 40.h, horizontal: 24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: ConstColor.outLineColor),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Icon ─────────────────────────────
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.location_off_outlined,
                size: 32.sp,
                color: ConstColor.primaryColor.withAlpha(160),
              ),
            ),
            SizedBox(height: 16.h),

            // ─── Title ────────────────────────────
            CustomText(
              title: 'No properties nearby',
              textColor: ConstColor.titleColor,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            SizedBox(height: 6.h),

            // ─── Subtitle ─────────────────────────
            CustomText(
              title: 'We couldn\'t find any listings in your area right now. Check back soon.',
              textColor: ConstColor.bodyColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 3,
              textAlign: TextAlign.center,
              textHeight: 1.6,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';

class LogoutBottomSheet extends StatelessWidget {
  const LogoutBottomSheet({super.key});

  static void show() {
    Get.bottomSheet(
      const LogoutBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      isDismissible: true,
      enterBottomSheetDuration: const Duration(milliseconds: 300),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Handle ──────────────────────────
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ConstColor.outLineColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          // ─── Title ───────────────────────────
          CustomText(
            title: ConstString.logOut,
            textColor: ConstColor.titleColor,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 16.h),

          // ─── Content Card ─────────────────────
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(color: ConstColor.outLineColor),
            ),
            child: Column(
              children: [
                // ─── Warning Icon ─────────────────
                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEF3C6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: const Color(0xFFE17100),
                    size: 32.sp,
                  ),
                ),
                SizedBox(height: 20.h),

                // ─── Heading ──────────────────────
                CustomText(
                  title: ConstString.areYouSureWant,
                  textColor: ConstColor.titleColor,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
                SizedBox(height: 10.h),

                // ─── Subtitle ─────────────────────
                CustomText(
                  title: ConstString.youWillNeedToLog,
                  textColor: ConstColor.bodyColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 3,
                ),
                SizedBox(height: 28.h),

                // ─── Yes Logout Button ─────────────
                CustomElevatedButton(
                  onPressed: () {
                    Get.back();
                    // TODO: logout logic
                  },
                  color: ConstColor.red,
                  height: 48,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomText(
                    title: 'Yes, Logout',
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),

                // ─── Cancel Button ────────────────
                CustomElevatedButton(
                  isOutLined: true,
                  borderColor: const Color(0xFFE5E7EB),
                  elevation: 0,
                  onPressed: () => Get.back(),
                  color: ConstColor.red,
                  height: 48,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomText(
                    title: ConstString.cancel,
                    textColor: ConstColor.titleColor,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 12.h),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';

class AccountDeletedScreen extends StatelessWidget {
  const AccountDeletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: const GlobalAppBar(title: "Account Deleted"),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
              decoration: BoxDecoration(
                color: Color(0xFFFFFFFF),
                border: Border.all(color: ConstColor.outLineColor.withAlpha(190), width: 1.5),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ─── Delete Icon ──────────────────
                  Container(
                    width: 80.w,
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: Colors.red.withAlpha(15), // Made slightly lighter
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/delete_icon.svg",
                        width: 39.w,
                        height: 39.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ─── Title ───────────────────────
                  CustomText(
                    title: ConstString.accountDeleted,
                    textColor: ConstColor.titleColor,
                    textSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                  SizedBox(height: 12.h),

                  // ─── Subtitle ─────────────────────
                  CustomText(
                    title:
                    ConstString.yourAccountHasBeen,
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    textHeight: 1.5,
                    maxLine: 4,
                  ),
                  SizedBox(height: 32.h),

                  // ─── What Happens Next ────────────
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9FAFB),
                      border: Border.all(color: ConstColor.outLineColor.withAlpha(190), width: 1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: ConstString.whatHappensNext,
                          textColor: ConstColor.titleColor,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
                        SizedBox(height: 12.h),
                        const _BulletItem(text: ConstString.allPersonalInformation),
                        const _BulletItem(text: ConstString.accessToYourAccount),
                        const _BulletItem(text: ConstString.youCanCreateANew),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 6.h, right: 8.w),
            child: Container(
              width: 4.w,
              height: 4.h,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              title: text,
              textColor: ConstColor.bodyColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}
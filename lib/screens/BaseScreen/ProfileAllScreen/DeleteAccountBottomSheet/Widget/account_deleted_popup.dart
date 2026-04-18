import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';

class AccountDeletedPopup extends StatelessWidget {
  const AccountDeletedPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 36.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: ConstColor.outLineColor.withAlpha(190),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ─── Delete Icon ──────────────────
            Container(
              width: 72.w,
              height: 72.h,
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(15),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/delete_icon.svg',
                  width: 34.w,
                  height: 34.h,
                ),
              ),
            ),
            SizedBox(height: 20.h),

            // ─── Title ───────────────────────
            CustomText(
              title: ConstString.accountDeleted,
              textColor: ConstColor.titleColor,
              textSize: 20.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
            SizedBox(height: 10.h),

            // ─── Subtitle ─────────────────────
            CustomText(
              title: ConstString.yourAccountHasBeen,
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              textHeight: 1.5,
              maxLine: 4,
            ),
            SizedBox(height: 24.h),

            // ─── What Happens Next ────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(14.w),
              decoration: BoxDecoration(
                color: const Color(0xFFF9FAFB),
                border: Border.all(
                  color: ConstColor.outLineColor.withAlpha(190),
                ),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: ConstString.whatHappensNext,
                    textColor: ConstColor.titleColor,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 10.h),
                  PopupBullet(text: ConstString.allPersonalInformation),
                  PopupBullet(text: ConstString.accessToYourAccount),
                  PopupBullet(text: ConstString.youCanCreateANew),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class PopupBullet extends StatelessWidget {
  final String text;

  const PopupBullet({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 8.w),
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

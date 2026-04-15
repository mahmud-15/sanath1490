import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../../routes/app_routes/app_routes.dart';

class ListingSuccessScreen extends StatelessWidget {
  const ListingSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.propertyPublished),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ─── Clock icon ───────────────────────
            Container(
              width: 90.w,
              height: 90.w,
              decoration: BoxDecoration(
                color: Colors.amber.withAlpha(40),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(
                  Icons.access_time_outlined,
                  size: 44.sp,
                  color: Colors.amber,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // ─── Title ────────────────────────────
            CustomText(
              title: ConstString.propertySubmitted,
              textColor: ConstColor.titleColor,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),

            SizedBox(height: 10.h),

            // ─── Subtitle ─────────────────────────
            CustomText(
              title: ConstString.propertySubmittedSub,
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLine: 3,
            ),

            const Spacer(),

            // ─── View My Listing button ───────────
            CustomElevatedButton(
              onPressed: () {
                // TODO: Get.toNamed(AppRoutes.myListings);
              },
              color: ConstColor.primaryColor,
              height: 52,
              top: 0,
              left: 0,
              right: 0,
              child: CustomText(
                title: ConstString.viewMyListing,
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),

            SizedBox(height: 12.h),

            // ─── Back to Home ─────────────────────
            GestureDetector(
              onTap: () => Get.offAllNamed(AppRoutes.overViewHomescreen),
              child: CustomText(
                title: ConstString.backToHome,
                textColor: ConstColor.secondaryColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
            ),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
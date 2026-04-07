import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../text/custom_text.dart';
import 'error_snackbar_message.dart';

class AppSnackBar {

  static void error(String parameterValue, {int seconds = 6}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.red.withAlpha(230),
        animationDuration: const Duration(seconds: 2),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: ErrorSnackBarMessageWidget(errorMessage: parameterValue),
        borderRadius: 20.r,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  // --- Success Snackbar ---
  static void success(String parameterValue, {int seconds = 6}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.green.withAlpha(230),
        animationDuration: const Duration(seconds: 2),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: CustomText(
          title: parameterValue,
          textColor: Colors.white,
          textAlign: TextAlign.center,
          textSize: 16.sp,
        ),
        borderRadius: 20.r,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static void message(
      String parameterValue, {
        Color backgroundColor = Colors.grey,
        Color color = Colors.white,
        int seconds = 10,
      }) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor,
        animationDuration: const Duration(seconds: 2),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: CustomText(
          title: parameterValue,
          textColor: color,
          textSize: 16.sp,
          textAlign: TextAlign.center,
          fontWeight: FontWeight.w400,
        ),
        borderRadius: 20.r,
        padding: EdgeInsets.all(10.w),
        margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 30.h),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}
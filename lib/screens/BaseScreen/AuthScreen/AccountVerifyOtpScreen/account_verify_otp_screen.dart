import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/account_otp_verify_controller.dart';

class AccountVerifyOtpScreen extends StatelessWidget {
  const AccountVerifyOtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AccountOtpVerifyController>();

    return Obx(() => Stack(
      children: [

        // ─── Main Screen ─────────────────────
        Scaffold(
          appBar: const GlobalAppBar(),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 123.h),

                  // ─── Icon ────────────────────────────
                  Container(
                    width: 64.w,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: Center(
                      child: AppImage(
                        path: 'assets/images/security.png',
                        width: 56.w,
                        height: 56.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // ─── Title ───────────────────────────
                  CustomText(
                    title: ConstString.verifyOtp,
                    textColor: ConstColor.primaryColor,
                    textSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                  SizedBox(height: 12.h),

                  // ─── Subtitle ────────────────────────
                  CustomText(
                    title: ConstString.enterThe4Digit,
                    textColor: ConstColor.bodyColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLine: 2,
                  ),
                  SizedBox(height: 32.h),

                  _OtpPinPut(controller: controller),
                  SizedBox(height: 28.h),

                  _ResendOtpRow(controller: controller),
                  SizedBox(height: 32.h),

                  // ─── Verify Button ───────────────────
                  Obx(() {
                    final bool canPress = !controller.isLoading.value;
                    return CustomElevatedButton(
                      onPressed: canPress ? controller.verifyOtp : null,
                      color: canPress
                          ? ConstColor.primaryColor
                          : ConstColor.primaryColor.withAlpha(100),
                      height: 48,
                      left: 0,
                      right: 0,
                      top: 0,
                      child: controller.isLoading.value
                          ? const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                        ),
                      )
                          : CustomText(
                        title: ConstString.verify,
                        textColor: Colors.white,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),

        // ─── Full Screen Loader ───────────────
        if (controller.isLoading.value)
          Container(
            color: Colors.black.withAlpha(120),
            child: Center(
              child: Container(
                width: 90.w,
                height: 90.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Center(
                  child: CircularProgressIndicator(
                    color: ConstColor.primaryColor,
                    strokeWidth: 3,
                  ),
                ),
              ),
            ),
          ),

      ],
    ));
  }
}

// ─────────────────────────────────────────
class _OtpPinPut extends StatelessWidget {
  final AccountOtpVerifyController controller;

  const _OtpPinPut({required this.controller});

  @override
  Widget build(BuildContext context) {
    final defaultTheme = PinTheme(
      width: 47.w,
      height: 55.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: ConstColor.titleColor,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.outLineColor),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final focusedTheme = defaultTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.5),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    final errorTheme = defaultTheme.copyWith(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(12.r),
      ),
    );

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20.h,
      ),
      child: Pinput(
        length: 6,
        defaultPinTheme: defaultTheme,
        focusedPinTheme: focusedTheme,
        errorPinTheme: errorTheme,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        cursor: Container(
          width: 1.5.w,
          height: 24.h,
          color: ConstColor.primaryColor,
        ),
        onCompleted: (pin) => controller.verifyOtp(),
        onChanged: (pin) => controller.onPinChanged(pin),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _ResendOtpRow extends StatelessWidget {
  final AccountOtpVerifyController controller;

  const _ResendOtpRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isDone = controller.secondsRemaining.value == 0;
      return GestureDetector(
        onTap: isDone ? controller.resendOtp : null,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              title: isDone ? 'Resend OTP ' : 'Resend OTP in ',
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
            ),
            CustomText(
              title: isDone ? 'Now' : '${controller.secondsRemaining.value}s',
              textColor: ConstColor.secondaryColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ],
        ),
      );
    });
  }
}
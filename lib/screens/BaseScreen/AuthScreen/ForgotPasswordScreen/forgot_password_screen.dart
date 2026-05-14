import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/forgot_password_controller.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ForgotPasswordController>();
    final formKey    = GlobalKey<FormState>();

    return Scaffold(
      appBar: const GlobalAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 123.h),
                Container(
                  width: 64.w, height: 64.h,
                  decoration: BoxDecoration(color: ConstColor.primaryColor, borderRadius: BorderRadius.circular(18.r)),
                  child: Center(child: AppImage(path: 'assets/images/key.png', width: 56.w, height: 56.h)),
                ),
                SizedBox(height: 24.h),
                CustomText(title: ConstString.forgotPassword, textColor: ConstColor.primaryColor, textSize: 30.sp, fontWeight: FontWeight.w700, textAlign: TextAlign.center, maxLine: 1),
                SizedBox(height: 10.h),
                CustomText(title: ConstString.noWorriesEnterYourEmail, textColor: ConstColor.bodyColor, textSize: 14.sp, fontWeight: FontWeight.w400, textAlign: TextAlign.center, maxLine: 3),
                SizedBox(height: 32.h),
                CustomTextFormField(
                  fromTitle: ConstString.email,
                  textController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: const CustomText(title: ConstString.yourEmailExample, textColor: Colors.grey, textSize: 13),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset('assets/icons/email.svg', width: 19.w, height: 19.h, colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: 17.h),
                Obx(() => CustomElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () { if (formKey.currentState!.validate()) controller.sendOtp(); },
                  color: controller.isLoading.value
                      ? ConstColor.primaryColor.withAlpha(100)
                      : ConstColor.primaryColor,
                  height: 48, left: 0, right: 0, top: 0,
                  child: CustomText(title: ConstString.sendOtp, textColor: ConstColor.backgroundColor, textSize: 16.sp, fontWeight: FontWeight.w700),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
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
import 'Controller/reset_password_controller.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ResetPasswordController>();
    final formKey = GlobalKey<FormState>();

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
                SizedBox(height: 62.h),

                Container(
                  width: 64.w,
                  height: 64.h,
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: AppImage(
                      path: 'assets/images/reset_password.png',
                      width: 56.w,
                      height: 56.h,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                CustomText(
                  title: ConstString.resetPassword,
                  textColor: ConstColor.primaryColor,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                SizedBox(height: 10.h),

                CustomText(
                  title: ConstString.createANewStrongPassword,
                  textColor: ConstColor.bodyColor,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 3,
                ),
                SizedBox(height: 22.h),

                Obx(
                  () => CustomTextFormField(
                    fromTitle: ConstString.newPassword,
                    textController: controller.passwordController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    obscureText: controller.obscurePassword.value,
                    hintText: const CustomText(
                      title: ConstString.createAStrongPassword,
                      textColor: Colors.grey,
                      textSize: 13,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        'assets/icons/lock_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(
                          ConstColor.iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 44.w,
                      minHeight: 44.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: controller.togglePassword,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SvgPicture.asset(
                          controller.obscurePassword.value
                              ? 'assets/icons/eye_off_icon.svg'
                              : 'assets/icons/password_icon.svg',
                          width: 19.w,
                          height: 19.h,
                          colorFilter: const ColorFilter.mode(
                            ConstColor.iconColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 44.w,
                      minHeight: 44.h,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter your new password';
                      }
                      if (value.length < 8) return ConstString.min8Character;
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 10.h),

                Obx(
                  () => CustomTextFormField(
                    fromTitle: ConstString.confirmNewPassword,
                    textController: controller.confirmPasswordController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    obscureText: controller.obscureConfirmPassword.value,
                    hintText: const CustomText(
                      title: ConstString.reEnterYourPassword,
                      textColor: Colors.grey,
                      textSize: 13,
                    ),
                    prefixIcon: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        'assets/icons/lock_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(
                          ConstColor.iconColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 44.w,
                      minHeight: 44.h,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: controller.toggleConfirmPassword,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12.w),
                        child: SvgPicture.asset(
                          controller.obscureConfirmPassword.value
                              ? 'assets/icons/eye_off_icon.svg'
                              : 'assets/icons/password_icon.svg',
                          width: 19.w,
                          height: 19.h,
                          colorFilter: const ColorFilter.mode(
                            Colors.grey,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minWidth: 44.w,
                      minHeight: 44.h,
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty)
                        return 'Enter your confirm password';
                      if (value != controller.passwordController.text)
                        return 'Passwords do not match';
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 17.h),

                CustomElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate())
                      controller.resetPassword();
                  },
                  color: ConstColor.primaryColor,
                  height: 48,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: CustomText(
                    title: ConstString.resetPassword,
                    textColor: ConstColor.backgroundColor,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

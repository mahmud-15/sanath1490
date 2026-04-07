// ─────────────────────────────────────────
// reset_password.dart
// ─────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sanath1490_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/auth_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AuthAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 62.h),

                // Key Icon
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

                // Title
                CustomText(
                  title: ConstString.resetPassword,
                  textColor: ConstColor.primaryColor,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                SizedBox(height: 10.h),

                // Subtitle
                CustomText(
                  title: ConstString.createANewStrongPassword,
                  textColor: ConstColor.bodyColor,
                  textSize: 15.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 3,
                ),
                SizedBox(height: 22.h),

                // New Password Field
                CustomTextFormField(
                  fromTitle: ConstString.newPassword,
                  textController: _passwordController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscurePassword,
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
                      colorFilter: const ColorFilter.mode(ConstColor.iconColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscurePassword = !_obscurePassword),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        _obscurePassword ? 'assets/icons/password_icon.svg' : 'assets/icons/password_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(ConstColor.iconColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Enter your new password';
                    return null;
                  },
                ),
                SizedBox(height: 10.h),

                // Confirm Password Field
                CustomTextFormField(
                  fromTitle: ConstString.confirmNewPassword,
                  textController: _newPasswordController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  obscureText: _obscureConfirmPassword,
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
                      colorFilter: const ColorFilter.mode(ConstColor.iconColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  suffixIcon: GestureDetector(
                    onTap: () => setState(() => _obscureConfirmPassword = !_obscureConfirmPassword),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        _obscureConfirmPassword ? 'assets/icons/password_icon.svg' : 'assets/icons/password_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Enter your confirm password';
                    if (value != _passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                ),
                SizedBox(height: 17.h),

                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AppSnackBar.success('OTP verified successfully!');
                      Get.toNamed(AppRoutes.signInScreen);
                    }
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
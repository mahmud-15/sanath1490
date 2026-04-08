import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/auth_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../constant/const_color.dart';
import 'Controller/create_account_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CreateAccountController>();
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: const AuthAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32.h),

                // ─── Header ──────────────────────────
                Center(
                  child: CustomText(
                    title: 'Create Account',
                    textColor: ConstColor.primaryColor,
                    textSize: 28.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: CustomText(
                    title: 'Join MyHome and find your perfect property',
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLine: 2,
                  ),
                ),
                SizedBox(height: 28.h),

                // ─── Full Name ───────────────────────
                CustomTextFormField(
                  fromTitle: 'Full Name',
                  textController: controller.fullNameController,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(
                    title: 'Enter your full name',
                    textColor: Colors.grey,
                    textSize: 13,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/user_icon.svg',
                      width: 19.w,
                      height: 19.h,
                      colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Full name is required';
                    return null;
                  },
                ),

                // ─── Email ───────────────────────────
                CustomTextFormField(
                  fromTitle: 'Email Address',
                  textController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(
                    title: 'your.email@example.com',
                    textColor: Colors.grey,
                    textSize: 13,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/email.svg',
                      width: 19.w,
                      height: 19.h,
                      colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),

                // ─── Password ────────────────────────
                Obx(() => CustomTextFormField(
                  fromTitle: 'Password',
                  textController: controller.passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: controller.obscurePassword.value,
                  hintText: const CustomText(
                    title: 'Min 8 characters',
                    textColor: Colors.grey,
                    textSize: 13,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/lock_icon.svg',
                      width: 19.w,
                      height: 19.h,
                      colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  suffixIcon: GestureDetector(
                    onTap: controller.togglePassword,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        controller.obscurePassword.value
                            ? 'assets/icons/password_icon.svg'
                            : 'assets/icons/password_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Password is required';
                    if (value.length < 8) return 'Minimum 8 characters';
                    return null;
                  },
                )),

                // ─── Confirm Password ────────────────
                Obx(() => CustomTextFormField(
                  fromTitle: 'Confirm Password',
                  textController: controller.confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: controller.obscureConfirmPassword.value,
                  hintText: const CustomText(
                    title: 'Repeat your password',
                    textColor: Colors.grey,
                    textSize: 13,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/lock_icon.svg',
                      width: 19.w,
                      height: 19.h,
                      colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  suffixIcon: GestureDetector(
                    onTap: controller.toggleConfirmPassword,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        controller.obscureConfirmPassword.value
                            ? 'assets/icons/password_icon.svg'
                            : 'assets/icons/password_icon.svg',
                        width: 19.w,
                        height: 19.h,
                        colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Please confirm your password';
                    if (value != controller.passwordController.text) return 'Passwords do not match';
                    return null;
                  },
                )),

                SizedBox(height: 12.h),

                // ─── Terms & Conditions ──────────────
                _TermsRow(controller: controller),
                SizedBox(height: 24.h),

                // ─── Continue Button ─────────────────
                Obx(() => CustomElevatedButton(
                  onPressed: controller.isTermsAccepted.value
                      ? () {
                    if (formKey.currentState!.validate()) {
                      controller.onContinue();
                    }
                  }
                      : null,
                  color: controller.isTermsAccepted.value
                      ? ConstColor.primaryColor
                      : ConstColor.primaryColor.withAlpha(100),
                  height: 52,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: CustomText(
                    title: 'Continue',
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                )),
                SizedBox(height: 20.h),

                // ─── OR Divider ──────────────────────
                const _OrDivider(),
                SizedBox(height: 20.h),

                // ─── Google Button ───────────────────
                CustomElevatedButton(
                  onPressed: controller.onGoogleSignUp,
                  isOutLined: true,
                  outLineColour: const Color(0xFFE5E7EB),
                  borderColor: const Color(0xFFE5E7EB),
                  height: 52,
                  left: 0,
                  right: 0,
                  top: 0,
                  icon: AppImage(
                    path: 'assets/images/google_logo.png',
                    width: 20.w,
                    height: 20.h,
                  ),
                  child: CustomText(
                    title: 'Continue with Google',
                    textColor: ConstColor.titleColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 24.h),

                // ─── Sign In Row ─────────────────────
                const _SignInRow(),
                SizedBox(height: 32.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _TermsRow extends StatelessWidget {
  final CreateAccountController controller;

  const _TermsRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: controller.toggleTerms,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 20.w,
            height: 20.h,
            decoration: BoxDecoration(
              color: controller.isTermsAccepted.value
                  ? ConstColor.primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: controller.isTermsAccepted.value
                    ? ConstColor.primaryColor
                    : ConstColor.outLineColor,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: controller.isTermsAccepted.value
                ? Icon(Icons.check, color: Colors.white, size: 13.sp)
                : null,
          ),
        ),
        SizedBox(width: 10.w),
        Expanded(
          child: Wrap(
            children: [
              CustomText(
                title: 'I agree to the ',
                textColor: ConstColor.bodyColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
              GestureDetector(
                onTap: () {},
                child: CustomText(
                  title: 'Terms & Conditions',
                  textColor: ConstColor.primaryColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
              CustomText(
                title: ' and ',
                textColor: ConstColor.bodyColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
              GestureDetector(
                onTap: () {},
                child: CustomText(
                  title: 'Privacy Policy',
                  textColor: ConstColor.primaryColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

// ─────────────────────────────────────────
class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: ConstColor.outLineColor, thickness: 1)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CustomText(
            title: 'OR',
            textColor: ConstColor.bodyColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
        ),
        Expanded(child: Divider(color: ConstColor.outLineColor, thickness: 1)),
      ],
    );
  }
}

// ─────────────────────────────────────────
class _SignInRow extends StatelessWidget {
  const _SignInRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: 'Already have an account? ',
          textColor: ConstColor.bodyColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
        GestureDetector(
          onTap: () => Get.back(),
          child: CustomText(
            title: 'Sign in here',
            textColor: ConstColor.primaryColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      ],
    );
  }
}
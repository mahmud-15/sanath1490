import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import 'package:sanath1490_flutter_app/widget/Divider/divider.dart';
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
      appBar: const GlobalAppBar(),
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
                    title: ConstString.createAccount,
                    textColor: ConstColor.primaryColor,
                    textSize: 30.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ),
                SizedBox(height: 6.h),
                Center(
                  child: CustomText(
                    title: ConstString.joinMyHome,
                    textColor: ConstColor.bodyColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ),
                SizedBox(height: 28.h),

                // ─── Full Name ───────────────────────
                CustomTextFormField(
                  fromTitle: ConstString.fullName,
                  textController: controller.fullNameController,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(
                    title: ConstString.enterYourFullName,
                    textColor: Colors.grey,
                    textSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/profile_icon.svg',
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
                  fromTitle: ConstString.emailAddress,
                  textController: controller.emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(
                    title: ConstString.yourEmailExample,
                    textColor: Colors.grey,
                    textSize: 14,
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
                  fromTitle: AutofillHints.password,
                  textController: controller.passwordController,
                  textInputAction: TextInputAction.next,
                  obscureText: controller.obscurePassword.value,
                  hintText: const CustomText(
                    title: ConstString.min8Character,
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
                            ? 'assets/icons/eye_off_icon.svg'
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
                    if (value.length < 8) return ConstString.min8Character;
                    return null;
                  },
                )),

                // ─── Confirm Password ────────────────
                Obx(() => CustomTextFormField(
                  fromTitle: ConstString.confirmPassword,
                  textController: controller.confirmPasswordController,
                  textInputAction: TextInputAction.done,
                  obscureText: controller.obscureConfirmPassword.value,
                  hintText: const CustomText(
                    title: ConstString.repeatYorPassword,
                    textColor: Colors.grey,
                    textSize: 14,
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
                            ? 'assets/icons/eye_off_icon.svg'
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
                      Get.toNamed(AppRoutes.accountVerifyOtpScreen);
                    }
                  }
                      : null,
                  color: controller.isTermsAccepted.value
                      ? ConstColor.primaryColor
                      : ConstColor.primaryColor.withAlpha(100),
                  height: 48,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: CustomText(
                    title: ConstString.continueA,
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w700,
                  ),
                )),
                SizedBox(height: 20.h),

                // ─── OR Divider ──────────────────────
                OrDivider(),
                SizedBox(height: 20.h),

                // ─── Google Button ───────────────────
                CustomElevatedButton(
                  onPressed: () {},
                  color: Colors.white,
                  height: 48,
                  left: 0,
                  right: 0,
                  top: 0,
                  borderColor: Colors.grey.shade300,
                  borderWidth: 1,
                  icon: Image.asset(
                    'assets/images/google_icon.png',
                    width: 24.w,
                    height: 24.h,
                  ),
                  child: CustomText(
                    title: ConstString.continueWithGoogle,
                    textColor: ConstColor.titleColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),

                // ─── Sign In Row ─────────────────────
                const _SignInRow(),
                SizedBox(height: 68.h),
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
            width: 18.w,
            height: 18.h,
            decoration: BoxDecoration(
              color: controller.isTermsAccepted.value
                  ? ConstColor.primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: controller.isTermsAccepted.value
                    ? ConstColor.primaryColor
                    : ConstColor.iconColor,
                width: 2.5,
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
                title: ConstString.iAgreeYourThe,
                textColor: ConstColor.bodyColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
              SizedBox(width: 5.w,),
              GestureDetector(
                onTap: () {},
                child: CustomText(
                  title: ConstString.termsAndCondition,
                  textColor: ConstColor.primaryColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
              SizedBox(width: 5.w,),
              CustomText(
                title: ConstString.and,
                textColor: ConstColor.bodyColor,
                textSize: 11.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
              SizedBox(width: 5.w,),
              GestureDetector(
                onTap: () {},
                child: CustomText(
                  title: ConstString.privacyPolicy,
                  textColor: ConstColor.primaryColor,
                  textSize: 12.sp,
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


// ─────────────────────────────────────────
class _SignInRow extends StatelessWidget {
  const _SignInRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          title: ConstString.alreadyHaveAnAccount,
          textColor: ConstColor.bodyColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
        SizedBox(width: 4.w,),
        GestureDetector(
          onTap: () => Get.toNamed(AppRoutes.signInScreen),
          child: CustomText(
            title: ConstString.signInHere,
            textColor: ConstColor.primaryColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ),
      ],
    );
  }
}
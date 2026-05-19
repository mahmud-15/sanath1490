import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import 'package:sanath1490_flutter_app/widget/Divider/divider.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/sign_in_controller.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final controller = Get.put(SignInController());
  final formKey    = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   controller.emailController = TextEditingController();
  //   controller.passwordController = TextEditingController();
  // }
  @override
  Widget build(BuildContext context) {
    if (Get.isRegistered<SignInController>()) {
      Get.delete<SignInController>(force: true);
    }


    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),
                CustomText(
                  title: ConstString.welcomeBack,
                  textColor: ConstColor.primaryColor,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                SizedBox(height: 6.h),
                CustomText(
                  title: ConstString.signInToContinue,
                  textColor: Colors.grey,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
                SizedBox(height: 32.h),
                CustomTextFormField(
                  fromTitle: ConstString.email,
                  textController: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(title: ConstString.yourEmailExample, textColor: Colors.grey, textSize: 14),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset('assets/icons/email.svg', width: 19.w, height: 19.h, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                Obx(() => CustomTextFormField(
                  fromTitle: ConstString.password,
                  textController: passwordController,
                  obscureText: controller.obscurePassword.value,
                  textInputAction: TextInputAction.done,
                  hintText: const CustomText(title: ConstString.enterYourPassWord, textColor: Colors.grey, textSize: 14),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset('assets/icons/lock_icon.svg', width: 19.w, height: 19.h, colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn)),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  suffixIcon: GestureDetector(
                    onTap: controller.togglePassword,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: SvgPicture.asset(
                        controller.obscurePassword.value ? 'assets/icons/eye_off_icon.svg' : 'assets/icons/password_icon.svg',
                        width: 19.w, height: 19.h,
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                )),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () => Get.toNamed(AppRoutes.forgotPasswordScreen),
                    child: CustomText(title: ConstString.forgotPassword, textColor: ConstColor.secondaryColor, textSize: 14.sp, fontWeight: FontWeight.w500, top: 4, bottom: 8),
                  ),
                ),
                SizedBox(height: 8.h),
                Obx(() => CustomElevatedButton(
                  onPressed: controller.isLoading.value
                      ? null
                      : () { if (formKey.currentState!.validate()) controller.signIn(email: emailController.text.trim(),password: passwordController.text.trim());},
                  color: const Color(0xFF1A3C6E),
                  height: 48, left: 0, right: 0, top: 0,
                  child: CustomText(title: ConstString.signIn, textColor: Colors.white, textSize: 16.sp, fontWeight: FontWeight.w600),
                )),
                SizedBox(height: 24.h),
                OrDivider(),
                SizedBox(height: 24.h),
                CustomElevatedButton(
                  onPressed: () {
                    AppSnackBar.message(
                      "Google Sign-In feature is currently under development.\nPlease try again later.",
                      backgroundColor: const Color(0xFFECFDF3),
                      color: const Color(0xFF008A2E),
                    );
                  },
                  color: Colors.white, height: 48, left: 0, right: 0, top: 0,
                  borderColor: Colors.grey.shade300, borderWidth: 1,
                  icon: Image.asset('assets/images/google_icon.png', width: 24.w, height: 24.h),
                  child: CustomText(title: ConstString.continueWithGoogle, textColor: ConstColor.titleColor, textSize: 15.sp, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 32.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(title: ConstString.donHaveSnAccount, textColor: ConstColor.bodyColor, textSize: 14.sp, fontWeight: FontWeight.w400),
                    SizedBox(width: 5.w),
                    GestureDetector(
                      onTap: () => Get.toNamed(AppRoutes.createAccountScreen),
                      child: CustomText(title: ConstString.signUp, textColor: ConstColor.primaryColor, textSize: 14.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
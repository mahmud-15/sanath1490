import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 100.h),

                // Title
                CustomText(
                  title: ConstString.welcomeBack,
                  textColor: ConstColor.primaryColor,
                  textSize: 30.sp,
                  fontWeight: FontWeight.w700,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                SizedBox(height: 6.h),

                // Subtitle
                CustomText(
                  title: ConstString.signInToContinue,
                  textColor: Colors.grey,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 2,
                ),
                SizedBox(height: 32.h),

                // Email Field
                CustomTextFormField(
                  fromTitle: ConstString.email,
                  textController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  hintText: const CustomText(
                    title: ConstString.yourEmailExample,
                    textColor: ConstColor.bodyColor,
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

                // Password Field
                CustomTextFormField(
                  fromTitle: ConstString.password,
                  textController: _passwordController,
                  obscureText: _obscurePassword,
                  textInputAction: TextInputAction.done,
                  hintText: const CustomText(
                    title: ConstString.enterYourPassWord,
                    textColor: Colors.grey,
                    textSize: 14,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: SvgPicture.asset(
                      'assets/icons/lock_icon.svg',
                      width: 19.w,
                      height: 19.h,
                      colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
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
                        colorFilter: const ColorFilter.mode(Colors.grey, BlendMode.srcIn),
                      ),
                    ),
                  ),
                  suffixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                ),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {},
                    child: CustomText(
                      title: ConstString.forgotPassword,
                      textColor: ConstColor.secondaryColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      top: 4,
                      bottom: 8,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Sign In Button
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  color: const Color(0xFF1A3C6E),
                  height: 48,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: CustomText(
                    title: ConstString.signIn,
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 24.h),

                // OR Divider
                Row(
                  children: [
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [ConstColor.outLineColor, ConstColor.bodyColor],
                        ).createShader(bounds),
                        child: Divider(color: Colors.white, thickness: 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: CustomText(
                        title: ConstString.or,
                        textColor: ConstColor.bodyColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [ConstColor.bodyColor, ConstColor.outLineColor],
                        ).createShader(bounds),
                        child: Divider(color: Colors.white, thickness: 1),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Continue with Google
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
                SizedBox(height: 32.h),

                // Sign Up Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      title: ConstString.donHaveSnAccount,
                      textColor: ConstColor.bodyColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: CustomText(
                        title: ConstString.signUp,
                        textColor: ConstColor.primaryColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
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
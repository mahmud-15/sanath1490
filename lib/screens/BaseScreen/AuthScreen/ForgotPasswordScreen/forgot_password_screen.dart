import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/auth_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
                SizedBox(height: 32.h),

                // Key Icon
                Container(
                  width: 72.w,
                  height: 72.h,
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(18.r),
                  ),
                  child: Center(
                    child: AppImage(
                      path: 'assets/images/key.png',
                      width: 36.w,
                      height: 36.h,
                      iconColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 24.h),

                // Title
                CustomText(
                  title: 'Forgot Password?',
                  textColor: ConstColor.primaryColor,
                  textSize: 26.sp,
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLine: 1,
                ),
                SizedBox(height: 10.h),

                // Subtitle
                CustomText(
                  title: "No worries! Enter your email and we'll send you\nan OTP code to reset your password.",
                  textColor: ConstColor.bodyColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  textAlign: TextAlign.center,
                  maxLine: 3,
                ),
                SizedBox(height: 36.h),

                // Email Field
                CustomTextFormField(
                  fromTitle: 'Email',
                  textController: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  hintText: const CustomText(
                    title: 'your.email@example.com',
                    textColor: Colors.grey,
                    textSize: 13,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Icon(
                      Icons.email_outlined,
                      size: 20.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ),
                  prefixIconConstraints: BoxConstraints(minWidth: 44.w, minHeight: 44.h),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) return 'Email is required';
                    if (!value.contains('@')) return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: 24.h),

                // Send OTP Button
                CustomElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                  color: ConstColor.primaryColor,
                  height: 52,
                  left: 0,
                  right: 0,
                  top: 0,
                  child: CustomText(
                    title: 'Send OTP',
                    textColor: Colors.white,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w600,
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
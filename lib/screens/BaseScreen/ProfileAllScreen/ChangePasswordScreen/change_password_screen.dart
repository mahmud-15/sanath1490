import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/change_password_controller.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChangePasswordController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: 'Change Password'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // ─── Form Card ────────────────────────
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Form(
                key: controller.formKey,
                child: Column(
                  children: [
                    // Current Password
                    Obx(() => CustomTextFormField(
                      fromTitle: 'Current Password',
                      textController: controller.currentPassController,
                      hintText: const Text('Enter current password'),
                      obscureText: controller.hideCurrentPass.value,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleCurrentPass,
                        child: Icon(
                          controller.hideCurrentPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.sp,
                          color: ConstColor.bodyColor,
                        ),
                      ),
                    )),

                    // New Password
                    Obx(() => CustomTextFormField(
                      fromTitle: 'New Password',
                      textController: controller.newPassController,
                      hintText: const Text('Enter new password'),
                      obscureText: controller.hideNewPass.value,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleNewPass,
                        child: Icon(
                          controller.hideNewPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.sp,
                          color: ConstColor.bodyColor,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'This field is required';
                        }
                        if (value.length < 8) {
                          return 'Minimum 8 characters';
                        }
                        return null;
                      },
                    )),

                    // Hint text
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: CustomText(
                          title: 'Minimum 8 characters',
                          textColor: ConstColor.bodyColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                      ),
                    ),

                    // Confirm New Password
                    Obx(() => CustomTextFormField(
                      fromTitle: 'Confirm New Password',
                      textController: controller.confirmPassController,
                      hintText: const Text('Confirm new password'),
                      obscureText: controller.hideConfirmPass.value,
                      suffixIcon: GestureDetector(
                        onTap: controller.toggleConfirmPass,
                        child: Icon(
                          controller.hideConfirmPass.value
                              ? Icons.visibility_off_outlined
                              : Icons.visibility_outlined,
                          size: 18.sp,
                          color: ConstColor.bodyColor,
                        ),
                      ),
                      validator: (value) {
                        if (value != controller.newPassController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    )),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // ─── Save Button ──────────────────────
            CustomElevatedButton(
              onPressed: controller.saveChanges,
              color: ConstColor.primaryColor,
              height: 52,
              top: 0,
              left: 0,
              right: 0,
              child: CustomText(
                title: 'Save Changes',
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
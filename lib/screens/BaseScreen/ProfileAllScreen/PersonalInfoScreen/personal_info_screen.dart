import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import 'Controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatelessWidget {
  const PersonalInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalInfoController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: 'Personal Info'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            // ─── Avatar ───────────────────────────
            _AvatarPicker(controller: controller),

            SizedBox(height: 24.h),

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
                    // Full Name
                    CustomTextFormField(
                      fromTitle: 'Full Name',
                      textController: controller.nameController,
                      hintText: const Text('Sarah Johnson'),
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset(
                          'assets/icons/profile_icon.svg',
                          width: 18.w,
                          colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                        ),
                      ),
                    ),

                    // Email Address
                    CustomTextFormField(
                      fromTitle: 'Email Address',
                      textController: controller.emailController,
                      hintText: const Text('sarah.j@email.com'),
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset(
                          'assets/icons/email_icon.svg',
                          width: 18.w,
                          colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                        ),
                      ),
                    ),

                    // Phone Number
                    CustomTextFormField(
                      fromTitle: 'Phone Number',
                      textController: controller.phoneController,
                      hintText: const Text('+1 (555) 123-4567'),
                      keyboardType: TextInputType.phone,
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SvgPicture.asset(
                          'assets/icons/phone_icon.svg',
                          width: 18.w,
                          colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                        ),
                      ),
                    ),

                    // Address label
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        title: 'Address',
                        textColor: ConstColor.titleColor,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                    SizedBox(height: 6.h),

                    // Country dropdown
                    Obx(() => GestureDetector(
                      onTap: controller.pickCountry,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          border: Border.all(color: ConstColor.outLineColor),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: CustomText(
                                title: controller.selectedCountry.value.isEmpty
                                    ? 'Select your country'
                                    : controller.selectedCountry.value,
                                textColor: controller.selectedCountry.value.isEmpty
                                    ? ConstColor.outLineColor
                                    : ConstColor.titleColor,
                                textSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                maxLine: 1,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/chevron_down_icon.svg',
                              width: 16.w,
                              colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    )),

                    SizedBox(height: 4.h),

                    // Postal code
                    CustomTextFormField(
                      fromTitle: 'Postal Code',
                      textController: controller.postalController,
                      hintText: const Text('Enter your postal code'),
                      validator: (_) => null, // optional field
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24.h),

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

// ─────────────────────────────────────────────────────
// Avatar picker with camera icon overlay
// ─────────────────────────────────────────────────────
class _AvatarPicker extends StatelessWidget {
  final PersonalInfoController controller;

  const _AvatarPicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: controller.pickAvatar,
          child: Stack(
            children: [
              // ─── Avatar image ──────────────────
              Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: AppImage(
                  path: controller.avatarPath.value,
                  width: 90.w,
                  height: 90.w,
                  fit: BoxFit.cover,
                ),
              )),

              // ─── Camera icon overlay ───────────
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: ConstColor.secondaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      'assets/icons/camera_icon.svg',
                      width: 14.w,
                      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        CustomText(
          title: 'Tap to change profile photo',
          textColor: ConstColor.bodyColor,
          textSize: 12.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
      ],
    );
  }
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/MediaPickerBottomSheet/media_picker_bottom_sheet.dart';
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
      appBar: const GlobalAppBar(title: 'Personal Info'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            _AvatarPicker(controller: controller),
            SizedBox(height: 24.h),
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
                    CustomTextFormField(
                      fromTitle: ConstString.fullName,
                      backgroundColor: ConstColor.backgroundColor,
                      textController: controller.nameController,
                      titleIcon: SvgPicture.asset(
                        'assets/icons/profile_icon.svg',
                        width: 19.w,
                        colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // ─── Email Address ───────────
                    CustomTextFormField(
                      fromTitle: ConstString.emailAddress,
                      backgroundColor: ConstColor.backgroundColor,
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      titleIcon: SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 18.w,
                        colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),

                    SizedBox(height: 8.h),

                    // ─── Phone Number ───────────
                    CustomTextFormField(
                      fromTitle: ConstString.phoneNumber,
                      backgroundColor: ConstColor.backgroundColor,
                      textController: controller.phoneController,
                      keyboardType: TextInputType.phone,
                      titleIcon: SvgPicture.asset(
                        'assets/icons/phone.svg',
                        width: 18.w,
                        colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),

                    SizedBox(height: 14.h),
                    Divider(color: ConstColor.outLineColor.withAlpha(150)),
                    SizedBox(height: 16.h),

                    // ─── Address Section ───────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location_icon.svg', // Use correct pin icon name
                          width: 19.w,
                          colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                        ),
                        SizedBox(width: 8.w),
                        CustomText(
                          title: ConstString.address,
                          textColor: ConstColor.titleColor,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          maxLine: 1,
                        ),
                      ],
                    ),
                    SizedBox(height: 12.h),

                    // Country dropdown title
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: CustomText(
                        title: ConstString.country,
                        textColor: ConstColor.bodyColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),

                    // Country dropdown box
                    Obx(() => GestureDetector(
                      onTap: controller.pickCountry,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                        decoration: BoxDecoration(
                          color: ConstColor.backgroundColor,
                          border: Border.all(color: ConstColor.iconColor),
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
                                    ? ConstColor.bodyColor
                                    : ConstColor.titleColor,
                                textSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                maxLine: 1,
                              ),
                            ),
                            SvgPicture.asset(
                              'assets/icons/arrow_drop_icon.svg',
                              width: 20.w,
                              colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                            ),
                          ],
                        ),
                      ),
                    )),

                    SizedBox(height: 12.h),

                    // Postal code
                    CustomTextFormField(
                      fromTitle: ConstString.postalCode,
                      backgroundColor: ConstColor.backgroundColor,
                      textController: controller.postalController,
                      hintText: const Text('Enter your postal code'),
                      validator: (_) => null,
                      keyboardType: TextInputType.number,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 44.h),

            // ─── Save Button ──────────────────────
            // CustomElevatedButton(
            //   onPressed: controller.saveChanges,
            //   color: ConstColor.primaryColor,
            //   height: 48,
            //   top: 0,
            //   left: 0,
            //   right: 0,
            //   child: CustomText(
            //     title: 'Save Changes',
            //     textColor: Colors.white,
            //     textSize: 15.sp,
            //     fontWeight: FontWeight.w600,
            //     maxLine: 1,
            //   ),
            // ),
            //
            // SizedBox(height: 24.h),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(right: 16,left: 16,bottom: 32),
        child: CustomElevatedButton(
          onPressed: controller.saveChanges,
          color: ConstColor.primaryColor,
          height: 48,
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
      ),
    );
  }
}

class _AvatarPicker extends StatelessWidget {
  final PersonalInfoController controller;

  const _AvatarPicker({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            MediaPickerBottomSheet.show(
              onGallery: () => controller.pickImageFromGallery(),
              onCamera: () => controller.pickImageFromCamera(),
            );
          },
          child: Stack(
            children: [
              Obx(() => ClipRRect(
                borderRadius: BorderRadius.circular(50.r),
                child: controller.avatarPath.value.startsWith('assets/')
                    ? AppImage(
                  path: controller.avatarPath.value,
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                )
                    : Image.file(
                  File(controller.avatarPath.value),
                  width: 100.w,
                  height: 100.w,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100.w,
                      height: 100.w,
                      color: Colors.grey.shade300,
                      child: Icon(Icons.person, size: 50.sp, color: Colors.grey),
                    );
                  },
                ),
              )),

              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 32.w,
                  height: 32.w,
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
          title: ConstString.tapToChangeProfile,
          textColor: ConstColor.bodyColor,
          textSize: 14.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
      ],
    );
  }
}
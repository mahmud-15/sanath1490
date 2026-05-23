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

      body: Obx(() => controller.isLoading.value
      // ─── Loading state ───────────────────────
          ? const Center(child: CircularProgressIndicator())
      // ─── Loaded ─────────────────────────────
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: Column(
          children: [
            AvatarPicker(controller: controller),
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

                    // ─── Email (read only) ────────────────
                    CustomTextFormField(
                      fromTitle: ConstString.emailAddress,
                      backgroundColor: ConstColor.backgroundColor,
                      textController: controller.emailController,
                      keyboardType: TextInputType.emailAddress,
                      readOnly: true, // ✅ email change allow নেই
                      titleIcon: SvgPicture.asset(
                        'assets/icons/email.svg',
                        width: 18.w,
                        colorFilter: const ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // ─── Phone ────────────────────────────
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

                    // ─── Address Section ──────────────────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location_icon.svg',
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

                    // ─── Country Dropdown ─────────────────
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

                    Obx(() => GestureDetector(
                      onTap: () => controller.pickCountry(context),
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

                    // ─── Postal Code ──────────────────────
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
          ],
        ),
      )),

      // ─── Save Button ──────────────────────────────
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          16.w,
          0,
          16.w,
          4.h + MediaQuery.of(context).padding.bottom,
        ),
        child: Obx(() => CustomElevatedButton(
          onPressed: controller.isSaving.value ? null : controller.saveChanges,
          color: controller.isSaving.value
              ? ConstColor.primaryColor.withAlpha(100)
              : ConstColor.primaryColor,
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
        )),
      ),
    );
  }
}

// ─────────────────────────────────────────────────
class AvatarPicker extends StatelessWidget {
  final PersonalInfoController controller;
  const AvatarPicker({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            MediaPickerBottomSheet.show(
              onGallery: () => controller.pickImageFromGallery(),
              onCamera:  () => controller.pickImageFromCamera(),
            );
          },
          child: Stack(
            children: [
              Obx(() {
                final path = controller.avatarPath.value;

                return ClipRRect(
                  borderRadius: BorderRadius.circular(50.r),
                  child: _buildImage(path),
                );
              }),

              // Camera icon badge
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

  Widget _buildImage(String? path) {
    final size = 100.w;

    if (path == null || path.isEmpty) {
      return _PlaceholderAvatar(size: size);
    }

    if (!path.startsWith('http') && !path.startsWith('/uploads')) {
      return Image.file(
        File(path),
        width: size,
        height: size,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _PlaceholderAvatar(size: size),
      );
    }

    return Image.network(
      path,
      width: size,
      height: size,
      fit: BoxFit.cover,
      loadingBuilder: (_, child, progress) {
        if (progress == null) return child;
        return _PlaceholderAvatar(size: size);
      },
      errorBuilder: (_, _, _) => _PlaceholderAvatar(size: size),
    );
  }
}

class _PlaceholderAvatar extends StatelessWidget {
  final double size;
  const _PlaceholderAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      color: ConstColor.outLineColor.withAlpha(80),
      child: Icon(
        Icons.person_rounded,
        size: size * 0.5,
        color: ConstColor.bodyColor.withAlpha(150),
      ),
    );
  }
}
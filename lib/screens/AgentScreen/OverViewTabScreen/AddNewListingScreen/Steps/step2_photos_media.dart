import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/add_listing_controller.dart';

class Step2PhotosMedia extends StatelessWidget {
  final AddListingController controller;

  const Step2PhotosMedia({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _UploadSection(
          label: ConstString.propertyPhotos,
          required: true,
          iconPath: 'assets/icons/upload_photo_icon.svg',
          uploadLabel: ConstString.uploadPhoto,
          specText: ConstString.photoSpec,
          buttonLabel: ConstString.choosePhotos,
          onTap: controller.pickPhotos,
          mediaList: controller.photos,
          isVideo: false,
        ),

        SizedBox(height: 14.h),

        // ─── Property Videos ─────────────────────
        _UploadSection(
          label: ConstString.propertyVideos,
          required: true,
          iconPath: 'assets/icons/play_button.svg',
          uploadLabel: ConstString.uploadVideo,
          specText: ConstString.videoSpec,
          buttonLabel: ConstString.chooseVideos,
          onTap: controller.pickVideos,
          mediaList: controller.videos,
          isVideo: true,
        ),

        SizedBox(height: 14.h),

        // ─── Floor Plan ──────────────────────────
        _UploadSection(
          label: ConstString.floorPlan,
          required: false,
          iconPath: 'assets/icons/upload_floor_plan_icon.svg',
          uploadLabel: ConstString.uploadFloorPlan,
          specText: ConstString.photoSpec,
          buttonLabel: ConstString.choosePhotos,
          onTap: controller.pickFloorPlan,
          mediaList: controller.floorPlans,
          isVideo: false,
        ),

        SizedBox(height: 14.h),

        // ─── Brochure ────────────────────────────
        _UploadSection(
          label: ConstString.brochure,
          required: false,
          iconPath: 'assets/icons/document_icon.svg',
          uploadLabel: ConstString.uploadBrochure,
          specText: ConstString.brochureSpec,
          buttonLabel: ConstString.chooseFile,
          onTap: controller.pickBrochure,
          mediaList: RxList<String>(),
          isVideo: false,
        ),

        SizedBox(height: 14.h),

        // ─── 360° Tour URL ───────────────────────
        _TourUrlSection(controller: controller),

        SizedBox(height: 16.h),
      ],
    );
  }
}

// ─── Reusable upload section card ─────────────────
class _UploadSection extends StatelessWidget {
  final String label;
  final bool required;
  final String iconPath;
  final String uploadLabel;
  final String specText;
  final String buttonLabel;
  final VoidCallback onTap;
  final RxList<String> mediaList; // ─── Received RxList for local Obx ───
  final bool isVideo;

  const _UploadSection({
    required this.label,
    required this.required,
    required this.iconPath,
    required this.uploadLabel,
    required this.specText,
    required this.buttonLabel,
    required this.onTap,
    required this.mediaList,
    required this.isVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Label ───────────────────────────────
        Row(
          children: [
            CustomText(
              title: label,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            if (required)
              CustomText(
                title: ' *',
                textColor: Colors.red,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
          ],
        ),
        SizedBox(height: 8.h),

        // ─── Dotted Box Area ─────────────────────
        GestureDetector(
          onTap: onTap, // Allows tapping the image to change it
          child: DottedBorder(
            options: RoundedRectDottedBorderOptions(
              color: ConstColor.iconColor,
              strokeWidth: 2,
              dashPattern: const [10, 5],
              radius: Radius.circular(10.r),
              padding: EdgeInsets.zero,
            ),
            child: Container(
              width: double.infinity,
              height: 160.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Obx(() {
                // ─── ERROR FIXED: Obx is now correctly tracking mediaList.isEmpty ───
                final hasMedia = mediaList.isNotEmpty;

                if (hasMedia) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: isVideo
                        ? Container(
                      color: Colors.black87,
                      child: Center(
                        child: Icon(Icons.play_circle_fill, color: Colors.white, size: 48.sp),
                      ),
                    )
                        : Image.file(
                      File(mediaList.first),
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconPath,
                        width: 20.w,
                        colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                      ),
                      SizedBox(height: 6.h),
                      CustomText(
                        title: uploadLabel,
                        textColor: ConstColor.titleColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: specText,
                        textColor: ConstColor.bodyColor,
                        textSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.h),
                      CustomElevatedButton(
                        onPressed: onTap,
                        color: ConstColor.primaryColor,
                        height: 38,
                        width: 140,
                        top: 0,
                        left: 0,
                        right: 0,
                        child: CustomText(
                          title: buttonLabel,
                          textColor: Colors.white,
                          textSize: 12.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── 360 tour URL input ────────────────────────────
class _TourUrlSection extends StatelessWidget {
  final AddListingController controller;

  const _TourUrlSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: ConstString.tourUrl,
          textColor: ConstColor.titleColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          textController: controller.tourUrlController,
          hintText: const Text(ConstString.tourUrlHint),
          validator: (_) => null,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(
              'assets/icons/url_icon.svg',
              width: 16.w,
              colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
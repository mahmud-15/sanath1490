import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/add_listing_controller.dart';
import 'Steps/listing_success_screen.dart';
import 'Steps/step1_property_basics.dart';
import 'Steps/step2_photos_media.dart';
import 'Steps/step3_property_info.dart';
import 'Steps/step4_feature_description.dart';
import 'Steps/step5_review_publish.dart';
class AddNewListingScreen extends StatelessWidget {
  const AddNewListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddListingController());

    return Obx(() {
      if (controller.currentStep.value == 6) {
        return const ListingSuccessScreen();
      }

      return Scaffold(
        backgroundColor: const Color(0xFFF2F4F7),
        appBar: GlobalAppBar(
          title: ConstString.addNewListing,
          onBack: () {
            if (controller.currentStep.value > 1) {
              controller.prevStep();
            } else {
              Get.back();
            }
          },
        ),

        body: Column(
          children: [
            _StepHeader(controller: controller),

            // ─── Step content ────────────────────
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                child: _stepContent(controller),
              ),
            ),

            // ─── Continue / action button ─────────
            _BottomBar(controller: controller),
          ],
        ),
      );
    });
  }

  Widget _stepContent(AddListingController controller) {
    switch (controller.currentStep.value) {
      case 1: return Step1PropertyBasics(controller: controller);
      case 2: return Step2PhotosMedia(controller: controller);
      case 3: return Step3PropertyInfo(controller: controller);
      case 4: return Step4FeatureDescription(controller: controller);
      case 5: return Step5ReviewPublish(controller: controller);
      default: return const SizedBox.shrink();
    }
  }
}

///////////////Step label + progress bar
class _StepHeader extends StatelessWidget {
  final AddListingController controller;

  const _StepHeader({required this.controller});

  String get _stepLabel {
    switch (controller.currentStep.value) {
      case 1: return ConstString.stepPropertyBasics;
      case 2: return ConstString.stepPhotosMedia;
      case 3: return ConstString.stepPropertyInfo;
      case 4: return ConstString.stepFeatureDesc;
      case 5: return ConstString.stepReviewPublish;
      default: return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 0.h),
          child: CustomText(
            title: _stepLabel,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
        // ─── Progress bar ────────────────────
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: LinearProgressIndicator(
            value: controller.progress,
            backgroundColor: ConstColor.secondaryColor,
            valueColor: AlwaysStoppedAnimation<Color>(ConstColor.primaryColor),
            minHeight: 6.h,
          ),
        ),
      ],
    ));
  }
}

////////Bottom action bar
class _BottomBar extends StatelessWidget {
  final AddListingController controller;

  const _BottomBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isLastStep = controller.currentStep.value == 5;

      return Container(
        padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
        color: Colors.white,
        child: isLastStep
            ? Row(
          children: [
            // Save Draft
            Expanded(
              child: CustomElevatedButton(
                onPressed: controller.saveDraft,
                isOutLined: true,
                outLineColour: ConstColor.primaryColor,
                height: 48,
                top: 0,
                left: 0,
                right: 0,
                child: CustomText(
                  title: ConstString.saveDraft,
                  textColor: ConstColor.primaryColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            // Publish
            Expanded(
              child: CustomElevatedButton(
                onPressed: controller.publishProperty,
                color: ConstColor.primaryColor,
                height: 52,
                top: 0,
                left: 0,
                right: 0,
                child: CustomText(
                  title: ConstString.publishProperty,
                  textColor: Colors.white,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
            ),
          ],
        )
            : CustomElevatedButton(
          onPressed: controller.nextStep,
          color: ConstColor.primaryColor,
          height: 48,
          top: 0,
          left: 0,
          right: 0,
          child: CustomText(
            title: ConstString.continueText,
            textColor: Colors.white,
            textSize: 15.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ),
      );
    });
  }
}
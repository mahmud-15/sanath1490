import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../Controller/add_listing_controller.dart';

class Step4FeatureDescription extends StatelessWidget {
  final AddListingController controller;

  const Step4FeatureDescription({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Features label ──────────────────────
        Row(
          children: [
            CustomText(
              title: ConstString.features,
              textColor: ConstColor.titleColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            CustomText(
              title: ' *',
              textColor: Colors.red,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ],
        ),
        SizedBox(height: 10.h),

        // ─── Features grid (2 columns) ───────────
        Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 3.4,
          children: controller.allFeatures.map((feature) {
            final isSelected = controller.isFeatureSelected(feature);
            return GestureDetector(
              onTap: () => controller.toggleFeature(feature),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ConstColor.outLineColor),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 8.w),
                    // ─── Checkbox ───────────
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      width: 18.w,
                      height: 18.w,
                      decoration: BoxDecoration(
                        color: isSelected ? ConstColor.primaryColor : Colors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
                        ),
                      ),
                      child: isSelected
                          ? Icon(Icons.check, size: 12.sp, color: Colors.white)
                          : null,
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: CustomText(
                        title: feature,
                        textColor: ConstColor.titleColor,
                        textSize: 11.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),

        // ─── Description ─────────────────────────
        Row(
          children: [
            CustomText(
              title: ConstString.description,
              textColor: ConstColor.titleColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            CustomText(
              title: ' *',
              textColor: Colors.red,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ],
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          textController: controller.descriptionController,
          hintText: const Text(ConstString.descriptionHint),
          maxLine: 6,
          minLines: 6,
        ),

        SizedBox(height: 16.h),
      ],
    );
  }
}
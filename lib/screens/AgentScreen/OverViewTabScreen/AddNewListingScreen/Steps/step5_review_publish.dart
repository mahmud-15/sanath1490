import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../Controller/add_listing_controller.dart';

class Step5ReviewPublish extends StatelessWidget {
  final AddListingController controller;

  const Step5ReviewPublish({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final completed = controller.completedSteps;
      final total = 4;

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Header ─────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomText(
                      title: '📋 ',
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: ConstString.listingChecklist,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ],
                ),
                CustomText(
                  title: '$completed/${total}complete',
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),

            SizedBox(height: 16.h),

            // ─── Checklist items ─────────────────
            _ChecklistItem(
              label: 'Property Basics',
              isDone: controller.step1Done,
            ),
            _ChecklistItem(
              label: 'Photos & Media',
              isDone: controller.step2Done,
            ),
            _ChecklistItem(
              label: 'Property details completed',
              isDone: controller.step3Done,
            ),
            _ChecklistItem(
              label: 'Feature & Description',
              isDone: controller.step4Done,
            ),
          ],
        ),
      );
    });
  }
}

// ─── Single checklist row ──────────────────────────
class _ChecklistItem extends StatelessWidget {
  final String label;
  final bool isDone;

  const _ChecklistItem({required this.label, required this.isDone});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          // ─── Status icon ──────────────────────
          Container(
            width: 26.w,
            height: 26.w,
            decoration: BoxDecoration(
              color: isDone ? ConstColor.secondaryColor : Colors.orange,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                isDone ? Icons.check : Icons.close,
                size: 14.sp,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            title: label,
            textColor: ConstColor.titleColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
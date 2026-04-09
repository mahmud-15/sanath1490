import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';

class SortBottomSheetWidget extends StatelessWidget {
  final dynamic controller;

  const SortBottomSheetWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final List<String> sortOptions = [
      "Price: Low to High",
      "Price: High to Low",
      "Newest First",
      "Old First",
      "Nearest First",
    ];

    return Container(
      decoration: BoxDecoration(
        color: ConstColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 78.w,
            height: 5.h,
            margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
            decoration: BoxDecoration(
              color: ConstColor.bodyColor.withAlpha(120),
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),

          // ─── Title ────────────────────────────────
          CustomText(
            title: ConstString.sort,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.titleColor,
          ),
          SizedBox(height: 16.h),

          Container(
            margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 32.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: ListView.separated(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: sortOptions.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  thickness: 1,
                  color: ConstColor.outLineColor,
                );
              },
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    // Update controller value & close BottomSheet
                    controller.selectedSort.value = sortOptions[index];
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    child: CustomText(
                      title: sortOptions[index],
                      textSize: 16.sp,
                      textColor: ConstColor.bodyColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

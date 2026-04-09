import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../Widget/text/custom_text.dart';
import '../../../../constant/const_color.dart';
import '../Controller/filter_controller.dart';

class AddedToSiteBottomSheetWidget extends StatelessWidget {
  final FilterController controller;

  const AddedToSiteBottomSheetWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ConstColor.backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // ─── Drag Handle Indicator ────────────────
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
            decoration: BoxDecoration(
              color: ConstColor.iconColor.withAlpha(120),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          // ─── Title ────────────────────────────────
          CustomText(
            title: "Added to site",
            textSize: 16.sp,
            fontWeight: FontWeight.w700,
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
              itemCount: controller.addedToSiteOptions.length,
              separatorBuilder: (context, index) {
                return Divider(
                  height: 1,
                  thickness: 1,
                  color: ConstColor.outLineColor,
                );
              },
              itemBuilder: (context, index) {
                final String option = controller.addedToSiteOptions[index];

                return InkWell(
                  onTap: () {
                    controller.selectAddedToSite(option);
                    Get.back();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                    child: CustomText(
                      title: option,
                      textSize: 14.sp,
                      textColor: ConstColor.bodyColor,
                      fontWeight: FontWeight.w400,
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
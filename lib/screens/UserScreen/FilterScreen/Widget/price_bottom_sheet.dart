import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';

import '../../../../Widget/text/custom_text.dart';

class MinPriceBottomSheetWidget extends StatelessWidget {
  final TextEditingController controller;

  const MinPriceBottomSheetWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    final List<String> priceList = [
      "No Price",
      "£ 50000",
      "£ 60000",
      "£ 70000",
      "£ 80000",
      "£ 90000",
      "£ 100000",
      "£ 110000",
      "£ 120000",
      "£ 130000",
      "£ 140000",
      "£ 150000",
    ];

    return Container(
      height: Get.height * 0.85,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [

          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.only(top: 12.h, bottom: 16.h),
            decoration: BoxDecoration(
              // Using withAlpha instead of withOpacity (Rule5)
              color: Colors.grey.withAlpha(120),
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),

          // ─── Title ────────────────────────────────
          CustomText(
            title: ConstString.minPrice,
            textSize: 16.sp,
            fontWeight: FontWeight.w600,
            textColor: ConstColor.titleColor,
          ),

          SizedBox(height: 16.h),

          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 24.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: ListView.separated(
                padding: EdgeInsets.zero,
                physics: const BouncingScrollPhysics(),
                itemCount: priceList.length,
                separatorBuilder: (context, index) {
                  return Divider(
                    height: 1,
                    thickness: 1,
                    color: Colors.grey.withAlpha(40),
                  );
                },
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      controller.text = priceList[index] == "No Price" ? "" : priceList[index];
                      Get.back();
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: CustomText(
                        title: priceList[index],
                        textSize: 16.sp,
                        textColor: ConstColor.bodyColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
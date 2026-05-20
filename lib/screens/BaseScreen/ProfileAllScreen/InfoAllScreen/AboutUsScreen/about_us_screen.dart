import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/AuthAppBar/global_app_bar.dart';
import '../InfoController/info_controller.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InfoController(), permanent: false);

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.about),
      body: Obx(() {
        if (controller.isAboutLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.aboutContent.value.isEmpty) {
          return const Center(child: Text('No content available'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14.r),
            ),
            child: CustomText(
              title: controller.aboutContent.value,
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
              maxLine: 999,
              textHeight: 1.6,
            ),
          ),
        );
      }),
    );
  }
}
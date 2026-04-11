import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: 'About us'),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: CustomText(
            title:
            'My Home is a modern property marketplace designed to make finding a home simple and convenient.\n\n'
                'Our platform connects property buyers, renters, and agents in one easy to use mobile experience.\n\n'
                'Users can search properties with powerful filters, explore listings on an interactive map, and save their favourite homes for later.\n\n'
                'Agents can manage listings, track inquiries, and connect with potential clients through a dedicated dashboard.\n\n'
                'Our mission is to create a reliable and user friendly property discovery platform that helps people find the right home faster.',
            textColor: ConstColor.bodyColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
            maxLine: 30,
            textHeight: 1.6,
          ),
        ),
      ),
    );
  }
}
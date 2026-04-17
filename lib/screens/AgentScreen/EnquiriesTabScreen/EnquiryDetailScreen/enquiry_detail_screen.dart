import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/text/custom_text.dart';
import '../EnquiriesScreen/Controller/enquiries_controller.dart';

class EnquiryDetailScreen extends StatelessWidget {
  // final AgentEnquiryModel enquiry;

  const EnquiryDetailScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    final AgentEnquiryModel enquiry = (Get.arguments as AgentEnquiryModel?)
        ?? Get.find<AgentEnquiriesController>().allEnquiries.first;

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: Column(
        children: [
          // ─── App Bar ─────────────────────────
          _DetailAppBar(name: enquiry.name),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ─── Property Card ───────────────
                  _PropertyCard(),
                  SizedBox(height: 20.h),

                  // ─── Message Section ─────────────
                  _SectionTitle(title: 'Message'),
                  SizedBox(height: 10.h),
                  _MessageCard(enquiry: enquiry),
                  SizedBox(height: 20.h),

                  // ─── Contact Info Section ─────────
                  _SectionTitle(title: 'Contact Information'),
                  SizedBox(height: 10.h),
                  _ContactInfoCard(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _DetailAppBar extends StatelessWidget {
  final String name;

  const _DetailAppBar({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.primaryColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 10.h,
        bottom: 14.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              width: 34.w,
              height: 34.h,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(30),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.arrow_back, color: Colors.white, size: 16.sp),
            ),
          ),
          SizedBox(width: 12.w),
          CustomText(
            title: name,
            textColor: Colors.white,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      textColor: ConstColor.titleColor,
      textSize: 16.sp,
      fontWeight: FontWeight.w700,
      maxLine: 1,
    );
  }
}

// ─────────────────────────────────────────
class _PropertyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.outLineColor),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppImage(
              path: 'assets/images/location_img2.jpg',
              width: 100.w,
              height: 100.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: '£875,000',
                  textColor: ConstColor.primaryColor,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: 'Stunning Victorian Terrace',
                  textColor: ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: '42 Morning Lane, London',
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _MessageCard extends StatelessWidget {
  final AgentEnquiryModel enquiry;

  const _MessageCard({required this.enquiry});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: ConstColor.outLineColor),
          ),
          child: CustomText(
            title:
                'Hi, I am very interested in this property. Could I arrange a viewing this weekend? I am a cash buyer looking to move quickly. We have already sold our current home.',
            textColor: ConstColor.titleColor,
            textSize: 12.sp,
            fontWeight: FontWeight.w400,
            maxLine: 10,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Icon(
              Icons.access_time_outlined,
              size: 13.sp,
              color: ConstColor.bodyColor,
            ),
            SizedBox(width: 4.w),
            CustomText(
              title: 'Received ${enquiry.time}',
              textColor: ConstColor.bodyColor,
              textSize: 10.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ],
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
class _ContactInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.outLineColor),
      ),
      child: Column(
        children: [
          _ContactRow(
            icon: "assets/icons/profile_icon.svg",
            label: ConstString.fullName,
            value: 'Emily Watson',
          ),
          _ContactRow(
            icon: "assets/icons/email.svg",
            label: ConstString.email,
            value: 'emily@email.com',
          ),
          _ContactRow(
            icon: "assets/icons/phone.svg",
            label: ConstString.phone,
            value: '+44 7911 123456',
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _ContactRow extends StatelessWidget {
  final String icon;
  final String label;
  final String value;

  const _ContactRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
          child: Row(
            children: [
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: ConstColor.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    colorFilter: ColorFilter.mode(
                      ConstColor.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: label,
                    textColor: ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: value,
                    textColor: ConstColor.titleColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

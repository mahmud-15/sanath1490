import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import 'Controller/enquiries_controller.dart';

class EnquiryDetailsScreen extends StatelessWidget {
  const EnquiryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final item = Get.arguments as EnquiryModel;

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.enquiresDetails),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _PropertyCard(item: item),
            SizedBox(height: 16.h),
            _SectionCard(
              title: ConstString.yourMessage,
              child: CustomText(
                title: item.message,
                textColor: ConstColor.bodyColor,
                textSize: 13.sp,
                fontWeight: FontWeight.w400,
                maxLine: 10,
                textHeight: 1.6,
              ),
            ),
            SizedBox(height: 16.h),
            _SectionCard(
              title: ConstString.sentTo,
              child: _AgentInfo(item: item),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final EnquiryModel item;

  const _PropertyCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: AppImage(
              path: item.imagePath,
              width: 90.w,
              height: 80.h,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CustomText(
                        title: item.price,
                        textColor: ConstColor.primaryColor,
                        textSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                      decoration: BoxDecoration(color: ConstColor.secondaryColor),
                      child: CustomText(
                        title: ConstString.enquired,
                        textColor: Colors.white,
                        textSize: 10.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 3.h),
                CustomText(
                  title: item.title,
                  textColor: ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: item.address,
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    SvgPicture.asset('assets/icons/bed_room_icon.svg', width: 13.w,
                        colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                    SizedBox(width: 3.w),
                    CustomText(title: '${item.bedrooms}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
                    SizedBox(width: 10.w),
                    SvgPicture.asset('assets/icons/bathrooms_icon.svg', width: 13.w,
                        colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                    SizedBox(width: 3.w),
                    CustomText(title: '${item.bathrooms}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
                    SizedBox(width: 10.w),
                    SvgPicture.asset('assets/icons/square_fit_icon.svg', width: 13.w,
                        colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                    SizedBox(width: 3.w),
                    CustomText(title: '${item.sizeSqFt}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionCard extends StatelessWidget {
  final String title;
  final Widget child;

  const _SectionCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: title,
          textColor: ConstColor.titleColor,
          textSize: 16.sp,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        SizedBox(height: 8.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(14.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: child,
        ),
      ],
    );
  }
}

class _AgentInfo extends StatelessWidget {
  final EnquiryModel item;

  const _AgentInfo({required this.item});

  @override
  Widget build(BuildContext context) {
    final initial = item.agentName.isNotEmpty
        ? item.agentName[0].toUpperCase()
        : '?';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: CustomText(
                  title: initial,
                  textColor: Colors.white,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: item.agentName,
                  textColor: ConstColor.titleColor,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
                SizedBox(height: 2.h),
                CustomText(
                  title: item.enquiredDate,
                  textColor: ConstColor.bodyColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 14.h),
        Divider(height: 1.h, color: ConstColor.outLineColor),
        SizedBox(height: 14.h),
        _ContactRow(
          icon: 'assets/icons/phone_icon.svg',
          text: item.agentPhone,
          textColor: ConstColor.primaryColor,
          onTap: () async {
            final uri = Uri(scheme: 'tel', path: item.agentPhone);
            if (await canLaunchUrl(uri)) launchUrl(uri);
          },
        ),
        SizedBox(height: 12.h),
        _ContactRow(
          icon: 'assets/icons/email.svg',
          text: item.agentEmail,
          textColor: ConstColor.primaryColor,
          onTap: () async {
            final uri = Uri(scheme: 'mailto', path: item.agentEmail);
            if (await canLaunchUrl(uri)) launchUrl(uri);
          },
        ),
      ],
    );
  }
}

class _ContactRow extends StatelessWidget {
  final String icon;
  final String text;
  final Color textColor;
  final VoidCallback onTap;

  const _ContactRow({
    required this.icon,
    required this.text,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset(icon, width: 18.w,
              colorFilter: ColorFilter.mode(textColor, BlendMode.srcIn)),
          SizedBox(width: 10.w),
          CustomText(
            title: text,
            textColor: textColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
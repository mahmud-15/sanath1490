import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/text/custom_text.dart';
import '../EnquiryDetailScreen/enquiry_detail_screen.dart';
import 'Controller/enquiries_controller.dart';

class AgentEnquiriesScreen extends StatelessWidget {
  const AgentEnquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AgentEnquiriesController>();
    final bool shouldShowBack = Get.arguments == true;

    return Scaffold(
      appBar: GlobalAppBar(
        title: ConstString.enquiries,
        showBack: shouldShowBack,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16.h),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: _TabToggle(controller: controller),
          ),
          SizedBox(height: 16.h),


          Expanded(
            child: Obx(() {
              final currentList = controller.currentList;

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: currentList.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (context, index) {
                  final enquiry = currentList[index];
                  return _AgentEnquiryCard(
                    enquiry: enquiry,
                    onTap: () => Get.to(() => EnquiryDetailScreen()),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}


class _TabToggle extends StatelessWidget {
  final AgentEnquiriesController controller;

  const _TabToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
      children: [
        _TabItem(
          label: 'All (${controller.allCount})',
          isSelected: controller.selectedTab.value == 0,
          onTap: () => controller.onTabChanged(0),
        ),
        SizedBox(width: 8.w),
        _TabItem(
          label: 'New (${controller.newCount})',
          isSelected: controller.selectedTab.value == 1,
          onTap: () => controller.onTabChanged(1),
        ),
      ],
    ));
  }
}


class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected ? ConstColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor),
        ),
        child: CustomText(
          title: label,
          textColor: isSelected ? Colors.white : ConstColor.titleColor,
          textSize: 16.sp,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          maxLine: 1,
        ),
      ),
    );
  }
}


class _AgentEnquiryCard extends StatelessWidget {
  final AgentEnquiryModel enquiry;
  final VoidCallback onTap;

  const _AgentEnquiryCard({required this.enquiry, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: ConstColor.primaryColor,
                    borderRadius: BorderRadius.circular(6.r),
                  ),
                  alignment: Alignment.center,
                  child: CustomText(
                    title: enquiry.initials,
                    textColor: Colors.white,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
                SizedBox(width: 10.w),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: enquiry.name,
                        textColor: ConstColor.titleColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined,
                              size: 12.sp, color: ConstColor.bodyColor),
                          SizedBox(width: 4.w),
                          CustomText(
                            title: enquiry.time,
                            textColor: ConstColor.bodyColor,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                if (enquiry.isNew)
                  Row(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: const BoxDecoration(
                          color: ConstColor.primaryColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor.withAlpha(15),
                          border: Border.all(color: ConstColor.outLineColor),
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: CustomText(
                          title: 'New',
                          textColor: ConstColor.titleColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
            SizedBox(height: 10.h),

            CustomText(
              title: enquiry.message,
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../widget/AuthAppBar/global_app_bar.dart';
import 'Controller/enquiries_controller.dart';

class EnquiriesScreen extends StatelessWidget {
  const EnquiriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EnquiriesController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: 'Enquiries', showBack: false),
      body: Obx(() {
        if (controller.enquiries.isEmpty) {
          return Center(
            child: CustomText(
              title: 'No enquiries yet',
              textColor: ConstColor.bodyColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          );
        }

        return ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
          itemCount: controller.enquiries.length,
          separatorBuilder: (_, __) => SizedBox(height: 10.h),
          itemBuilder: (context, index) {
            final item = controller.enquiries[index];
            return _EnquiryCard(
              item: item,
              onTap: () => controller.onCardTap(item),
            );
          },
        );
      }),
    );
  }
}

// ─────────────────────────────────────────────────────
// Horizontal enquiry card
// ─────────────────────────────────────────────────────
class _EnquiryCard extends StatelessWidget {
  final EnquiryModel item;
  final VoidCallback onTap;

  const _EnquiryCard({required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Property Image ───────────────────
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: AppImage(
                path: item.imagePath,
                width: 110.w,
                height: 110.h,
                fit: BoxFit.cover,
              ),
            ),

            // ─── Details ──────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 10.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ─── Price + Enquired badge ────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            title: item.price,
                            textColor: ConstColor.titleColor,
                            textSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 3.h,
                          ),
                          decoration: BoxDecoration(
                            color: ConstColor.secondaryColor,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: CustomText(
                            title: 'Enquired',
                            textColor: Colors.white,
                            textSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 4.h),

                    // ─── Title ────────────────────
                    CustomText(
                      title: item.title,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),

                    SizedBox(height: 2.h),

                    // ─── Address ──────────────────
                    CustomText(
                      title: item.address,
                      textColor: ConstColor.bodyColor,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),

                    SizedBox(height: 8.h),

                    // ─── Specs row ─────────────────
                    Row(
                      children: [
                        // Bedrooms
                        Icon(Icons.bed_outlined, size: 13.sp, color: ConstColor.bodyColor),
                        SizedBox(width: 3.w),
                        CustomText(
                          title: '${item.bedrooms}',
                          textColor: ConstColor.bodyColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                        SizedBox(width: 10.w),

                        // Bathrooms
                        Icon(Icons.bathtub_outlined, size: 13.sp, color: ConstColor.bodyColor),
                        SizedBox(width: 3.w),
                        CustomText(
                          title: '${item.bathrooms}',
                          textColor: ConstColor.bodyColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                        SizedBox(width: 10.w),

                        // Size
                        Icon(Icons.straighten_outlined, size: 13.sp, color: ConstColor.bodyColor),
                        SizedBox(width: 3.w),
                        CustomText(
                          title: '${item.sizeSqFt}',
                          textColor: ConstColor.bodyColor,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../Controller/my_listing_controller.dart';

class ListingCard extends StatelessWidget {
  final MyListingModel item;
  final VoidCallback onTap;

  const ListingCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Property image ───────────────────
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
                    // ─── Price + Active badge ──────
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: CustomText(
                            title: item.price,
                            textColor: ConstColor.primaryColor,
                            textSize: 17.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: ConstColor.secondaryColor.withAlpha(30),
                            // borderRadius: BorderRadius.circular(4.r),
                            // border: Border.all(color: ConstColor.secondaryColor),
                          ),
                          child: CustomText(
                            title: ConstString.active,
                            textColor: Color(0xFF22C55E),
                            textSize: 9.sp,
                            fontWeight: FontWeight.w700,
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

                    SizedBox(height: 4.h),

                    // ─── Address ──────────────────
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/icons/location_icon.svg',
                          width: 12.w,
                          colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                        ),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: CustomText(
                            title: item.address,
                            textColor: ConstColor.bodyColor,
                            textSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8.h),

                    // ─── Specs ────────────────────
                    Row(
                      children: [
                        SvgPicture.asset('assets/icons/bed_room_icon.svg', width: 13.w,
                            colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                        SizedBox(width: 3.w),
                        CustomText(title: '${item.beds}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
                        SizedBox(width: 10.w),
                        SvgPicture.asset('assets/icons/bathrooms_icon.svg', width: 13.w,
                            colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                        SizedBox(width: 3.w),
                        CustomText(title: '${item.baths}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
                        SizedBox(width: 10.w),
                        SvgPicture.asset('assets/icons/square_fit_icon.svg', width: 13.w,
                            colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn)),
                        SizedBox(width: 3.w),
                        CustomText(title: '${item.sqFt}', textColor: ConstColor.bodyColor, textSize: 11.sp, fontWeight: FontWeight.w400, maxLine: 1),
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
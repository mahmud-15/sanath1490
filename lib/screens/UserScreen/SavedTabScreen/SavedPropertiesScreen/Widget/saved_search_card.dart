import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart' show ConstColor;
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../Controller/saved_controller.dart';

class SavedSearchCard extends StatelessWidget {
  final SavedSearchModel search;
  final VoidCallback onRemove;
  final VoidCallback onToggleAlert;
  final VoidCallback onViewResults;

  const SavedSearchCard({super.key,
    required this.search,
    required this.onRemove,
    required this.onToggleAlert,
    required this.onViewResults,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Location + new badge + close ──────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 13),
                child: SvgPicture.asset("assets/icons/location_icon.svg",
                width: 16.w,
                  height: 16.h,
                  colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                ),
              ),
              SizedBox(width: 6.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: search.location,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: '${search.type} • ${search.beds}',
                      textColor: ConstColor.bodyColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              // ─── New count badge ──────────────────


              // ─── Close / Remove button ────────────
              GestureDetector(
                onTap: onRemove,
                child: SvgPicture.asset(
                  "assets/icons/remove_icon.svg",
                  colorFilter: ColorFilter.mode(ConstColor.iconColor, BlendMode.srcIn),
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // ─── Price range ───────────────────────────
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: 24.w),
                child: CustomText(
                  title: search.priceRange,
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ),
              Spacer(),
              if (search.newCount > 0) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 13.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ConstColor.secondaryColor,
                  ),
                  child: CustomText(
                    title: '${search.newCount} new',
                    textColor: Colors.white,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
                SizedBox(width: 8.w),
              ],
            ],
          ),

          SizedBox(height: 10.h),
          Divider(height: 1.h, color: ConstColor.outLineColor),
          SizedBox(height: 10.h),

          // ─── Alerts toggle + View results ──────────
          Row(
            children: [
              // ─── Alert toggle ─────────────────────
              GestureDetector(
                onTap: onToggleAlert,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      search.alertsOn
                          ? "assets/icons/notification_icon.svg"
                          : "assets/icons/notification_off_icon.svg",
                      width: 13.w,
                      height: 13.h,
                    ),
                    SizedBox(width: 5.w),
                    CustomText(
                      title: search.alertsOn ? 'Alerts on' : 'Alerts off',
                      textColor: search.alertsOn
                          ? ConstColor.primaryColor
                          : ConstColor.bodyColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ─── View results ─────────────────────
              GestureDetector(
                onTap: onViewResults,
                child: Row(
                  children: [
                    CustomText(
                      title: ConstString.viewResults,
                      textColor: ConstColor.primaryColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 14.sp,
                      color: ConstColor.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
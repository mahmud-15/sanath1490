import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../Widget/text/custom_text.dart';
import '../../../../../../constant/const_color.dart';
import '../model/performanceModel.dart' show EnquiryModel;

class EnquiryListItem extends StatelessWidget {
  final EnquiryModel enquiry;
  final VoidCallback onTap;
  final bool showDivider;

  const EnquiryListItem({
    super.key,
    required this.enquiry,
    required this.onTap,
    this.showDivider = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8.r),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
            child: Row(
              children: [
                // ─── Avatar ───────────────────────
                _EnquiryAvatar(initials: enquiry.initials),
                SizedBox(width: 12.w),

                // ─── Name + Subtitle ──────────────
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: enquiry.name,
                        textColor: ConstColor.titleColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        maxLine: 1,
                      ),
                      SizedBox(height: 2.h),
                      CustomText(
                        title: enquiry.subtitle,
                        textColor: ConstColor.bodyColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 11.sp,
                            color: ConstColor.bodyColor,
                          ),
                          SizedBox(width: 3.w),
                          CustomText(
                            title: enquiry.timeAgo,
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

                // ─── New Badge + Arrow ────────────
                Row(
                  children: [
                    if (enquiry.isNew) ...[
                      _NewBadge(),
                      SizedBox(width: 6.w),
                    ],
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 13.sp,
                      color: ConstColor.bodyColor,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            color: ConstColor.borderColor,
            indent: 0.w,
            endIndent: 0.w,
          ),
      ],
    );
  }
}

// ─────────────────────────────────────────
class _EnquiryAvatar extends StatelessWidget {
  final String initials;

  const _EnquiryAvatar({required this.initials});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 40.w,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(25),
        borderRadius: BorderRadius.circular(4.r),
      ),
      alignment: Alignment.center,
      child: CustomText(
        title: initials,
        textColor: ConstColor.primaryColor,
        textSize: 14.sp,
        fontWeight: FontWeight.w700,
        maxLine: 1,
      ),
    );
  }
}

// ─────────────────────────────────────────
class _NewBadge extends StatelessWidget {
  const _NewBadge();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor.withAlpha(20),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: CustomText(
        title: 'New',
        textColor: ConstColor.primaryColor,
        textSize: 11.sp,
        fontWeight: FontWeight.w600,
        maxLine: 1,
      ),
    );
  }
}
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';

class RecentItemPlaceholder extends StatelessWidget {
  final String item;
  const RecentItemPlaceholder({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          _IconBox(child: const SizedBox()),
          SizedBox(width: 12.w),
          CustomText(
            title: item,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
class _IconBox extends StatelessWidget {
  final Widget child;
  final Color? color;

  const _IconBox({required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 46.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: color ?? Colors.grey.withAlpha(40),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Center(child: child),
    );
  }
}
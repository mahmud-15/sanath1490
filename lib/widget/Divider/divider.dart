import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constant/const_color.dart';
import '../../constant/const_string.dart';
import '../text/custom_text.dart';

class OrDivider extends StatelessWidget {
  const OrDivider();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [ConstColor.outLineColor, Color(0xFF4A5565)],
            ).createShader(bounds),
            child: Divider(color: Colors.white, thickness: 1),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          child: CustomText(
            title: ConstString.or,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Expanded(
          child: ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [Color(0xFF4A5565), ConstColor.outLineColor],
            ).createShader(bounds),
            child: Divider(color: Colors.white, thickness: 1),
          ),
        ),
      ],
    );
  }
}
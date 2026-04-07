import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;

  const AuthAppBar({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.primaryColor,
      elevation: 0,
      leadingWidth: 56.w,
      leading: GestureDetector(
        onTap: onBack ?? () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.only(left: 16.w),
          width: 40.w,
          height: 40.h,
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(30),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.arrow_back,
            size: 20.sp,
            color: ConstColor.backgroundColor,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
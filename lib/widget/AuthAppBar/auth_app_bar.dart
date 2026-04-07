import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onBack;

  const AuthAppBar({super.key, this.onBack});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFFF9FAFB),
      elevation: 0,
      leadingWidth: 56.w,
      leading: GestureDetector(
        onTap: onBack ?? () => Navigator.pop(context),
        child: Container(
          margin: EdgeInsets.only(left: 16.w),
          width: 36.w,
          height: 36.h,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Icon(
            Icons.arrow_back,
            size: 18.sp,
            color: const Color(0xFF0B3C6D),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../Controller/my_listing_controller.dart';

class ListingOptionsBottomSheet {
  static void show(MyListingModel item, {VoidCallback? onEdit, VoidCallback? onDelete}) {
    Get.bottomSheet(
      _ListingOptionsSheet(onEdit: onEdit, onDelete: onDelete),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      isScrollControlled: true,
    );
  }
}

class _ListingOptionsSheet extends StatelessWidget {
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const _ListingOptionsSheet({this.onEdit, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Handle bar ───────────────────────
          Container(
            width: 50.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: ConstColor.iconColor,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 15.h),

          // ─── Edit option ──────────────────────
          InkWell(
            onTap: () {
              Get.back();
              onEdit?.call();
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/pen_icon.svg',
                    width: 20.w,
                    colorFilter: ColorFilter.mode(ConstColor.titleColor, BlendMode.srcIn),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    title: ConstString.edit,
                    textColor: ConstColor.titleColor,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),

          Divider(height: 1.h, color: ConstColor.outLineColor),

          // ─── Delete option ────────────────────
          InkWell(
            onTap: () {
              Get.back();
              onDelete?.call();
            },
            borderRadius: BorderRadius.circular(10.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 4.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/icons/delete_icon.svg',
                    width: 20.w,
                    colorFilter: const ColorFilter.mode(Colors.red, BlendMode.srcIn),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    title: ConstString.delete,
                    textColor: Colors.red,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
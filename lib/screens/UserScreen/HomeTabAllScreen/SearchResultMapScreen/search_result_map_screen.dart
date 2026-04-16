import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import '../../../../constant/const_color.dart';
import '../../../../routes/app_routes/app_routes.dart';
import '../../../../widget/text/custom_text.dart';
import '../PropertyListScreen/Controller/property_list_controller.dart';

class SearchResultMapScreen extends StatelessWidget {
  const SearchResultMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyListController>();

    return Scaffold(
      appBar: GlobalAppBar(
        title: ConstString.london,
        action: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.filterScreen);
              },
              child: SvgPicture.asset(
                "assets/icons/filter_icon.svg",
                colorFilter: ColorFilter.mode(
                  ConstColor.outLineColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            SizedBox(width: 15.w),
            GestureDetector(
              onTap: () {},
              child: SvgPicture.asset(
                "assets/icons/favourite_icon.svg",
                colorFilter: ColorFilter.mode(
                  ConstColor.outLineColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SafeArea(child: Stack(children: [const _MapView()])),

      // ─── Bottom Toggle ────────────────────
      bottomNavigationBar: _ListMapToggle(controller: controller),
    );
  }
}

class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0xFFE8EAF0),
      child: Image.asset("assets/images/map_img.webp",
      fit: BoxFit.cover,
      ),

    );
  }
}

// ─────────────────────────────────────────
class _ListMapToggle extends StatelessWidget {
  final PropertyListController controller;

  const _ListMapToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        border: Border(
          top: BorderSide(color: ConstColor.outLineColor, width: 1.h),
        ),
      ),
      child: Obx(
        () => Padding(
          padding: EdgeInsets.only(bottom: 23.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _ToggleItem(
                icon: Icons.list,
                label: 'List',
                isSelected: controller.isListView.value,
                onTap: () {
                  controller.isListView.value = true;
                  Get.back();
                },
              ),
              Container(
                height: 20.h,
                width: 1.w,
                color: ConstColor.outLineColor,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
              ),
              _ToggleItem(
                icon: Icons.map_outlined,
                label: 'Map',
                isSelected: !controller.isListView.value,
                onTap: () => controller.isListView.value = false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _ToggleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? ConstColor.secondaryColor : ConstColor.bodyColor;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 6.w),
          CustomText(
            title: label,
            textColor: color,
            textSize: 13.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

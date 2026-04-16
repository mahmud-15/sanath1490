import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../HomeScreen/Controller/home_controller.dart';
import '../HomeScreen/Widget/property_card.dart';
import '../SearchResultMapScreen/search_result_map_screen.dart';
import 'Controller/property_list_controller.dart';
import 'Widget/sort_bottom_sheet.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyListController());
    final homeController = Get.find<HomeController>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,

      // ─── AppBar ────────────────────────────────────
      appBar: GlobalAppBar(
        title: ConstString.london,
        action: Row(
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppRoutes.filterScreen);
              },
              child: SvgPicture.asset("assets/icons/filter_icon.svg",
              colorFilter: ColorFilter.mode(ConstColor.outLineColor, BlendMode.srcIn),

              ),
            ),
            SizedBox(width: 15.w),
            Obx(() => GestureDetector(
              onTap: () => controller.toggleFavourite(),
              child: SvgPicture.asset(
                controller.isFavourite.value
                    ? "assets/icons/favourite_click_icon.svg"
                    : "assets/icons/favourite_icon.svg",
                width: 22.w,
                height: 22.w,
                colorFilter: controller.isFavourite.value
                    ? null
                    : ColorFilter.mode(ConstColor.outLineColor, BlendMode.srcIn),
              ),
            )),
          ],
        ),
      ),

      // ─── Body ──────────────────────────────────────
      body: Column(
        children: [
          // ─── Results count + Sort dropdown ─────────
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => CustomText(
                  title: '${homeController.currentProperties.length} results',
                  textColor: ConstColor.bodyColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                )),

                Obx(() => GestureDetector(
                  onTap: () {
                    Get.bottomSheet(
                      SortBottomSheetWidget(controller: controller),
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                    );
                  },
                  child: Row(
                    children: [
                      CustomText(
                        title: controller.selectedSort.value,
                        textColor: ConstColor.titleColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        size: 18.sp,
                        color: ConstColor.titleColor,
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),

          Divider(height: 1.h, color: ConstColor.outLineColor),

          // ─── Property List ──────────────────────────
          Expanded(
            child: Obx(() => ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: homeController.currentProperties.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final property = homeController.currentProperties[index];
                return PropertyCard(
                  onTap: () {
                    Get.toNamed(
                      AppRoutes.propertyDetails,
                      arguments: property,
                    );
                  },
                  property: property,
                );
              },
            )),
          ),
        ],
      ),

        bottomNavigationBar: _ListMapToggle(controller: controller),
    );
  }
}

class _ListMapToggle extends StatelessWidget {
  final PropertyListController controller;

  const _ListMapToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        border: Border(
          top: BorderSide(color: ConstColor.outLineColor, width: 1.h),
        ),
      ),
      child: Obx(() => Padding(
        padding: EdgeInsets.only(bottom: 23.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ─── List Tab ───────────────────────────
            _ToggleItem(
              icon: Icons.list,
              label: ConstString.list,
              isSelected: controller.isListView.value,
              onTap: () => controller.isListView.value = true,
            ),

            // ─── Divider ────────────────────────────
            Container(
              height: 20.h,
              width: 1.w,
              color: ConstColor.outLineColor,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
            ),

            // ─── Map Tab ────────────────────────────
            _ToggleItem(
              icon: Icons.map_outlined,
              label: ConstString.map,
              isSelected: !controller.isListView.value,
              onTap: () {
                controller.isListView.value = false;
                Get.to(() => const SearchResultMapScreen());
              },
            ),
          ],
        ),
      )),
    );
  }
}


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
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w600,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
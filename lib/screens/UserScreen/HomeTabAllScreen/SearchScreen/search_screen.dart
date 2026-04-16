import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/search_screen_controller.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SearchScreenController());

    return Scaffold(
      appBar: _SearchAppBar(controller: controller),
      body: Obx(() {
        if (controller.searchQuery.value.isNotEmpty) {
          return _SuggestionList(controller: controller);
        }
        return _DefaultSearchView(controller: controller);
      }),
    );
  }
}

class _SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final SearchScreenController controller;

  const _SearchAppBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.primaryColor,
      elevation: 0,
      automaticallyImplyLeading: false,
      titleSpacing: 0,
      title: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.w),
        child: Row(
          children: [
            // ─── Back Button ─────────────────────────
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(30),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.arrow_back, size: 18.sp, color: Colors.white),
              ),
            ),
            SizedBox(width: 10.w),

            // ─── Search TextField ─────────────────────
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: Color(0xFF002142),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ConstColor.bodyColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 10.w),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: TextField(
                        controller: controller.textEditingController,
                        autofocus: true,
                        onChanged: controller.onSearchChanged,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: ConstColor.backgroundColor,
                          fontFamily: 'Roboto',
                        ),
                        decoration: InputDecoration(
                          hintText: ConstString.searchLocationOr,
                          hintStyle: TextStyle(
                            fontSize: 14.sp,
                            color: ConstColor.iconColor,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.w400,
                          ),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      ),
                    ),

                    Obx(
                      () => controller.searchQuery.value.isNotEmpty
                          ? GestureDetector(
                              onTap: controller.clearSearch,
                              child: Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: SvgPicture.asset(
                                  "assets/icons/remove_icon.svg",
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
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

  @override
  Size get preferredSize => Size.fromHeight(56.h);
}

class _DefaultSearchView extends StatelessWidget {
  final SearchScreenController controller;

  const _DefaultSearchView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Use Current Location ─────────────────
        InkWell(
          onTap: controller.useCurrentLocation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 46.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withAlpha(280),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      "assets/icons/current_location_icon.svg",
                      width: 20.w,
                      height: 20.h,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                CustomText(
                  title: ConstString.useCurrentLocation,
                  textColor: ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ),

        Divider(height: 1.h, color: ConstColor.outLineColor),

        // ─── Recent Searches Label ────────────────
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
          child: CustomText(
            title: ConstString.recentSearches,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ),

        // ─── Recent Search Items ──────────────────
        Obx(
          () => ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.recentSearches.length,
            itemBuilder: (context, index) {
              final item = controller.recentSearches[index];
              return InkWell(
                onTap: () => controller.onRecentTap(item),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50.w,
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.grey.withAlpha(280),
                          borderRadius: BorderRadius.circular(8),
                          // shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            "assets/icons/search_icon.svg",
                            width: 20.w,
                            height: 20.h,
                            colorFilter: ColorFilter.mode(
                              ConstColor.titleColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
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
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _SuggestionList extends StatelessWidget {
  final SearchScreenController controller;

  const _SuggestionList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final suggestions = controller.filteredSuggestions;

      if (suggestions.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.only(top: 60.h),
            child: CustomText(
              title: ConstString.noResultFound,
              textColor: ConstColor.bodyColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ),
        );
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        itemCount: suggestions.length,
        separatorBuilder: (_, _) => Divider(
          height: 1.h,
          indent: 16.w,
          endIndent: 16.w,
          color: ConstColor.outLineColor,
        ),
        itemBuilder: (context, index) {
          final suggestion = suggestions[index];
          return InkWell(
            onTap: () => controller.onSuggestionTap(suggestion),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              child: Row(
                children: [
                  Container(
                    width: 50.w,
                    height: 46.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withAlpha(280),
                      borderRadius: BorderRadius.circular(8),
                      // shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/icons/location_icon.svg",
                        width: 20.w,
                        height: 20.h,
                        colorFilter: ColorFilter.mode(
                          ConstColor.titleColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomText(
                      title: suggestion,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

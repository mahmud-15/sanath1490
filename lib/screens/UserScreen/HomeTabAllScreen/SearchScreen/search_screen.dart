import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppLoader/app_loader.dart';
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
        if (controller.isLoading.value) {
          return const Center(
            child: AppLoader(message: "Searching for results...",),
          );
        }
        if (controller.searchQuery.value.isNotEmpty) {
          return _SuggestionList(controller: controller);
        }
        return _DefaultSearchView(controller: controller);
      }),
    );
  }
}

// ─── Search AppBar ────────────────────────────────────
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
            Expanded(
              child: Container(
                height: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF002142),
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: ConstColor.bodyColor, width: 1.5),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
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
                    Obx(() => controller.searchQuery.value.isNotEmpty
                        ? GestureDetector(
                      onTap: controller.clearSearch,
                      child: Padding(
                        padding: EdgeInsets.only(right: 10.w),
                        child: SvgPicture.asset("assets/icons/remove_icon.svg"),
                      ),
                    )
                        : const SizedBox.shrink()),
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

// ─── Default View ─────────────────────────────────────
class _DefaultSearchView extends StatelessWidget {
  final SearchScreenController controller;

  const _DefaultSearchView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: controller.useCurrentLocation,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            child: Row(
              children: [
                _IconBox(
                  color: ConstColor.primaryColor.withAlpha(20),
                  child: SvgPicture.asset(
                    "assets/icons/current_location_icon.svg",
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                  ),
                ),
                SizedBox(width: 12.w),
                CustomText(
                  title: ConstString.useCurrentLocation,
                  textColor: ConstColor.primaryColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ),

        Divider(height: 1.h, color: ConstColor.outLineColor),

        Obx(() {
          if (controller.recentSearches.isEmpty) return const SizedBox.shrink();
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      title: ConstString.recentSearches,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    GestureDetector(
                      onTap: controller.clearRecentSearches,
                      child: CustomText(
                        title: 'Clear all history',
                        textColor: ConstColor.primaryColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        maxLine: 1,
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedList(
                key: controller.listKey,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                initialItemCount: controller.recentSearches.length,
                itemBuilder: (context, index, animation) {
                  final item = controller.recentSearches[index];
                  return SizeTransition(
                    sizeFactor: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: _RecentItem(
                        item: item,
                        onTap: () => controller.onRecentTap(item),
                        onRemove: () => controller.removeRecentSearch(index),
                      ),
                    ),
                  );
                },
              ),
            ],
          );
        }),
      ],
    );
  }
}

// ─── Suggestion List ──────────────────────────────────
class _SuggestionList extends StatelessWidget {
  final SearchScreenController controller;

  const _SuggestionList({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isSuggestionLoading.value) {
        return ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 8.h),
          itemCount: 4,
          itemBuilder: (_, _) => _ShimmerItem(),
        );
      }

      if (controller.searchQuery.value.trim().isEmpty) {
        return const SizedBox.shrink();
      }

      if (controller.suggestions.isEmpty) {
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
        itemCount: controller.suggestions.length,
        separatorBuilder: (_, _) => Divider(
          height: 1.h,
          indent: 16.w,
          endIndent: 16.w,
          color: ConstColor.outLineColor,
        ),
        itemBuilder: (context, index) {
          final suggestion = controller.suggestions[index];
          return InkWell(
            onTap: () => controller.onSuggestionTap(suggestion),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  _IconBox(
                    color: _typeColor(suggestion.type).withAlpha(25),
                    child: Icon(
                      _typeIcon(suggestion.type),
                      size: 18.sp,
                      color: _typeColor(suggestion.type),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: suggestion.label,
                          textColor: ConstColor.titleColor,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                        SizedBox(height: 2.h),
                        CustomText(
                          title: suggestion.subLabel,
                          textColor: ConstColor.bodyColor,
                          textSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                    decoration: BoxDecoration(
                      color: _typeColor(suggestion.type).withAlpha(20),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CustomText(
                      title: _typeLabel(suggestion.type),
                      textColor: _typeColor(suggestion.type),
                      textSize: 10.sp,
                      fontWeight: FontWeight.w600,
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

  IconData _typeIcon(String type) {
    switch (type) {
      case 'city': return Icons.location_city_outlined;
      case 'postalCode': return Icons.markunread_mailbox_outlined;
      case 'country': return Icons.flag_outlined;
      case 'title': return Icons.home_outlined;
      default: return Icons.search;
    }
  }

  Color _typeColor(String type) {
    switch (type) {
      case 'city': return ConstColor.primaryColor;
      case 'postalCode': return ConstColor.secondaryColor;
      case 'country': return Colors.purple;
      case 'title': return Colors.teal;
      default: return ConstColor.bodyColor;
    }
  }

  String _typeLabel(String type) {
    switch (type) {
      case 'city': return 'City';
      case 'postalCode': return 'Postal';
      case 'country': return 'Country';
      case 'title': return 'Property';
      default: return '';
    }
  }
}

// ─── Shimmer Item ─────────────────────────────────────
class _ShimmerItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Row(
        children: [
          Container(
            width: 46.w,
            height: 44.h,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  width: 80.w,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Icon Box ─────────────────────────────────────────
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

class _RecentItem extends StatelessWidget {
  final String item;
  final VoidCallback onTap;
  final VoidCallback onRemove;

  const _RecentItem({
    required this.item,
    required this.onTap,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Row(
          children: [
            _IconBox(
              child: SvgPicture.asset(
                "assets/icons/search_icon.svg",
                width: 18.w,
                height: 18.h,
                colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: CustomText(
                title: item,
                textColor: ConstColor.titleColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
            ),
            GestureDetector(
              onTap: onRemove,
              child: Icon(
                Icons.close,
                size: 18.sp,
                color: ConstColor.bodyColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


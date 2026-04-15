import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/my_listing_controller.dart';
import 'Widget/listing_card.dart';

class MyListingScreen extends StatelessWidget {
  const MyListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(MyListingController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      // ─── AppBar ──────────────────────────────────
      appBar: GlobalAppBar(
        title: ConstString.myListing,
        showBack: false,
        action: CustomElevatedButton(
          onPressed: controller.onAddNew,
          color: ConstColor.secondaryColor,
          height: 32,
          width: 100,
          top: 0,
          left: 0,
          right: 0,
          buttonBorderRadius: 4,
          child: CustomText(
            title: ConstString.addNew,
            textColor: Colors.white,
            textSize: 12.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 12.h),

          // ─── Search bar ───────────────────────────
          _SearchBar(controller: controller),

          SizedBox(height: 12.h),

          // ─── Sell / Rent tabs ─────────────────────
          _TabRow(controller: controller),

          SizedBox(height: 12.h),

          // ─── Listing cards ────────────────────────
          Expanded(
            child: Obx(() {
              final listings = controller.currentListings;

              if (listings.isEmpty) {
                return Center(
                  child: CustomText(
                    title: 'No listings found',
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
                itemCount: listings.length,
                separatorBuilder: (_, _) => SizedBox(height: 10.h),
                itemBuilder: (context, index) => ListingCard(
                  item: listings[index],
                  onTap: () => controller.onCardTap(listings[index]),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Search bar
// ─────────────────────────────────────────────────────
class _SearchBar extends StatelessWidget {
  final MyListingController controller;

  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44.h,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ConstColor.outLineColor),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          SvgPicture.asset(
            'assets/icons/search_icon.svg',
            width: 18.w,
            colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              onChanged: controller.onSearchChanged,
              style: TextStyle(
                fontSize: 13.sp,
                color: ConstColor.titleColor,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                hintText: ConstString.searchListings,
                hintStyle: TextStyle(
                  fontSize: 13.sp,
                  color: ConstColor.bodyColor,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Sell / Rent tab row
// ─────────────────────────────────────────────────────
class _TabRow extends StatelessWidget {
  final MyListingController controller;

  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          _TabItem(
            label: ConstString.sell,
            isSelected: controller.selectedTab.value == 0,
            onTap: () => controller.onTabChanged(0),
          ),
          SizedBox(width: 8.w),
          _TabItem(
            label: ConstString.rent,
            isSelected: controller.selectedTab.value == 1,
            onTap: () => controller.onTabChanged(1),
          ),
        ],
      ),
    ));
  }
}

// ─── Single tab button ─────────────────────────────
class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: isSelected ? ConstColor.primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
          ),
        ),
        child: CustomText(
          title: label,
          textColor: isSelected ? Colors.white : ConstColor.bodyColor,
          textSize: 14.sp,
          fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
          maxLine: 1,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Horizontal listing card
// ─────────────────────────────────────────────────────

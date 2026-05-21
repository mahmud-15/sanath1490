import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/popular_location_listings_controller.dart';

class PopularLocationListingsScreen extends StatelessWidget {
  const PopularLocationListingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PopularLocationListingsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: _AppBar(controller: controller),
      body: Column(
        children: [
          _ResultsHeader(controller: controller),
          Expanded(
            child: Obx(() => ListView.separated(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 20.h),
              itemCount: controller.listings.length,
              separatorBuilder: (_, _) => SizedBox(height: 12.h),
              itemBuilder: (context, index) =>
                  _PropertyCard(listing: controller.listings[index]),
            )),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// AppBar
// ─────────────────────────────────────────────────────
class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  final PopularLocationListingsController controller;

  const _AppBar({required this.controller});

  @override
  Size get preferredSize => Size.fromHeight(56.h);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ConstColor.primaryColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
      ),
      title: Obx(() => CustomText(
        title: controller.locationName.value,
        textColor: Colors.white,
        textSize: 17.sp,
        fontWeight: FontWeight.w600,
        maxLine: 1,
      )),
      // actions: [
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.tune, color: Colors.white, size: 22.sp),
      //   ),
      //   IconButton(
      //     onPressed: () {},
      //     icon: Icon(Icons.favorite_border, color: Colors.white, size: 22.sp),
      //   ),
      // ],
    );
  }
}

// ─────────────────────────────────────────────────────
// Results header + sort
// ─────────────────────────────────────────────────────
class _ResultsHeader extends StatelessWidget {
  final PopularLocationListingsController controller;

  const _ResultsHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      child: Obx(() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: '${controller.listings.length} results',
            textColor: ConstColor.bodyColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
          GestureDetector(
            onTap: () => _showSortSheet(context, controller),
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
          ),
        ],
      )),
    );
  }

  void _showSortSheet(
      BuildContext context, PopularLocationListingsController controller) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 32.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: ConstColor.outLineColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomText(
              title: 'Sort By',
              textColor: ConstColor.titleColor,
              textSize: 15.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            SizedBox(height: 12.h),
            ...controller.sortOptions.map((option) => Obx(() => ListTile(
              contentPadding: EdgeInsets.zero,
              title: CustomText(
                title: option,
                textColor: controller.selectedSort.value == option
                    ? ConstColor.primaryColor
                    : ConstColor.titleColor,
                textSize: 13.sp,
                fontWeight: controller.selectedSort.value == option
                    ? FontWeight.w600
                    : FontWeight.w400,
                maxLine: 1,
              ),
              trailing: controller.selectedSort.value == option
                  ? Icon(Icons.check,
                  color: ConstColor.primaryColor, size: 18.sp)
                  : null,
              onTap: () {
                controller.changeSort(option);
                Get.back();
              },
            ))),
          ],
        ),
      ),
    );
  }
}

// Property Card
class _PropertyCard extends StatelessWidget {
  final DummyListing listing;

  const _PropertyCard({required this.listing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(12),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Image ──────────────────────────
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r),
                  ),
                  child: AppImage(
                    url: listing.imageUrl.isEmpty ? null : listing.imageUrl,
                    width: double.infinity,
                    height: 200.h,
                    fit: BoxFit.cover,
                  ),
                ),
                // Photo count badge
                Positioned(
                  top: 10.h,
                  left: 10.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(140),
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.camera_alt, color: Colors.white, size: 12.sp),
                        SizedBox(width: 4.w),
                        CustomText(
                          title: '1/${listing.photoCount}',
                          textColor: Colors.white,
                          textSize: 11.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            // ─── Price + Featured badge ──────────
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              color: listing.isFeatured ? ConstColor.primaryColor : Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    title: listing.price,
                    textColor:
                    listing.isFeatured ? Colors.white : ConstColor.titleColor,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  if (listing.isFeatured)
                    Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: Colors.white.withAlpha(30),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: CustomText(
                        title: 'FEATURED\nPROPERTY',
                        textColor: Colors.white,
                        textSize: 9.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            // ─── Details ────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: listing.title,
                    textColor: ConstColor.titleColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: listing.address,
                    textColor: ConstColor.primaryColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                  SizedBox(height: 10.h),
                  Divider(height: 1.h, color: ConstColor.outLineColor),
                  SizedBox(height: 10.h),
                  CustomText(
                    title: 'Added on ${listing.addedOn}',
                    textColor: ConstColor.bodyColor,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'Controller/home_controller.dart';
import 'Widget/property_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ─── Header ──────────────────────────
          SliverToBoxAdapter(child: _HomeHeader(controller: controller)),

          // ─── Properties Near You ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 12.h),
              child: CustomText(
                title: ConstString.propertiesNearYou,
                textColor: ConstColor.titleColor,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: Obx(() => SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) => Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                      child: PropertyCard(
                        onTap: () => Get.toNamed(
                          AppRoutes.propertyDetails,
                          arguments: controller.currentProperties[index], // ─── This missing line caused the error!
                        ),
                        property: controller.currentProperties[index],
                      ),
                ),
                childCount: controller.currentProperties.length,
              ),
            )),
          ),

          // ─── Popular Locations ───────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 5.h, 16.w, 12.h),
              child: CustomText(
                title: ConstString.popularLocation,
                textColor: ConstColor.titleColor,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 110.h,
              child: Obx(() => ListView.separated(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: controller.popularLocations.length,
                separatorBuilder: (_, _) => SizedBox(width: 12.w),
                itemBuilder: (context, index) {
                  final location = controller.popularLocations[index];
                  return _LocationCard(location: location);
                },
              )),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24.h)),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _HomeHeader extends StatelessWidget {
  final HomeController controller;

  const _HomeHeader({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/images/home_screen_banner.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.transparent,
            ],
          ),
        ),
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 10.h,
          bottom: 20.h,
          left: 16.w,
          right: 16.w,
        ),
        child: Column(
          children: [
            // ─── Logo + Title ─────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage(
                  path: 'assets/images/app_logo.png',
                  width: 60.w,
                  height: 59.h,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: 'My Home',
                      textColor: Colors.white,
                      textSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: 'Property Simplified',
                      textColor: Colors.white,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // ─── Card ─────────────────────────
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: ConstColor.primaryColor,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                children: [

                  // ─── Buy / Rent Tab ───────────
                  Obx(() => Row(
                    children: ['Buy', 'Rent'].asMap().entries.map((entry) {
                      final bool isSelected = controller.selectedTab.value == entry.key;
                      return Expanded(
                        child: GestureDetector(
                          onTap: () => controller.onTabChanged(entry.key),
                          child: Column(
                            children: [
                              CustomText(
                                title: entry.value,
                                textColor: isSelected ? Colors.white : Colors.white.withAlpha(140),
                                textSize: isSelected ? 18.sp : 18.sp,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w600,
                                textAlign: TextAlign.center,
                                maxLine: 1,
                              ),
                              SizedBox(height: 6.h),
                              AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                height: isSelected ? 2.h : 1.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: isSelected ? Colors.white : Colors.white.withAlpha(80),
                                  borderRadius: BorderRadius.circular(2.r),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  )),
                  SizedBox(height: 14.h),

                  // ─── Search Bar ───────────────
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.searchScreen),

                    child: AbsorbPointer(
                      child: Container(
                        height: 46.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 12.w),
                            SvgPicture.asset('assets/icons/search_icon.svg'),
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
                                  hintText: ConstString.searchByLocation,
                                  hintStyle: TextStyle(
                                    fontSize: 12.sp,
                                    color: ConstColor.bodyColor,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w400
                                  ),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Get.toNamed(AppRoutes.filterScreen);
                              },
                              child: Container(
                                margin: EdgeInsets.all(6.w),
                                padding: EdgeInsets.all(6.w),
                                child: SvgPicture.asset('assets/icons/filter_icon.svg'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ─── Search Button ────────────
                  CustomElevatedButton(
                    onPressed: () {
                      Get.toNamed(AppRoutes.propertyListScreen);
                    },
                    color: ConstColor.secondaryColor,
                    height: 48,
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomText(
                      title: ConstString.searchProperties,
                      textColor: Colors.black,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
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

// ─────────────────────────────────────────
class _LocationCard extends StatelessWidget {
  final LocationModel location;

  const _LocationCard({required this.location});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: 80.w,
        child: Column(
          mainAxisSize: MainAxisSize.min, // ─── Prevents vertical overflow forcing
          children: [
            ClipRRect(
              // borderRadius: BorderRadius.circular(10.r),
              child: AppImage(
                path: location.imagePath,
                width: 80.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 4.h),
            CustomText(
              title: location.name,
              textColor: ConstColor.titleColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
            CustomText(
              title: location.count,
              textColor: ConstColor.bodyColor,
              textSize: 10.sp,
              fontWeight: FontWeight.w400,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
          ],
        ),
      ),
    );
  }
}
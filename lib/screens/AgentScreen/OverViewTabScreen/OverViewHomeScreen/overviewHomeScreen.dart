import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/OverViewHomeScreen/widgets/enquiryListItem.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/OverViewHomeScreen/widgets/performanceCard.dart';
import 'package:sanath1490_flutter_app/screens/AgentScreen/OverViewTabScreen/OverViewHomeScreen/widgets/premiumPlanBanner.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_icons.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import 'controller/overviewHomeController.dart';

class Overviewhomescreen extends StatelessWidget {
  const Overviewhomescreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<Overviewhomecontroller>();

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      body: CustomScrollView(
        slivers: [
          // ─── App Bar ──────────────────────────
          SliverToBoxAdapter(
            child: _Overviewhomecontroller(controller: controller),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 6.h)),

          // ─── Premium Plan Banner ──────────────
          SliverToBoxAdapter(
            child: InkWell(
              onTap: (){
                Get.toNamed(AppRoutes.subscriptionScreen);
              },
              child: PremiumPlanBanner(
                planText: controller.premiumPlanText.value,
                onManageTap: controller.onManagePlanTap,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // ─── Performance Overview ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.performanceOverview,
                textColor: ConstColor.titleColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 12.h)),

          SliverToBoxAdapter(
            child: Obx(() => Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  PerformanceCard(
                    iconPath: ConstIcons.homeTabIcon,
                    label: ConstString.totalViews,
                    value: controller.performance.value.totalViews,
                    iconColor: ConstColor.primaryColor,
                    iconBgColor: ConstColor.primaryColor.withAlpha(20),
                  ),
                  SizedBox(width: 12.w),
                  PerformanceCard(
                    iconPath: ConstIcons.messageIcon,
                    label: ConstString.newEnquiries,
                    value: controller.performance.value.newEnquiries,
                    iconColor: ConstColor.secondaryColor,
                    iconBgColor: ConstColor.teel200,
                  ),
                ],
              ),
            )),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 24.h)),

          // ─── Quick Actions ────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.quickActions,
                textColor: ConstColor.titleColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 12.h)),

          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  // ─── Add Listing Button ────────
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: controller.onAddListingTap,
                      buttonBorderRadius: 4,
                      color: ConstColor.primaryColor,
                      height: 40,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add, color: Colors.white, size: 18.sp),
                          SizedBox(width: 6.w),
                          CustomText(
                            title: ConstString.addListing,
                            textColor: Colors.white,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(width: 12.w),

                  // ─── Enquiries Button ──────────
                  Expanded(
                    child: CustomElevatedButton(
                      onPressed: controller.onEnquiriesTap,
                      buttonBorderRadius: 4,
                      color: ConstColor.teel400,
                      height: 40,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            ConstIcons.messageIcon,
                            width: 16.w,
                            height: 16.h,
                            colorFilter: const ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          CustomText(
                            title: ConstString.enquiries,
                            textColor: Colors.white,
                            textSize: 16.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 20.h)),

          // ─── Recent Enquiries ─────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: CustomText(
                title: ConstString.recentEnquiries,
                textColor: ConstColor.titleColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 10.h)),

          SliverToBoxAdapter(
            child: Obx(() => Container(
              margin: EdgeInsets.symmetric(horizontal: 16.w,),
              decoration: BoxDecoration(
                color: ConstColor.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: ConstColor.borderColor, width: 1),
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: controller.recentEnquiries.length,
                itemBuilder: (context, index) {
                  final enquiry = controller.recentEnquiries[index];
                  final isLast =
                      index == controller.recentEnquiries.length - 1;
                  return EnquiryListItem(
                    enquiry: enquiry,
                    onTap: () => controller.onEnquiryItemTap(enquiry),
                    showDivider: !isLast,
                  );
                },
              ),
            )),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 30.h)),
        ],
      ),
    );
  }
}
//
// ─────────────────────────────────────────
class _Overviewhomecontroller extends StatelessWidget {
  final Overviewhomecontroller controller;

  const _Overviewhomecontroller({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.backgroundColor,
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 0.h,
        bottom: 12.h,
        left: 16.w,
        right: 16.w,
      ),
      child: Row(
        children: [
          // ─── Logo ──────────────────────────
          AppImage(
            path: 'assets/images/app_logo.png',
            width: 60.w,
            height: 60.h,
          ),
          // ─── Greeting + Title ───────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'Hello ${controller.userName}',
                  textColor: ConstColor.bodyColor,
                  textSize: 13.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
                CustomText(
                  title: ConstString.manageYourPropertyListings,
                  textColor: ConstColor.primaryColor,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ],
            ),
          ),

          // ─── Notification Bell ──────────────
          // ─── Notification Bell ──────────────
          // GestureDetector(
          //   onTap: controller.onNotificationTap,
          //   child: Obx(() => Stack(
          //     clipBehavior: Clip.none,
          //     children: [
          //       Icon(
          //         Icons.notifications_outlined,
          //         size: 26.sp,
          //         color: ConstColor.titleColor,
          //       ),
          //       if (controller.notificationCount.value > 0)
          //         Positioned(
          //           top: -6,
          //           right: -5,
          //           child: Container(
          //             width: 16.w,
          //             height: 16.w,
          //             decoration: const BoxDecoration(
          //               color: Colors.red,
          //               shape: BoxShape.circle,
          //             ),
          //             alignment: Alignment.center,
          //             child: CustomText(
          //               title: '${controller.notificationCount.value}',
          //               textColor: Colors.white,
          //               textSize: 9.sp,
          //               fontWeight: FontWeight.w700,
          //               maxLine: 1,
          //             ),
          //           ),
          //         ),
          //     ],
          //   )),
          // ),
        ],
      ),
    );
  }
}
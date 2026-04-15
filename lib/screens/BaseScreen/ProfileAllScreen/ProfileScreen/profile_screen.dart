import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import 'Controller/profile_controller.dart';
import '../../../../utils/app_role.dart';
import '../../../BaseScreen/NavBar/controller/navbar_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.profile, showBack: false),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Column(
          children: [
            // ─── User Info Card ───────────────────
            _UserInfoCard(controller: controller),

            SizedBox(height: 14.h),

            // ─── Account Settings Group ───────────
            _MenuGroup(
              items: [
                _MenuItem(
                  iconPath: 'assets/icons/profile_icon.svg',
                  title: 'Personal Information',
                  subtitle: 'Name, email, phone',
                  onTap: () => controller.onMenuTap(ProfileMenu.personalInfo),
                ),
                _MenuItem(
                  iconPath: 'assets/icons/lock_icon.svg',
                  title: 'Change Password',
                  subtitle: 'Password & authentication',
                  onTap: () => controller.onMenuTap(ProfileMenu.changePassword),
                ),
                _MenuItem(
                  iconPath: 'assets/icons/notification_icon.svg',
                  title: 'Notification Settings',
                  subtitle: 'Push, email, in-app',
                  onTap: () => controller.onMenuTap(ProfileMenu.notifications),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // ─── App Info Group ───────────────────
            _MenuGroup(
              items: [
                _MenuItem(
                  iconPath: 'assets/icons/about_us_icon.svg',
                  title: 'About Us',
                  subtitle: 'App info & version',
                  onTap: () => controller.onMenuTap(ProfileMenu.aboutUs),
                ),
                _MenuItem(
                  iconPath: 'assets/icons/terms_icon.svg',
                  title: 'Terms & Conditions',
                  subtitle: 'User agreement',
                  onTap: () => controller.onMenuTap(ProfileMenu.terms),
                ),
                _MenuItem(
                  iconPath: 'assets/icons/privacy_icon.svg',
                  title: 'Privacy Policy',
                  subtitle: 'Data protection',
                  onTap: () => controller.onMenuTap(ProfileMenu.privacy),
                ),
                _MenuItem(
                  iconPath: 'assets/icons/privacy_icon.svg',
                  title: 'Faq',
                  subtitle: 'Need help? Find answers',
                  onTap: () => controller.onMenuTap(ProfileMenu.faq),
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // ─── Delete Account ───────────────────
            _MenuGroup(
              items: [
                _MenuItem(
                  iconPath: 'assets/icons/profile_icon.svg',
                  title: ConstString.deleteAccount,
                  subtitle: 'Delete your account and data',
                  onTap: () => controller.onMenuTap(ProfileMenu.deleteAccount),
                  titleColor: ConstColor.red,
                  iconBgColor: ConstColor.red.withAlpha(10),
                  iconColor: ConstColor.red,
                ),
              ],
            ),

            SizedBox(height: 14.h),

            // ─── Log Out ──────────────────────────
            _MenuGroup(
              items: [
                _MenuItem(
                  iconPath: 'assets/icons/log_out_icon.svg',
                  title: ConstString.logOut,
                  subtitle: '',
                  onTap: () => controller.onMenuTap(ProfileMenu.logoutAccount),
                  titleColor: ConstColor.red,
                  iconBgColor: ConstColor.red.withAlpha(10),
                  iconColor: ConstColor.red,
                  showSubtitle: false,
                ),
              ],
            ),

            SizedBox(height: 24.h),

            // ─── DEMO ROLE SWITCHER (TESTING ONLY) ───────────────────
            GestureDetector(
              onTap: () {
                if (selectedUserRole == AppUserType.user) {
                  selectedUserRole = AppUserType.agent;
                  Get.snackbar('Role Switched', 'You are now an Agent.');
                } else {
                  selectedUserRole = AppUserType.user;
                  Get.snackbar('Role Switched', 'You are now a User.');
                }

                Get.find<NavbarController>().onAppInitial();
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                decoration: BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomText(
                  title: 'SWITCH ROLE (TESTING)',
                  textColor: Colors.black,
                  textSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// User info header card
// ─────────────────────────────────────────────────────
class _UserInfoCard extends StatelessWidget {
  final ProfileController controller;

  const _UserInfoCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            ConstColor.primaryColor,
            ConstColor.primaryDeepColor,
          ],
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // ─── Avatar ────────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(30.r),
            child: AppImage(
              path: controller.avatarPath.value,
              width: 52.w,
              height: 52.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 14.w),

          // ─── Name + Role ───────────────────
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: controller.userName.value,
                textColor: Colors.white,
                textSize: 18.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
              SizedBox(height: 3.h),
              CustomText(
                title: controller.userRole.value,
                textColor: Colors.white.withAlpha(180),
                textSize: 14.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

// ─────────────────────────────────────────────────────
// White card group wrapping menu items
// ─────────────────────────────────────────────────────
class _MenuGroup extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(items.length, (index) {
          final isLast = index == items.length - 1;
          return Column(
            children: [
              items[index],
              if (!isLast)
                Divider(
                  height: 1.h,
                  indent: 56.w,
                  endIndent: 16.w,
                  color: ConstColor.outLineColor,
                ),
            ],
          );
        }),
      ),
    );
  }
}

// Single menu item row

class _MenuItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Color? titleColor;
  final Color? iconBgColor;
  final Color? iconColor;
  final bool showSubtitle;

  const _MenuItem({
    required this.iconPath,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.titleColor,
    this.iconBgColor,
    this.iconColor,
    this.showSubtitle = true,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        child: Row(
          children: [
            // ─── Icon circle ─────────────────────
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                  color: iconBgColor ?? ConstColor.primaryColor.withAlpha(20),
                  // shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(14)
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    iconColor ?? ConstColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            // ─── Title + Subtitle ─────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textColor: titleColor ?? ConstColor.titleColor,
                    textSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  if (showSubtitle && subtitle.isNotEmpty) ...[
                    SizedBox(height: 2.h),
                    CustomText(
                      title: subtitle,
                      textColor: ConstColor.bodyColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ],
              ),
            ),

            SvgPicture.asset(
              'assets/icons/arrow_indicator.svg',
              width: 14.w,
              height: 14.w,
              colorFilter: ColorFilter.mode(
                ConstColor.bodyColor,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
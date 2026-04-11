import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/notification_settings_controller.dart';

class NotificationSettingsScreen extends StatelessWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationSettingsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(
        title: 'Notifications',
        action: SvgPicture.asset(
          'assets/icons/settings_icon.svg',
          width: 20.w,
          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // ─── Email Alerts ──────────────────
              Obx(() => _NotificationToggleItem(
                iconPath: 'assets/icons/email_icon.svg',
                title: 'Email Alerts',
                subtitle: 'Receive alerts via email',
                value: controller.emailAlerts.value,
                onChanged: (val) => controller.emailAlerts.value = val,
                showDivider: true,
              )),

              // ─── Push Notifications ────────────
              Obx(() => _NotificationToggleItem(
                iconPath: 'assets/icons/bell_icon.svg',
                title: 'Push Notifications',
                subtitle: 'Get instant updates on your device',
                value: controller.pushNotifications.value,
                onChanged: (val) => controller.pushNotifications.value = val,
                showDivider: true,
              )),

              // ─── Alert Types label ─────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: 'Alert Types',
                    textColor: ConstColor.titleColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
              ),

              // ─── Listing approved ──────────────
              Obx(() => _NotificationToggleItem(
                title: 'Listing approved',
                subtitle: 'When your listing goes live',
                value: controller.listingApproved.value,
                onChanged: (val) => controller.listingApproved.value = val,
                showDivider: true,
              )),

              // ─── Listing expiring ──────────────
              Obx(() => _NotificationToggleItem(
                title: 'Listing expiring',
                subtitle: '7 days before listing expires',
                value: controller.listingExpiring.value,
                onChanged: (val) => controller.listingExpiring.value = val,
                showDivider: true,
              )),

              // ─── Payment successful ────────────
              Obx(() => _NotificationToggleItem(
                title: 'Payment successful',
                subtitle: 'Invoice & receipt confirmation',
                value: controller.paymentSuccess.value,
                onChanged: (val) => controller.paymentSuccess.value = val,
                showDivider: false,
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Single notification toggle row
// ─────────────────────────────────────────────────────
class _NotificationToggleItem extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  final bool showDivider;

  const _NotificationToggleItem({
    this.iconPath,
    required this.title,
    required this.subtitle,
    required this.value,
    required this.onChanged,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              // ─── SVG icon (optional) ───────────
              if (iconPath != null) ...[
                SvgPicture.asset(
                  iconPath!,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                ),
                SizedBox(width: 12.w),
              ],

              // ─── Title + subtitle ──────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: title,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: subtitle,
                      textColor: ConstColor.bodyColor,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              // ─── Toggle switch ─────────────────
              Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Colors.white,
                activeTrackColor: ConstColor.primaryColor,
                inactiveThumbColor: Colors.white,
                inactiveTrackColor: ConstColor.outLineColor,
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1.h, indent: 16.w, endIndent: 16.w, color: ConstColor.outLineColor),
      ],
    );
  }
}
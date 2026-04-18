import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
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
        title: ConstString.notifications,
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
              _NotificationToggleItem(
                iconPath: 'assets/icons/email.svg',
                title: ConstString.emailAlerts,
                subtitle: ConstString.receiveAlertsViaEmail,
                valueObs: controller.emailAlerts,
                showDivider: true,
              ),

              // ─── Push Notifications ────────────
              _NotificationToggleItem(
                iconPath: "assets/icons/notification_icon.svg",
                title: ConstString.pushNotification,
                subtitle: ConstString.getInstantUpdates,
                valueObs: controller.pushNotifications,
                showDivider: true,
              ),

              // ─── Alert Types label ─────────────
              Padding(
                padding: EdgeInsets.fromLTRB(16.w, 14.h, 16.w, 10.h),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    title: ConstString.alertTypes,
                    textColor: ConstColor.titleColor,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ),
              ),

              // ─── Listing approved ──────────────
              _NotificationToggleItem(
                title: ConstString.listingApproved,
                subtitle: ConstString.whenYourListing,
                valueObs: controller.listingApproved,
                showDivider: true,
              ),

              // ─── Listing expiring ──────────────
              _NotificationToggleItem(
                title: ConstString.listingExpiring,
                subtitle: ConstString.sevenDaysListing,
                valueObs: controller.listingExpiring,
                showDivider: true,
              ),

              // ─── Payment successful ────────────
              _NotificationToggleItem(
                title: ConstString.paymentSuccessful,
                subtitle: ConstString.invoiceAndReceipt,
                valueObs: controller.paymentSuccess,
                showDivider: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//////////////Single notification toggle row

class _NotificationToggleItem extends StatelessWidget {
  final String? iconPath;
  final String title;
  final String subtitle;
  final RxBool valueObs;
  final bool showDivider;

  const _NotificationToggleItem({
    this.iconPath,
    required this.title,
    required this.subtitle,
    required this.valueObs,
    required this.showDivider,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: Row(
            children: [
              if (iconPath != null) ...[
                SvgPicture.asset(
                  iconPath!,
                  width: 20.w,
                  colorFilter: ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                ),
                SizedBox(width: 12.w),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: title,
                      textColor: ConstColor.titleColor,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: subtitle,
                      textColor: ConstColor.bodyColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              Transform.scale(
                scale: 0.80,
                child: Switch(
                  value: valueObs.value,
                  onChanged: (val) => valueObs.value = val,
                  activeThumbColor: Colors.white,
                  activeTrackColor: ConstColor.primaryColor,
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: ConstColor.outLineColor,
                ),
              ),
            ],
          ),
        ),
        if (showDivider)
          Divider(height: 1.h, indent: 16.w, endIndent: 16.w, color: ConstColor.outLineColor),
      ],
    ));
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../constant/const_string.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import 'Controller/notification_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(
        title: ConstString.notifications,
        action: GestureDetector(
          onTap: controller.onSettingsTap,
          child: SvgPicture.asset(
            'assets/icons/settings_icon.svg',
            width: 20.w,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
        ),
      ),

      body: Column(
        children: [
          SizedBox(height: 12.h),

          //////////// All / Unread tabs
          _TabRow(controller: controller),

          SizedBox(height: 6.h),

          ////////// Mark all as read
          _MarkAllRow(controller: controller),

          /////////// Notification list
          Expanded(
            child: Obx(() {
              final list = controller.currentList;

              if (list.isEmpty) {
                return Center(
                  child: CustomText(
                    title: 'No notifications',
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                itemCount: list.length,
                separatorBuilder: (_, _) => SizedBox(height: 8.h),
                itemBuilder: (context, index) => _NotifCard(
                  item: list[index],
                  onTap: () => controller.onNotifTap(index),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}

/////////////////All / Unread tab row
class _TabRow extends StatelessWidget {
  final NotificationController controller;

  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ConstColor.outLineColor),
      ),
      child: Row(
        children: [
          _TabItem(
            label: '${ConstString.allTab} (${controller.totalCount})',
            isSelected: controller.selectedTab.value == 0,
            onTap: () => controller.onTabChanged(0),
            isLeft: true,
          ),

          _TabItem(
            label: '${ConstString.unreadTab} (${controller.unreadCount})',
            isSelected: controller.selectedTab.value == 1,
            onTap: () => controller.onTabChanged(1),
            isLeft: false,
          ),
        ],
      ),
    ));
  }
}

///////////////// Single tab item
class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLeft;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? Radius.circular(9.r) : Radius.zero,
              bottomLeft: isLeft ? Radius.circular(9.r) : Radius.zero,
              topRight: !isLeft ? Radius.circular(9.r) : Radius.zero,
              bottomRight: !isLeft ? Radius.circular(9.r) : Radius.zero,
            ),
          ),
          child: CustomText(
            title: label,
            textColor: isSelected ? Colors.white : ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            textAlign: TextAlign.center,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}

/////////////// Mark all as read row
class _MarkAllRow extends StatelessWidget {
  final NotificationController controller;

  const _MarkAllRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Align(
        alignment: Alignment.centerLeft,
        child: GestureDetector(
          onTap: controller.markAllAsRead,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/check_icon.svg',
                width: 16.w,
                colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
              ),
              SizedBox(width: 4.w),
              CustomText(
                title: ConstString.markAllAsRead,
                textColor: ConstColor.primaryColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

////////////// Single notification card

class _NotifCard extends StatelessWidget {
  final NotificationModel item;
  final VoidCallback onTap;

  const _NotifCard({required this.item, required this.onTap});

  String _iconPath(NotifType type) {
    switch (type) {
      case NotifType.propertyMatch:   return 'assets/icons/home_icon.svg';
      case NotifType.priceReduced:    return 'assets/icons/low_price_icon.svg';
      case NotifType.newMatches:      return 'assets/icons/notification_icon.svg';
      case NotifType.agentResponse:   return 'assets/icons/message_icon.svg';
      case NotifType.viewingReminder: return 'assets/icons/calender_icon.svg';
      case NotifType.priceIncreased:  return 'assets/icons/low_price_icon.svg';
      case NotifType.propertyAlert:   return 'assets/icons/home_icon.svg';
      case NotifType.featured:        return 'assets/icons/star_icon.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: item.isRead
              ? null
              : Border.all(color: ConstColor.primaryColor.withAlpha(60), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(8),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: ConstColor.primaryColor.withAlpha(20),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  _iconPath(item.type),
                  width: 20.w,
                  colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
                ),
              ),
            ),

            SizedBox(width: 12.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: item.title,
                    textColor: ConstColor.titleColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 3.h),
                  CustomText(
                    title: item.body,
                    textColor: ConstColor.bodyColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 3,
                  ),
                  SizedBox(height: 5.h),
                  CustomText(
                    title: item.time,
                    textColor: ConstColor.bodyColor,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),
            ),

            if (!item.isRead) ...[
              SizedBox(width: 8.w),
              Container(
                width: 8.w,
                height: 8.w,
                margin: EdgeInsets.only(top: 4.h),
                decoration: const BoxDecoration(
                  color: ConstColor.primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
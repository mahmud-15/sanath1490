import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/AuthAppBar/auth_app_bar.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../constant/const_color.dart';
import 'Widget/choose_role_controller.dart';

class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ChooseRoleController>();

    return Scaffold(
      appBar: const AuthAppBar(),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 48.h),

              CustomText(
                title: 'Choose Role',
                textColor: ConstColor.primaryColor,
                textSize: 28.sp,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
              SizedBox(height: 8.h),

              CustomText(
                title: 'How do you want to use Myhome?',
                textColor: ConstColor.bodyColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                maxLine: 2,
              ),
              SizedBox(height: 32.h),

              // ─── Role Cards ──────────────────────
              Obx(() => _RoleCard(
                title: 'Property Seeker',
                subtitle: 'Looking to buy or rent',
                iconPath: 'assets/icons/profile_icon.svg',
                iconColor: ConstColor.primaryColor,
                isSelected: controller.selectedRole.value == 'seeker',
                onTap: () => controller.selectRole('seeker'),
              )),
              SizedBox(height: 16.h),

              Obx(() => _RoleCard(
                title: 'Agent',
                subtitle: 'List & manage properties',
                iconPath: 'assets/icons/agent_icon.svg',
                iconColor: const Color(0xFFF59E0B),
                isSelected: controller.selectedRole.value == 'agent',
                onTap: () => controller.selectRole('agent'),
              )),

              const Spacer(),

              // ─── Continue Button ─────────────────
              Obx(() => CustomElevatedButton(
                onPressed: controller.isRoleSelected
                    ? () {
                }
                    : null,
                color: controller.isRoleSelected
                    ? ConstColor.primaryColor
                    : ConstColor.primaryColor.withAlpha(100),
                height: 52,
                left: 0,
                right: 0,
                top: 0,
                bottom: 24,
                child: CustomText(
                  title: 'Continue',
                  textColor: Colors.white,
                  textSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _RoleCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  final Color iconColor;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.title,
    required this.subtitle,
    required this.iconPath,
    required this.iconColor,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(
            color: isSelected ? ConstColor.primaryColor : const Color(0xFFE5E7EB),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(10),
              blurRadius: 8.r,
              offset: Offset(0, 2.h),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(20),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: AppImage(
                  path: iconPath,
                  width: 24.w,
                  height: 24.h,
                  iconColor: iconColor,
                ),
              ),
            ),
            SizedBox(width: 14.w),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: title,
                    textColor: ConstColor.titleColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  SizedBox(height: 2.h),
                  CustomText(
                    title: subtitle,
                    textColor: ConstColor.bodyColor,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),
            ),

            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: ConstColor.primaryColor,
                size: 22.sp,
              ),
          ],
        ),
      ),
    );
  }
}
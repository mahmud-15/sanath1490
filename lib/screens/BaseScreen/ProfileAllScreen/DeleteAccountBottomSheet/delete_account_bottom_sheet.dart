import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';
import 'Widget/account_deleted_popup.dart';

class DeleteAccountBottomSheet extends StatelessWidget {
  const DeleteAccountBottomSheet({super.key});

  static void show() {
    Get.bottomSheet(
      const DeleteAccountBottomSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Widget build(BuildContext context) {
    final passwordController = TextEditingController();
    final obscure = true.obs;

    return Container(
      padding: EdgeInsets.fromLTRB(24.w, 16.h, 24.w, 32.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Handle ──────────────────────────
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

          // ─── Title ───────────────────────────
          Center(
            child: CustomText(
              title: ConstString.deleteAccount,
              textColor: ConstColor.titleColor,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 24.h),

          // ─── Delete Icon ──────────────────────
          Center(
            child: Container(
              width: 60.w,
              height: 60.h,
              decoration: BoxDecoration(
                color: Colors.red.withAlpha(25),
                shape: BoxShape.circle,
              ),
              child: Center(child: SvgPicture.asset("assets/icons/delete_icon.svg",
              width: 24.w,
              height: 24.h,
              ))
            ),
          ),
          SizedBox(height: 16.h),

          // ─── Heading ─────────────────────────
          Center(
            child: CustomText(
              title: ConstString.permanentlyDelete,
              textColor: ConstColor.titleColor,
              textSize: 18.sp,
              fontWeight: FontWeight.w700,
              textAlign: TextAlign.center,
              maxLine: 2,
            ),
          ),
          SizedBox(height: 6.h),

          // ─── Warning ─────────────────────────
          Center(
            child: CustomText(
              title: ConstString.warningThisAction,
              textColor: Colors.red,
              textSize: 13.sp,
              fontWeight: FontWeight.w500,
              textAlign: TextAlign.center,
              maxLine: 1,
            ),
          ),
          SizedBox(height: 16.h),

          // ─── Description ─────────────────────
          CustomText(
            title: ConstString.onceYouDeleteYourAccount,
            textColor: ConstColor.bodyColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
            maxLine: 4,
          ),
          SizedBox(height: 8.h),

          _BulletItem(text: ConstString.yourProfileAndAccount),
          _BulletItem(text: ConstString.allSaved),
          SizedBox(height: 12.h),

          CustomText(
            title: ConstString.weWontBeAbleToRestoreYour,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 3,
          ),
          SizedBox(height: 20.h),

          // ─── Password Field ───────────────────
          CustomText(
            title: ConstString.enterYourPassword,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w500,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),

          Obx(() => Container(
            height: 48.h,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ConstColor.outLineColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: passwordController,
                    obscureText: obscure.value,
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: ConstColor.titleColor,
                      fontFamily: 'Roboto',
                    ),
                    decoration: InputDecoration(
                      hintText: ConstString.enterYourPassword,
                      hintStyle: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey,
                        fontFamily: 'Roboto',
                      ),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => obscure.value = !obscure.value,
                  child: Icon(
                    obscure.value ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: ConstColor.bodyColor,
                    size: 20.sp,
                  ),
                ),
              ],
            ),
          )),
          SizedBox(height: 24.h),

          // ─── Buttons ─────────────────────────
          Row(
            children: [
              Expanded(
                child: // ─── Delete Button ────────────────────
                CustomElevatedButton(
                  onPressed: () {
                    Get.back();
                    _showDeletedPopup();
                  },
                  color: ConstColor.red,
                  height: 48,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomText(
                    title: ConstString.delete,
                    textColor: Colors.white,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: CustomElevatedButton(
                  elevation: 0,
                  onPressed: () => Get.back(),
                  isOutLined: true,
                  outLineColour: ConstColor.outLineColor,
                  borderColor: ConstColor.outLineColor,
                  height: 48,
                  top: 0,
                  left: 0,
                  right: 0,
                  child: CustomText(
                    title: ConstString.cancel,
                    textColor: ConstColor.titleColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _BulletItem extends StatelessWidget {
  final String text;

  const _BulletItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 4.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h, right: 8.w),
            child: Container(
              width: 5.w,
              height: 5.h,
              decoration: const BoxDecoration(
                color: Colors.black,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              title: text,
              textColor: ConstColor.bodyColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}

void _showDeletedPopup() {
  Get.dialog(
    const AccountDeletedPopup(),
    barrierDismissible: false,
  );

  Future.delayed(const Duration(seconds: 3), () {
    Get.back();
    Get.offAllNamed(AppRoutes.signInScreen);
  });
}
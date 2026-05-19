import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../constant/app_api_url.dart';
import '../../../../../utils/log_print.dart';
import '../../DeleteAccountBottomSheet/delete_account_bottom_sheet.dart';
import '../../LogoutBottomSheet/logout_bottom_sheet.dart';
import '../../UserRepository/user_repository.dart';

enum ProfileMenu {
  personalInfo,
  changePassword,
  notifications,
  aboutUs,
  terms,
  privacy,
  faq,
  deleteAccount,
  logoutAccount,
}

class ProfileController extends GetxController {
  // ─── User info (reactive) ─────────────────────
  final userName    = ''.obs;
  final userRole    = ''.obs;
  final avatarPath  = ''.obs;
  final isLoading   = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ==================== Fetch Profile ====================
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final profile = await UserRepository.instance.getProfile();
      isLoading.value = false;

      if (profile != null) {
        userName.value   = profile.name ?? '';
        userRole.value   = profile.role ?? '';
        // ✅ image url — baseUrl + path
        avatarPath.value = profile.profileImage != null
            ? "${AppApiUrl.instance.imgBaseUrl}${profile.profileImage}"
            : 'assets/images/profile_img.jpg';
      }
    } catch (e) {
      isLoading.value = false;
      errorLog("ProfileController.fetchProfile", e);
    }
  }

  // ─── Menu tap handler ─────────────────────────
  void onMenuTap(ProfileMenu menu) {
    switch (menu) {
      case ProfileMenu.personalInfo:
        Get.toNamed(AppRoutes.personalInfoScreen);
        break;
      case ProfileMenu.changePassword:
        Get.toNamed(AppRoutes.changePasswordScreen);
        break;
      case ProfileMenu.notifications:
        Get.toNamed(AppRoutes.notificationSettingsScreen);
        break;
      case ProfileMenu.aboutUs:
        Get.toNamed(AppRoutes.aboutUsScreen);
        break;
      case ProfileMenu.terms:
        Get.toNamed(AppRoutes.termsScreen);
        break;
      case ProfileMenu.privacy:
        Get.toNamed(AppRoutes.privacyPolicyScreen);
        break;
      case ProfileMenu.faq:
        Get.toNamed(AppRoutes.faqScreen);
        break;
      case ProfileMenu.deleteAccount:
        DeleteAccountBottomSheet.show();
        break;
      case ProfileMenu.logoutAccount:
        LogoutBottomSheet.show();
        break;
    }
  }

  void onLogOut() {
    Get.defaultDialog(
      title: 'Log Out',
      middleText: 'Are you sure you want to log out?',
      textConfirm: 'Log Out',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
      },
    );
  }
}
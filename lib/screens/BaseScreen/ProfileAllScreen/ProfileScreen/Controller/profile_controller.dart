import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';

import '../../../../../service/UserService/user_service.dart';
import '../../DeleteAccountBottomSheet/delete_account_bottom_sheet.dart';
import '../../LogoutBottomSheet/logout_bottom_sheet.dart';

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

  UserService get _userService => UserService.instance;

  String get userName   => _userService.name;
  String get userRole   => _userService.role;
  bool   get isLoading  => _userService.isLoading.value;

  String? get avatarUrl {
    final img = _userService.profileImage;
    if (img.isEmpty) return null;
    return img;
  }

  @override
  void onInit() {
    super.onInit();
    if (_userService.profile.value == null) {
      _userService.fetchProfile();
    }
  }

  // ─── Menu tap ────────────────────────────────
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';

// ─── All profile menu options ──────────────────────
enum ProfileMenu {
  personalInfo,
  changePassword,
  notifications,
  aboutUs,
  terms,
  privacy,
  faq,
  deleteAccount,
}

class ProfileController extends GetxController {
  // ─── User info ────────────────────────────────────
  final userName = 'Sarah Johnson'.obs;
  final userRole = 'Property Seeker'.obs;
  final avatarPath = 'assets/images/profile_img.jpg'.obs;

  // ─── Menu tap handler ─────────────────────────────
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
        _showDeleteDialog();
        break;
    }
  }

  // ─── Delete account confirmation dialog ──────────
  void _showDeleteDialog() {
    Get.defaultDialog(
      title: 'Delete Account',
      middleText:
          'Are you sure you want to delete your account? This action cannot be undone.',
      textConfirm: 'Delete',
      textCancel: 'Cancel',
      confirmTextColor: Colors.white,
      buttonColor: Colors.red,
      onConfirm: () {
        Get.back();
        // TODO: call delete account API
      },
    );
  }

  // ─── Log out ──────────────────────────────────────
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
        // TODO: Get.offAllNamed(AppRoutes.login);
      },
    );
  }
}

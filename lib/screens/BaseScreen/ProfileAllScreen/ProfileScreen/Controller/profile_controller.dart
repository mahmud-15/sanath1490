import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      // TODO: Get.toNamed(AppRoutes.personalInfo);
        break;
      case ProfileMenu.changePassword:
      // TODO: Get.toNamed(AppRoutes.changePassword);
        break;
      case ProfileMenu.notifications:
      // TODO: Get.toNamed(AppRoutes.notificationSettings);
        break;
      case ProfileMenu.aboutUs:
      // TODO: Get.toNamed(AppRoutes.aboutUs);
        break;
      case ProfileMenu.terms:
      // TODO: Get.toNamed(AppRoutes.terms);
        break;
      case ProfileMenu.privacy:
      // TODO: Get.toNamed(AppRoutes.privacy);
        break;
      case ProfileMenu.faq:
      // TODO: Get.toNamed(AppRoutes.faq);
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
      middleText: 'Are you sure you want to delete your account? This action cannot be undone.',
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
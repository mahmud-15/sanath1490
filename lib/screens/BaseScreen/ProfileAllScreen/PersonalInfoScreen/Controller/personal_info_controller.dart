import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // ─── Text controllers ─────────────────────────────
  final nameController = TextEditingController(text: 'Sarah Johnson');
  final emailController = TextEditingController(text: 'sarah.j@email.com');
  final phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final postalController = TextEditingController();

  // ─── Reactive fields ──────────────────────────────
  final avatarPath = 'assets/images/avatar.png'.obs;
  final selectedCountry = ''.obs;

  // ─── Pick avatar from gallery ─────────────────────
  void pickAvatar() {
    // TODO: use image_picker to pick image and update avatarPath
  }

  // ─── Country picker ───────────────────────────────
  void pickCountry() {
    // TODO: show country picker bottom sheet
    selectedCountry.value = 'United Kingdom';
  }

  // ─── Save changes ─────────────────────────────────
  void saveChanges() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO: call update profile API
      Get.back();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    postalController.dispose();
    super.onClose();
  }
}
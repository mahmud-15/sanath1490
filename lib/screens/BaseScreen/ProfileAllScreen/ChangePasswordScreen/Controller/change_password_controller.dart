import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();

  // ─── Text controllers ─────────────────────────────
  final currentPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();

  // ─── Password visibility toggles ──────────────────
  final hideCurrentPass = true.obs;
  final hideNewPass = true.obs;
  final hideConfirmPass = true.obs;

  void toggleCurrentPass() => hideCurrentPass.value = !hideCurrentPass.value;
  void toggleNewPass() => hideNewPass.value = !hideNewPass.value;
  void toggleConfirmPass() => hideConfirmPass.value = !hideConfirmPass.value;

  // ─── Save changes ─────────────────────────────────
  void saveChanges() {
    if (formKey.currentState?.validate() ?? false) {
      // TODO: call change password API
      Get.back();
    }
  }

  @override
  void onClose() {
    currentPassController.dispose();
    newPassController.dispose();
    confirmPassController.dispose();
    super.onClose();
  }
}
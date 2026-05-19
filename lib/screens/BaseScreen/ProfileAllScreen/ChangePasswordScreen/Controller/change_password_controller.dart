import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../Repository/change_password_repository.dart';

class ChangePasswordController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _repo = ChangePasswordRepository.instance;

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
  Future<void> saveChanges() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      AppLoader.show();

      final success = await _repo.changePassword(
        currentPassword: currentPassController.text.trim(),
        newPassword: newPassController.text.trim(),
        confirmPassword: confirmPassController.text.trim(),
      );

      AppLoader.hide();

      if (success) {
        AppSnackBar.success('Password changed successfully');
        await Future.delayed(const Duration(seconds: 1));
        Get.offAllNamed(AppRoutes.signInScreen);
      }
    } catch (e) {
      AppLoader.hide();
      AppSnackBar.error('Something went wrong. Please try again.');
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
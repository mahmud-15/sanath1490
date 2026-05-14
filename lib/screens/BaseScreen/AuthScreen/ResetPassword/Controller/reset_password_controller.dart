import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/reset_password_model.dart';

class ResetPasswordController extends GetxController {
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final obscurePassword        = true.obs;
  final obscureConfirmPassword = true.obs;
  final isLoading              = false.obs;
  final RxString email         = ''.obs;

  void togglePassword()        => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  @override
  void onInit() {
    super.onInit();
    passwordController        = TextEditingController();
    confirmPasswordController = TextEditingController();

    final args = Get.arguments;
    if (args != null && args["email"] != null) {
      email.value = args["email"];
    }
  }

  // ==================== Reset Password ====================
  Future<void> resetPassword() async {
    try {
      isLoading.value = true;
      AppLoader.show(message: 'Resetting password...');

      final request = ResetPasswordRequestModel(
        email:           email.value,
        newPassword:     passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      final response = await AuthRepository.instance.resetPassword(request);

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        AppSnackBar.success("Password reset successfully!");
        await Future.delayed(const Duration(milliseconds: 500));
        Get.offAllNamed(AppRoutes.signInScreen);
      }
    } catch (e) {
      AppLoader.hide();
      isLoading.value = false;
      AppSnackBar.error("Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
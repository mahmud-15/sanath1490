import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/reset_password_model.dart';

class ResetPasswordController extends GetxController {
  final passwordController        = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final obscurePassword        = true.obs;
  final obscureConfirmPassword = true.obs;
  final RxString email         = ''.obs;

  void togglePassword()        => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args["email"] != null) {
      email.value = args["email"];
    }
  }

  // ==================== Reset Password ====================
  Future<void> resetPassword() async {
    AppLoader.show(type: LoaderType.residentialPulse, message: 'Resetting password...');

    final request = ResetPasswordRequestModel(
      email: email.value,
      newPassword: passwordController.text.trim(),
    );

    final response = await AuthRepository.instance.resetPassword(request);

    AppLoader.hide();

    if (response != null) {
      AppSnackBar.success("Password reset successfully!");
      await Future.delayed(const Duration(milliseconds: 800));
      Get.offAllNamed(AppRoutes.signInScreen);
    }
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
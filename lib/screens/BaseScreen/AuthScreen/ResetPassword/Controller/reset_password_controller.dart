import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/storage/storage_services.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/reset_password_model.dart';

class ResetPasswordController extends GetxController {
  late TextEditingController passwordController;
  late TextEditingController confirmPasswordController;

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

  Future<void> resetPassword() async {
    try {
      isLoading.value = true;
      AppLoader.show(message: 'Resetting password...');

      final resetToken = await StorageServices.instance.getResetToken();

      final request = ResetPasswordRequestModel(
        email:           email.value,
        newPassword:     passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      final response = await AuthRepository.instance.resetPassword(
        request,
        resetToken: resetToken,
      );

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        await StorageServices.instance.clearResetToken();
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
    try { passwordController.dispose(); } catch (_) {}
    try { confirmPasswordController.dispose(); } catch (_) {}
    super.onClose();
  }
}
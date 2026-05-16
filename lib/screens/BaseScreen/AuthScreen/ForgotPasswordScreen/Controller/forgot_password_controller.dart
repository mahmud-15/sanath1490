import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  late TextEditingController emailController;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    emailController = TextEditingController();
  }

  Future<void> sendOtp() async {
    try {
      isLoading.value = true;
      AppLoader.show(message: 'Sending OTP...');

      final request = ForgotPasswordRequestModel(
        email: emailController.text.trim(),
      );

      final response = await AuthRepository.instance.forgotPassword(request);

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        await Future.delayed(const Duration(milliseconds: 150));
        Get.toNamed(
          AppRoutes.resetVerifyOtpScreen,
          arguments: {"email": emailController.text.trim()},
        );
      }
    } catch (e) {
      AppLoader.hide();
      isLoading.value = false;
      AppSnackBar.error("Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    try { emailController.dispose(); } catch (_) {}
    super.onClose();
  }
}
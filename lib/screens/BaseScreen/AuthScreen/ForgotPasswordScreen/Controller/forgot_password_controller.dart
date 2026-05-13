import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/forgot_password_model.dart';

class ForgotPasswordController extends GetxController {
  final emailController = TextEditingController();
  final isLoading       = false.obs;

  // ==================== Forgot Password ====================
  Future<void> sendOtp() async {
    isLoading.value = true;

    final request = ForgotPasswordRequestModel(
      email: emailController.text.trim(),
    );

    final response = await AuthRepository.instance.forgotPassword(request);

    isLoading.value = false;

    if (response != null) {
      Get.toNamed(
        AppRoutes.resetVerifyOtpScreen,
        arguments: {"email": emailController.text.trim()},
      );
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
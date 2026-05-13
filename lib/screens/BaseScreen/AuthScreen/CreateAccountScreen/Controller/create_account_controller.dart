import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/register_model.dart';

class CreateAccountController extends GetxController {
  final fullNameController        = TextEditingController();
  final emailController           = TextEditingController();
  final passwordController        = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isTermsAccepted        = false.obs;
  final obscurePassword        = true.obs;
  final obscureConfirmPassword = true.obs;
  final isLoading              = false.obs;

  void toggleTerms()           => isTermsAccepted.value = !isTermsAccepted.value;
  void togglePassword()        => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  // ==================== Register ====================
  Future<void> onContinue() async {
    isLoading.value = true;

    final request = RegisterRequestModel(
      name: fullNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final response = await AuthRepository.instance.register(request);

    isLoading.value = false;

    if (response != null) {
      Get.toNamed(
        AppRoutes.accountVerifyOtpScreen,
        arguments: {"email": emailController.text.trim()},
      );
    }
  }

  // ==================== Google Sign Up ====================
  void onGoogleSignUp() {
    // TODO: google sign up logic
  }

  @override
  void onClose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateAccountController extends GetxController {
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isTermsAccepted = false.obs;
  final obscurePassword = true.obs;
  final obscureConfirmPassword = true.obs;

  void toggleTerms() => isTermsAccepted.value = !isTermsAccepted.value;
  void togglePassword() => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  void onContinue() {
    // TODO: sign up logic
  }

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
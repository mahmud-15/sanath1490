import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/register_model.dart';

class CreateAccountController extends GetxController {
  late final TextEditingController fullNameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  final isTermsAccepted        = false.obs;
  final obscurePassword        = true.obs;
  final obscureConfirmPassword = true.obs;
  final isLoading              = false.obs;

  void toggleTerms()           => isTermsAccepted.value = !isTermsAccepted.value;
  void togglePassword()        => obscurePassword.value = !obscurePassword.value;
  void toggleConfirmPassword() => obscureConfirmPassword.value = !obscureConfirmPassword.value;

  @override
  void onInit() {
    super.onInit();
    fullNameController        = TextEditingController();
    emailController           = TextEditingController();
    passwordController        = TextEditingController();
    confirmPasswordController = TextEditingController();
  }

  // ==================== Register ====================
  Future<void> onContinue() async {
    try {
      isLoading.value = true;
      AppLoader.show(message: 'Creating account...');

      final request = RegisterRequestModel(
        name:     fullNameController.text.trim(),
        email:    emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await AuthRepository.instance.register(request);

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        await Future.delayed(const Duration(milliseconds: 150));
        Get.toNamed(
          AppRoutes.accountVerifyOtpScreen,
          arguments: {"email": emailController.text.trim()},
        );
      }
    } catch (e) {
      AppLoader.hide();
      isLoading.value = false;
    }
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/storage/storage_services.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/sign_in_model.dart';

class SignInController extends GetxController {
  TextEditingController emailController    = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading       = false.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  @override
  void onInit() {
    super.onInit();
    emailController    = TextEditingController();
    passwordController = TextEditingController();
  }

  // ==================== Sign In ====================
  Future<void> signIn() async {
    try {
      isLoading.value = true;
      AppLoader.show(message: 'Signing in...');

      final request = SignInRequestModel(
        email:    emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final response = await AuthRepository.instance.signIn(request);

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        await StorageServices.instance.setToken(response.data?.accessToken ?? "");
        await StorageServices.instance.setRefreshToken(response.data?.refreshToken ?? "");
        AppSnackBar.success("Welcome back!");
        await Future.delayed(const Duration(milliseconds: 150));
        Get.offAllNamed(AppRoutes.navBar);
      }
    } catch (e) {
      AppLoader.hide();
      isLoading.value = false;
      AppSnackBar.error("Something went wrong. Please try again.");
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
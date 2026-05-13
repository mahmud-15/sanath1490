import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/storage/storage_services.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/sign_in_model.dart';

class SignInController extends GetxController {
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();

  final obscurePassword = true.obs;
  final isLoading       = false.obs;

  void togglePassword() => obscurePassword.value = !obscurePassword.value;

  // ==================== Sign In ====================
  Future<void> signIn() async {
    isLoading.value = true;

    final request = SignInRequestModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    final response = await AuthRepository.instance.signIn(request);

    isLoading.value = false;

    if (response != null) {
      await StorageServices.instance.setToken(response.data?.accessToken ?? "");
      await StorageServices.instance.setRefreshToken(response.data?.refreshToken ?? "");
      AppSnackBar.success("Welcome back!");
      await Future.delayed(const Duration(milliseconds: 800));
      Get.offAllNamed(AppRoutes.navBar);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
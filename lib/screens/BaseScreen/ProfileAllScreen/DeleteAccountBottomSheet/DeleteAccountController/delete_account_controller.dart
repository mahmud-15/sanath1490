import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../DeleteAccountRepository/delete_account_repository.dart';
import '../Widget/account_deleted_popup.dart';

class DeleteAccountController extends GetxController {
  final _repo = DeleteAccountRepository.instance;

  final passwordController = TextEditingController();
  final obscure = true.obs;

  void toggleObscure() => obscure.value = !obscure.value;

  Future<void> deleteAccount() async {
    final password = passwordController.text.trim();

    if (password.isEmpty) {
      AppSnackBar.error('Please enter your password');
      return;
    }

    try {
      AppLoader.show();

      final success = await _repo.deleteAccount(password: password);

      AppLoader.hide();

      if (success) {
        Get.back(); // close bottom sheet
        _showDeletedPopup();
      }
    } catch (e) {
      AppLoader.hide();
      AppSnackBar.error('Something went wrong. Please try again.');
    }
  }

  void _showDeletedPopup() {
    Get.dialog(
      const AccountDeletedPopup(),
      barrierDismissible: false,
    );

    Future.delayed(const Duration(seconds: 2), () {
      Get.back(); // close popup
      AppSnackBar.success('Your account has been deleted successfully');
      Get.offAllNamed(AppRoutes.signInScreen);
    });
  }

  @override
  void onClose() {
    passwordController.dispose();
    super.onClose();
  }
}
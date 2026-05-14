import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/reset_verify_otp_model.dart';

class ResetVerifyOtpController extends GetxController {
  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  final RxInt    secondsRemaining = 59.obs;
  final RxString email            = ''.obs;
  final RxBool   isLoading        = false.obs;

  String currentPin = '';
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args["email"] != null) {
      email.value = args["email"];
    }
    startTimer();
  }

  // ==================== Timer ====================
  void startTimer() {
    _timer?.cancel();
    secondsRemaining.value = 59;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (secondsRemaining.value == 0) {
        timer.cancel();
      } else {
        secondsRemaining.value--;
      }
    });
  }

  void onPinChanged(String pin) => currentPin = pin;

  // ==================== Verify OTP ====================
  Future<void> verifyOtp() async {
    if (currentPin.length < 6) return;

    isLoading.value = true;
    AppLoader.show(message: 'Verifying OTP...');

    final request = ResetVerifyOtpRequestModel(
      email: email.value,
      oneTimeCode: int.parse(currentPin),
    );

    final response = await AuthRepository.instance.forgotVerifyOtp(request);

    AppLoader.hide();
    isLoading.value = false;

    if (response != null) {
      AppSnackBar.success("OTP verified successfully!");
      await Future.delayed(const Duration(milliseconds: 800));
      Get.toNamed(
        AppRoutes.resetPasswordScreen,
        arguments: {"email": email.value},
      );
    }
  }

  // ==================== Resend OTP ====================
  Future<void> resendOtp() async {
    if (secondsRemaining.value != 0) return;
    // TODO: resend OTP API call
    startTimer();
  }

  void onOtpChanged(String val, int index) {
    if (val.isNotEmpty && index < 3) {
      focusNodes[index + 1].requestFocus();
    } else if (val.isEmpty && index > 0) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  void onClose() {
    _timer?.cancel();
    for (final c in controllers) {
      c.dispose();
    }
    for (final f in focusNodes) {
      f.dispose();
    }
    super.onClose();
  }
}
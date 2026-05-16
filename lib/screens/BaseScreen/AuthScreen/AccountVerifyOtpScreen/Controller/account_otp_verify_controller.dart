import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../AuthRepository/auth_repository.dart';
import '../Model/otp_verify_model.dart';

class AccountOtpVerifyController extends GetxController {
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
    try {
      final args = Get.arguments;
      if (args != null && args["email"] != null) {
        email.value = args["email"];
      }
      startTimer();
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] onInit error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
    }
  }

  // ==================== Timer ====================
  void startTimer() {
    try {
      _timer?.cancel();
      secondsRemaining.value = 59;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        try {
          if (secondsRemaining.value == 0) {
            timer.cancel();
          } else {
            secondsRemaining.value--;
          }
        } catch (e, stackTrace) {
          debugPrint('[AccountOtpVerifyController] Timer tick error: $e');
          debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
          timer.cancel();
        }
      });
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] startTimer error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
    }
  }

  void onPinChanged(String pin) {
    try {
      currentPin = pin;
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] onPinChanged error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
    }
  }

  // ==================== Verify OTP ====================
  Future<void> verifyOtp() async {
    if (currentPin.length < 6) return;

    try {
      isLoading.value = true;
      AppLoader.show(message: 'Verifying OTP...');

      final request = OtpVerifyRequestModel(
        email: email.value,
        oneTimeCode: int.parse(currentPin),
      );

      final response = await AuthRepository.instance.verifyOtp(request);

      AppLoader.hide();
      isLoading.value = false;

      if (response != null) {
        AppSnackBar.success("Account verified successfully!");
        await Future.delayed(const Duration(milliseconds: 800));
        Get.toNamed(AppRoutes.signInScreen);
      }
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] verifyOtp error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
      AppLoader.hide();
      isLoading.value = false;
      AppSnackBar.error("Something went wrong. Please try again.");
    }
  }

  // ==================== Resend OTP ====================
  Future<void> resendOtp() async {
    if (secondsRemaining.value != 0) return;
    try {
      // TODO: resend OTP API call
      startTimer();
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] resendOtp error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
      AppSnackBar.error("Failed to resend OTP. Please try again.");
    }
  }

  void onOtpChanged(String val, int index) {
    try {
      if (val.isNotEmpty && index < 3) {
        focusNodes[index + 1].requestFocus();
      } else if (val.isEmpty && index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] onOtpChanged error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
    }
  }

  @override
  void onClose() {
    try {
      _timer?.cancel();
      for (final c in controllers) {
        c.dispose();
      }
      for (final f in focusNodes) {
        f.dispose();
      }
    } catch (e, stackTrace) {
      debugPrint('[AccountOtpVerifyController] onClose error: $e');
      debugPrint('[AccountOtpVerifyController] StackTrace: $stackTrace');
    } finally {
      super.onClose();
    }
  }
}
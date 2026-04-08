import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';

class ResetVerifyOtpController extends GetxController {

  ResetVerifyOtpController({String initialEmail = ''}) {
    email.value = initialEmail;
  }

  final List<TextEditingController> controllers =
  List.generate(4, (_) => TextEditingController());
  final List<FocusNode> focusNodes =
  List.generate(4, (_) => FocusNode());

  final RxInt secondsRemaining = 59.obs;
  final RxString email = ''.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

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

  void onPinChanged(String pin) {
    currentPin = pin;
  }

  String currentPin = '';

  void verifyOtp() {
    if (currentPin.length < 6) return;
    Get.toNamed(AppRoutes.resetPasswordScreen);
  }

  void resendOtp() {
    if (secondsRemaining.value == 0) startTimer();
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
    for (final c in controllers) c.dispose();
    for (final f in focusNodes) f.dispose();
    super.onClose();
  }
}
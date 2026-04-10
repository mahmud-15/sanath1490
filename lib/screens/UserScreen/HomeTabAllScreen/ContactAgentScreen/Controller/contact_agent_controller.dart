import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactAgentController extends GetxController {
  // ─── Form ────────────────────────────────
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final postalCodeController = TextEditingController();
  final messageController = TextEditingController();

  // ─── State ───────────────────────────────
  final selectedCountry = RxnString();
  final messageLength = 0.obs;
  final maxMessageLength = 700;

  final countries = [
    'United Kingdom',
    'United States',
    'Australia',
    'Canada',
    'Ireland',
  ];

  void onCountryChanged(String? value) => selectedCountry.value = value;

  void onMessageChanged(String value) => messageLength.value = value.length;

  // ─── Send ────────────────────────────────
  void onSend() {
    if (formKey.currentState!.validate()) {
      // TODO: send email logic
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    postalCodeController.dispose();
    messageController.dispose();
    super.onClose();
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../EnquiriesScreen/Controller/enquiries_controller.dart';
import '../../PropertyDetailsScreen/Controller/property_details_controller.dart';

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
  final isLoading = false.obs;

  // ─── Property & Agent data ────────────────
  final propertyImage = ''.obs;
  final propertyPrice = ''.obs;
  final propertyAddress = ''.obs;
  final agentImage = ''.obs;
  final agentName = ''.obs;
  final agentEmail = ''.obs;
  late String _listingId;

  final countries = [
    'United Kingdom',
    'United States',
    'Australia',
    'Canada',
    'Ireland',
    'Bangladesh',
  ];

  @override
  void onReady() {
    super.onReady();
    _loadPropertyData();
  }

  void _loadPropertyData() {
    try {
      final details = Get.find<PropertyDetailsController>();
      _listingId = details.property.id;
      propertyImage.value = details.images.isNotEmpty ? details.images.first : '';
      propertyPrice.value = details.price.value;
      propertyAddress.value = details.address.value;
      agentName.value = details.agentName.value;
      agentEmail.value = details.agentEmail.value;
      agentImage.value = details.agentImage.value;
    } catch (_) {}
  }

  void onCountryChanged(String? value) => selectedCountry.value = value;

  void onMessageChanged(String value) => messageLength.value = value.length;

  // ─── Send ────────────────────────────────
  Future<void> onSend() async {
    if (!formKey.currentState!.validate()) return;
    if (selectedCountry.value == null) {
      AppSnackBar.error("Please select a country");
      return;
    }

    try {
      isLoading(true);

      final response = await ApiServices.instance.postServices(
        url: AppApiUrl.instance.createEnquiries,
        body: {
          "listingId": _listingId,
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "phone": phoneController.text.trim(),
          "postalCode": postalCodeController.text.trim(),
          "country": selectedCountry.value,
          "message": messageController.text.trim(),
        },
      );

      if (response != null) {
        AppSnackBar.success("Enquiry sent successfully");
        Get.toNamed(AppRoutes.navBar, arguments: 2);
        if (Get.isRegistered<EnquiriesController>()) {
          Get.find<EnquiriesController>().fetchEnquiries();
        }
      }
    } catch (e) {
      AppSnackBar.error("Failed to send enquiry. Please try again.");
    } finally {
      isLoading(false);
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
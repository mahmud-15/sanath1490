import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FilterController extends GetxController {
  // ─── Location ────────────────────────────
  final locationController = TextEditingController();

  // ─── Radius ──────────────────────────────
  final radius = 5.0.obs;

  void onRadiusChanged(double value) => radius.value = value;

  // ─── Property Type ────────────────────────
  final selectedPropertyType = 'Detached'.obs;
  final propertyTypeIcons = [
    'assets/icons/detached_icon.svg',
    'assets/icons/semi_home_icon.svg',
    'assets/icons/terraced_home_icon.svg',
    'assets/icons/bunglow_icon.svg',
    'assets/icons/flat_icon.svg',
    'assets/icons/park_home.svg',
  ];
  final propertyTypes = ['Detached', 'Semi', 'Terraced', 'Bungalow', 'Flat', 'Park Home'];

  void selectPropertyType(String type) => selectedPropertyType.value = type;

  // ─── Price Range ─────────────────────────
  final minPriceController = TextEditingController(text: 'No min');
  final maxPriceController = TextEditingController(text: '£ 5000k');

  // ─── Bedrooms ────────────────────────────
  final selectedBedroom = 'Any'.obs;
  final bedroomOptions = ['Any', '1', '2', '3', '4+'];

  void selectBedroom(String value) => selectedBedroom.value = value;

  // ─── Bathroom ────────────────────────────
  final selectedBathroom = 'Any'.obs;
  final bathroomOptions = ['Any', '1', '2', '3', '4+'];

  void selectBathroom(String value) => selectedBathroom.value = value;

  // ─── Added to Site ───────────────────────
  final selectedAddedToSite = 'Any'.obs;
  final addedToSiteOptions = ['Any', 'Last 24 hours', 'Last 3 days', 'Last 7 days', 'Last 14 days'];

  void selectAddedToSite(String value) => selectedAddedToSite.value = value;

  // ─── Tenure ──────────────────────────────
  final isFreehold = false.obs;
  final isLeasehold = true.obs;
  final isShareOfFreehold = false.obs;

  void toggleFreehold() => isFreehold.value = !isFreehold.value;
  void toggleLeasehold() => isLeasehold.value = !isLeasehold.value;
  void toggleShareOfFreehold() => isShareOfFreehold.value = !isShareOfFreehold.value;

  // ─── Property Features ───────────────────
  final hasGarden = false.obs;
  final hasParking = true.obs;

  void toggleGarden() => hasGarden.value = !hasGarden.value;
  void toggleParking() => hasParking.value = !hasParking.value;

  // ─── Actions ─────────────────────────────
  void onClear() {
    locationController.clear();
    radius.value = 5.0;
    selectedPropertyType.value = 'Detached';
    minPriceController.text = 'No min';
    maxPriceController.text = '£ 5000k';
    selectedBedroom.value = 'Any';
    selectedBathroom.value = 'Any';
    selectedAddedToSite.value = 'Any';
    isFreehold.value = false;
    isLeasehold.value = false;
    isShareOfFreehold.value = false;
    hasGarden.value = false;
    hasParking.value = false;
  }

  void onSearch() {
    // TODO: apply filter logic
    Get.back();
  }

  @override
  void onClose() {
    locationController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.onClose();
  }
}
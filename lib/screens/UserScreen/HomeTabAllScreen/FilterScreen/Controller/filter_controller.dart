import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../HomeTabAllScreen/HomeScreen/Model/property_model.dart';

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
  final propertyTypes = [
    'Detached',
    'Semi',
    'Terraced',
    'Bungalow',
    'Flat',
    'Park Home',
  ];

  // Backend property type mapping
  final _propertyTypeMap = {
    'Detached': 'DETACHED',
    'Semi': 'SEMI',
    'Terraced': 'TERRACED',
    'Bungalow': 'BANGLOW',
    'Flat': 'FLAT',
    'Park Home': 'PARK_HOME',
  };

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
  final addedToSiteOptions = [
    'Any',
    'Last 24 hours',
    'Last 3 days',
    'Last 7 days',
    'Last 14 days',
  ];

  // Backend timeFilter mapping
  final _timeFilterMap = {
    'Any': 'any',
    'Last 24 hours': 'twentyFourHours',
    'Last 3 days': 'threeDays',
    'Last 7 days': 'sevenDays',
    'Last 14 days': 'fourteenDays',
  };

  void selectAddedToSite(String value) => selectedAddedToSite.value = value;

  // ─── Tenure ──────────────────────────────
  final isFreehold = false.obs;
  final isLeasehold = true.obs;
  final isShareOfFreehold = false.obs;

  void toggleFreehold() => isFreehold.value = !isFreehold.value;

  void toggleLeasehold() => isLeasehold.value = !isLeasehold.value;

  void toggleShareOfFreehold() =>
      isShareOfFreehold.value = !isShareOfFreehold.value;

  // ─── Property Features ───────────────────
  final hasGarden = false.obs;
  final hasParking = true.obs;

  void toggleGarden() => hasGarden.value = !hasGarden.value;

  void toggleParking() => hasParking.value = !hasParking.value;

  // ─── Loading ─────────────────────────────
  final isLoading = false.obs;

  // ─── Results ─────────────────────────────
  final searchResults = <PropertyModel>[].obs;

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

  Future<void> onSearch() async {
    try {
      isLoading(true);

      // ─── Build tenure list ────────────────
      final tenureList = <String>[];
      if (isFreehold.value) tenureList.add('FREEHOLD');
      if (isLeasehold.value) tenureList.add('LEASEHOLD');
      if (isShareOfFreehold.value) tenureList.add('SHARE_OF_FREEHOLD');

      // ─── Build features list ──────────────
      final featuresList = <String>[];
      if (hasGarden.value) featuresList.add('GARDEN');
      if (hasParking.value) featuresList.add('PARKING');

      // ─── Build query params ───────────────
      final Map<String, dynamic> params = {
        'lat': 23.8103,
        'lng': 90.4125,
        'radiusInKm': (radius.value * 1.60934 * 1000).toInt(),
      };

      final propertyType = _propertyTypeMap[selectedPropertyType.value];
      if (propertyType != null) params['propertyType'] = propertyType;

      final location = locationController.text.trim();
      if (location.isNotEmpty) params['location'] = location;

      final minPrice = _parsePrice(minPriceController.text);
      if (minPrice != null) params['minPrice'] = minPrice;

      final maxPrice = _parsePrice(maxPriceController.text);
      if (maxPrice != null) params['maxPrice'] = maxPrice;

      if (selectedBedroom.value != 'Any') {
        params['bedrooms'] = selectedBedroom.value == '4+'
            ? 4
            : int.tryParse(selectedBedroom.value);
      }

      if (selectedBathroom.value != 'Any') {
        params['bathrooms'] = selectedBathroom.value == '4+'
            ? 4
            : int.tryParse(selectedBathroom.value);
      }

      final timeFilter = _timeFilterMap[selectedAddedToSite.value];
      if (timeFilter != null && timeFilter != 'any') {
        params['timeFilter'] = timeFilter;
      }

      if (tenureList.isNotEmpty) params['tenure'] = tenureList.join(',');
      if (featuresList.isNotEmpty) params['features'] = featuresList.join(',');

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.listingsSearch,
        queryParameters: params,
      );

      if (response != null && response['data'] != null) {
        final List data = response['data'];
        searchResults.value = data
            .map((e) => PropertyModel.fromJson(e))
            .toList();
        Get.toNamed(
          AppRoutes.propertyListScreen,
          arguments: searchResults,
        );
      }
    } catch (e) {
      AppSnackBar.error("Failed to search. Please try again.");
    } finally {
      isLoading(false);
    }
  }

  // ─── Parse price from text ────────────────
  int? _parsePrice(String text) {
    final cleaned = text.replaceAll(RegExp(r'[£,\s]'), '').toLowerCase();
    if (cleaned.isEmpty || cleaned == 'nomin' || cleaned == '5000k') {
      return null;
    }
    if (cleaned.endsWith('k')) {
      final num = double.tryParse(cleaned.replaceAll('k', ''));
      return num != null ? (num * 1000).toInt() : null;
    }
    return int.tryParse(cleaned);
  }

  @override
  void onClose() {
    locationController.dispose();
    minPriceController.dispose();
    maxPriceController.dispose();
    super.onClose();
  }
}

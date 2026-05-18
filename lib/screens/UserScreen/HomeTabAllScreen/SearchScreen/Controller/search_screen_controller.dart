import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/api/api_service.dart';
import '../../HomeScreen/Model/property_model.dart';

class SearchScreenController extends GetxController {
  final textEditingController = TextEditingController();

  final searchQuery = ''.obs;
  final isLoading = false.obs;

  final recentSearches = <String>[
    'London',
    'Around Zone 2(Central)',
  ].obs;

  final _allSuggestions = <String>[
    'London',
    'Wimbledon, South West London',
    'Central London',
    'North London',
    'Bromley, London',
    'South London',
    'Beckenham, London',
    'Hampstead, North West London',
    'Romford, London',
    'Manchester',
    'Oxford',
    'Birmingham',
    'Liverpool',
    'Leeds',
    'Sheffield',
    'Bristol',
    'Edinburgh',
    'Glasgow',
    'Leicester',
    'Coventry',
  ];

  List<String> get filteredSuggestions {
    final query = searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) return [];
    return _allSuggestions
        .where((s) => s.toLowerCase().contains(query))
        .toList();
  }

  void onSearchChanged(String value) => searchQuery.value = value;

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
  }

  void onRecentTap(String item) {
    textEditingController.text = item;
    searchQuery.value = item;
  }

  Future<void> onSuggestionTap(String suggestion) async {
    // ─── Update recent searches ───────────
    if (!recentSearches.contains(suggestion)) {
      recentSearches.insert(0, suggestion);
      if (recentSearches.length > 5) recentSearches.removeLast();
    }
    clearSearch();

    await _searchAndNavigate(suggestion);
  }

  Future<void> useCurrentLocation() async {
    await _searchAndNavigate('');
  }

  Future<void> _searchAndNavigate(String location) async {
    try {
      isLoading(true);

      final Map<String, dynamic> params = {
        'lat': 23.8103,
        'lng': 90.4125,
        'radiusInKm': 50000,
      };

      if (location.isNotEmpty) params['location'] = location;

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.listingsSearch,
        queryParameters: params,
      );

      if (response != null && response['data'] != null) {
        final List data = response['data'];
        final results = data.map((e) => PropertyModel.fromJson(e)).toList();

        Get.toNamed(
          AppRoutes.propertyListScreen,
          arguments: results,
        );
      }
    } catch (e) {
      // silent fail — user stays on search screen
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
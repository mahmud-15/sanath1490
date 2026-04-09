import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final textEditingController = TextEditingController();

  final searchQuery = ''.obs;

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

  void onSearchChanged(String value) {
    searchQuery.value = value;
  }

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
  }

  void onRecentTap(String item) {
    textEditingController.text = item;
    searchQuery.value = item;
  }

  void onSuggestionTap(String suggestion) {
    if (!recentSearches.contains(suggestion)) {
      recentSearches.insert(0, suggestion);
      if (recentSearches.length > 5) {
        recentSearches.removeLast();
      }
    }
    clearSearch();
    // Get.toNamed(AppRoutes.resultsScreen, arguments: suggestion);
  }
  void useCurrentLocation() {
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }
}
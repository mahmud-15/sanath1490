import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../../../../service/api/api_service.dart';
import '../../HomeScreen/Model/property_model.dart';
import '../Widget/recent_item_placeholder.dart';

class SearchSuggestion {
  final String label;
  final String subLabel;
  final String type;
  final String searchValue;

  const SearchSuggestion({
    required this.label,
    required this.subLabel,
    required this.type,
    required this.searchValue,
  });
}

class SearchScreenController extends GetxController {
  final textEditingController = TextEditingController();
  final searchQuery = ''.obs;
  final isLoading = false.obs;
  final isSuggestionLoading = false.obs;
  final suggestions = <SearchSuggestion>[].obs;
  final recentSearches = <String>[].obs;
  final listKey = GlobalKey<AnimatedListState>();

  Worker? _debounceWorker;

  @override
  void onInit() {
    super.onInit();
    _loadRecentSearches();
    _debounceWorker = debounce(
      searchQuery,
          (value) {
        if (value.trim().isNotEmpty) {
          _fetchSuggestions(value.trim());
        } else {
          suggestions.clear();
        }
      },
      time: const Duration(milliseconds: 300),
    );
  }

  Future<void> _loadRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getStringList('recentSearches') ?? [];
      recentSearches.value = saved;
    } catch (_) {}
  }

  Future<void> _saveRecentSearches() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList('recentSearches', recentSearches.toList());
    } catch (_) {}
  }
  Future<void> _fetchSuggestions(String query) async {
    isSuggestionLoading(true);
    suggestions.clear();
    try {
      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.listingsSearch,
        queryParameters: {
          'searchTerm': query,
        },
      );

      if (response != null && response['data'] != null) {
        final List data = response['data'];
        final Set<String> seen = {};
        final List<SearchSuggestion> result = [];

        for (final item in data) {
          final city = item['city']?.toString() ?? '';
          final country = item['country']?.toString() ?? '';
          final postalCode = item['postalCode']?.toString() ?? '';
          final title = item['title']?.toString() ?? '';

          if (city.isNotEmpty && seen.add('city_$city')) {
            result.add(SearchSuggestion(label: city, subLabel: 'City · $country', type: 'city', searchValue: city));
          }
          if (country.isNotEmpty && seen.add('country_$country')) {
            result.add(SearchSuggestion(label: country, subLabel: 'Country', type: 'country', searchValue: country));
          }
          if (postalCode.isNotEmpty && seen.add('postal_$postalCode')) {
            result.add(SearchSuggestion(label: postalCode, subLabel: 'Postal Code · $city', type: 'postalCode', searchValue: postalCode));
          }
          if (title.isNotEmpty && seen.add('title_$title')) {
            result.add(SearchSuggestion(label: title, subLabel: 'Property · $city', type: 'title', searchValue: title));
          }
        }
        suggestions.value = result;
      } else {
        suggestions.clear();
      }
    } catch (_) {
      suggestions.clear();
    } finally {
      isSuggestionLoading(false);
    }
  }

  void onSearchChanged(String value) => searchQuery.value = value;

  void clearSearch() {
    textEditingController.clear();
    searchQuery.value = '';
    suggestions.clear();
  }

  void onRecentTap(String item) {
    textEditingController.text = item;
    searchQuery.value = item;
  }

  Future<void> onSuggestionTap(SearchSuggestion suggestion) async {
    if (!recentSearches.contains(suggestion.label)) {
      recentSearches.insert(0, suggestion.label);
      if (recentSearches.length > 5) recentSearches.removeLast();
      await _saveRecentSearches();
    }
    clearSearch();
    await _searchAndNavigate(suggestion.searchValue);
  }


  void removeRecentSearch(int index) {
    final removed = recentSearches[index];
    recentSearches.removeAt(index);
    listKey.currentState?.removeItem(
      index,
          (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: FadeTransition(
          opacity: animation,
          child: RecentItemPlaceholder(item: removed),
        ),
      ),
      duration: const Duration(milliseconds: 300),
    );
    _saveRecentSearches();
  }

  Future<void> clearRecentSearches() async {
    final length = recentSearches.length;
    for (int i = length - 1; i >= 0; i--) {
      await Future.delayed(const Duration(milliseconds: 80));
      if (recentSearches.isEmpty) break;
      final removed = recentSearches[i < recentSearches.length ? i : recentSearches.length - 1];
      recentSearches.removeAt(i < recentSearches.length ? i : recentSearches.length - 1);
      listKey.currentState?.removeItem(
        i < (listKey.currentState?.widget.initialItemCount ?? 0) ? i : 0,
            (context, animation) => SizeTransition(
          sizeFactor: CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
          child: FadeTransition(
            opacity: animation,
            child: RecentItemPlaceholder(item: removed),
          ),
        ),
        duration: const Duration(milliseconds: 250),
      );
    }
    await _saveRecentSearches();
  }

  Future<void> useCurrentLocation() async {
    await _searchAndNavigate('');
  }

  Future<void> _searchAndNavigate(String searchTerm) async {
    try {
      isLoading(true);

      final Map<String, dynamic> params = {};

      if (searchTerm.isNotEmpty) params['searchTerm'] = searchTerm;

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.listingsSearch,
        queryParameters: params,
      );

      if (response != null && response['data'] != null) {
        final List data = response['data'];
        final results = data.map((e) => PropertyModel.fromJson(e)).toList();
        Get.toNamed(AppRoutes.propertyListScreen, arguments: results);
      }
    } catch (_) {
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    _debounceWorker?.dispose();
    textEditingController.dispose();
    super.onClose();
  }
}


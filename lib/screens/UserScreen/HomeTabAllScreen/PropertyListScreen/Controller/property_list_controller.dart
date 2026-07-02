import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../routes/app_routes/app_routes.dart';
import '../../HomeScreen/Model/property_model.dart';

class PropertyListController extends GetxController {
  final isListView = true.obs;
  final selectedSort = 'Newest First'.obs;
  final RxBool isFavourite = false.obs;
  final isLoading = false.obs;
  final selectedMapIndex = (-1).obs;
  final properties = <PropertyModel>[].obs;
  final appBarTitle = ConstString.searchResult.obs;

  @override
  void onReady() {
    super.onReady();
    _loadArguments();
  }

  ///new add code
  void _loadArguments() {
    try {
      if (Get.arguments == null) return;

      if (Get.arguments is List<PropertyModel>) {
        // Existing flow (Home / Location card) — untouched
        properties.value = Get.arguments as List<PropertyModel>;
        return;
      }

      if (Get.arguments is Map) {
        final args = Get.arguments as Map;
        appBarTitle.value = ConstString.propertyList;
        final list = args['properties'];
        final highlightId = args['highlightId'];

        if (list is List<PropertyModel>) {
          properties.value = list;
        }

        if (highlightId is String && highlightId.isNotEmpty) {
          final idx = properties.indexWhere((p) => p.id == highlightId);
          debugPrint('[MAP_DEBUG] Total properties: ${properties.length}');
          for (var p in properties) {
            debugPrint('[MAP_DEBUG] id=${p.id} lat=${p.lat} lng=${p.lng}');
          }
          debugPrint('[MAP_DEBUG] highlightId=$highlightId matchedIndex=$idx');
          if (idx != -1) {
            selectedMapIndex.value = idx;
            isListView.value = false;
          }
        }
      }
    } catch (e) {
      properties.value = [];
    }
  }

  ///new add code end
  void selectSort(String option) {
    selectedSort.value = option;
    _sortProperties(option);
  }

  void _sortProperties(String option) {
    switch (option) {
      case 'Price: Low to High':
        properties.sort(
          (a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)),
        );
        break;
      case 'Price: High to Low':
        properties.sort(
          (a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)),
        );
        break;
      case 'Newest First':
        properties.sort(
          (a, b) => _parseDate(b.addedDate).compareTo(_parseDate(a.addedDate)),
        );
        break;
      case 'Oldest First':
        properties.sort(
          (a, b) => _parseDate(a.addedDate).compareTo(_parseDate(b.addedDate)),
        );
        break;
    }
    properties.refresh();
  }

  DateTime _parseDate(String date) {
    try {
      final parts = date.split('/');
      if (parts.length != 3) return DateTime(0);
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    } catch (_) {
      return DateTime(0);
    }
  }

  void onMapMarkerTap(int index) {
    selectedMapIndex.value = index;
  }

  int _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[£,/moa-z\s]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  void onFilterTap() => Get.toNamed(AppRoutes.filterScreen);

  void toggleFavourite() => isFavourite.value = !isFavourite.value;
}

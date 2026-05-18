import 'package:get/get.dart';
import '../../HomeScreen/Model/property_model.dart';

class PropertyListController extends GetxController {
  final isListView = true.obs;
  final selectedSort = 'Newest First'.obs;
  final RxBool isFavourite = false.obs;
  final isLoading = false.obs;

  // ─── Properties ──────────────────────────
  final properties = <PropertyModel>[].obs;

  @override
  void onReady() {
    super.onReady();
    _loadArguments();
  }

  void _loadArguments() {
    try {
      if (Get.arguments != null && Get.arguments is List<PropertyModel>) {
        properties.value = Get.arguments as List<PropertyModel>;
      }
    } catch (_) {}
  }

  void selectSort(String option) {
    selectedSort.value = option;
    _sortProperties(option);
  }

  void _sortProperties(String option) {
    switch (option) {
      case 'Price: Low to High':
        properties.sort((a, b) => _parsePrice(a.price).compareTo(_parsePrice(b.price)));
        break;
      case 'Price: High to Low':
        properties.sort((a, b) => _parsePrice(b.price).compareTo(_parsePrice(a.price)));
        break;
      case 'Newest First':
        properties.sort((a, b) => b.addedDate.compareTo(a.addedDate));
        break;
      case 'Old First':
        properties.sort((a, b) => a.addedDate.compareTo(b.addedDate));
        break;
    }
  }

  int _parsePrice(String price) {
    final cleaned = price.replaceAll(RegExp(r'[£,/moa-z\s]'), '');
    return int.tryParse(cleaned) ?? 0;
  }

  void onFilterTap() => Get.toNamed('/filterScreen');

  void toggleFavourite() => isFavourite.value = !isFavourite.value;
}
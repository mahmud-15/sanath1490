import 'package:get/get.dart';

class PropertyListController extends GetxController {
  final isListView = true.obs;

  final selectedSort = 'Newest First'.obs;

  // ─── Select specific sort option ──────────────────
  void selectSort(String option) {
    selectedSort.value = option;
  }
}
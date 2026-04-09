import 'package:get/get.dart';

class PropertyListController extends GetxController {
  final isListView = true.obs;
  final selectedSort = 'Newest First'.obs;
  final searchTitle = 'London'.obs;
  final totalResults = 6.obs;

  void selectSort(String option) => selectedSort.value = option;
  void onFilterTap() {}
}
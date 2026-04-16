import 'package:get/get.dart';

class PropertyListController extends GetxController {
  final isListView = true.obs;
  final selectedSort = 'Newest First'.obs;
  final searchTitle = 'London'.obs;
  final totalResults = 6.obs;
  final RxBool isFavourite = false.obs;

  void selectSort(String option) => selectedSort.value = option;

  void onFilterTap() {}

  void toggleFavourite() {
    isFavourite.value = !isFavourite.value;
  }
}

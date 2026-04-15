import 'package:get/get.dart';

import '../../../../../routes/app_routes/app_routes.dart';

class MyListingController extends GetxController {
  // ─── Tab: 0 = Sell, 1 = Rent ──────────────────────
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  // ─── Search query ─────────────────────────────────
  final searchQuery = ''.obs;

  void onSearchChanged(String val) => searchQuery.value = val;

  // ─── Sell listings ────────────────────────────────
  final sellListings = <MyListingModel>[
    MyListingModel(imagePath: 'assets/images/property_img2.png', price: '£975,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img.png', price: '£808,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img2.png', price: '£772,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img3.png', price: '£975,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
  ].obs;

  // ─── Rent listings ────────────────────────────────
  final rentListings = <MyListingModel>[
    MyListingModel(imagePath: 'assets/images/property_img.png', price: '£856,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img.png', price: '£744,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img3.png', price: '£943,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
    MyListingModel(imagePath: 'assets/images/property_img2.png', price: '£875,000', title: 'Stunning Victorian Terrace', address: '42 Morning Lane, London', beds: 4, baths: 3, sqFt: 2400, status: 'ACTIVE'),
  ].obs;

  // ─── Current tab listings filtered by search ──────
  List<MyListingModel> get currentListings {
    final list = selectedTab.value == 0 ? sellListings : rentListings;
    final query = searchQuery.value.toLowerCase().trim();
    if (query.isEmpty) return list;
    return list.where((l) =>
    l.title.toLowerCase().contains(query) ||
        l.address.toLowerCase().contains(query)
    ).toList();
  }

  // ─── Navigate to add new listing ──────────────────
  void onAddNew() {
    Get.toNamed(AppRoutes.addNewListingScreen);
  }

  // ─── Tap on a listing card ────────────────────────
  void onCardTap(MyListingModel item) {
    // TODO: Get.toNamed(AppRoutes.propertyDetails, arguments: item);
  }
}

// ─────────────────────────────────────────────────────
class MyListingModel {
  final String imagePath;
  final String price;
  final String title;
  final String address;
  final int beds;
  final int baths;
  final int sqFt;
  final String status;

  MyListingModel({
    required this.imagePath,
    required this.price,
    required this.title,
    required this.address,
    required this.beds,
    required this.baths,
    required this.sqFt,
    required this.status,
  });
}
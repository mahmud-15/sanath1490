import 'package:get/get.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../Model/property_model.dart';

class HomeController extends GetxController {
  final selectedTab = 0.obs;

  void onTabChanged(int index) {
    selectedTab.value = index;
  }

  final searchQuery = ''.obs;

  void onSearchChanged(String value) => searchQuery.value = value;

  // ─── Nearby Listings ───────────────────
  final isLoading = false.obs;
  final buyProperties = <PropertyModel>[].obs;
  final rentProperties = <PropertyModel>[].obs;

  RxList<PropertyModel> get currentProperties =>
      selectedTab.value == 0 ? buyProperties : rentProperties;

  @override
  void onReady() {
    super.onReady();
    fetchNearbyListings();
  }

  Future<void> fetchNearbyListings() async {
    try {
      isLoading(true);

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.nearbyListingProperty,
        queryParameters: {
          "lat": 23.8103,
          "lng": 90.4125,
          "radiusInKm": 50000,
        },
      );
      print("🏠 RESPONSE >>> $response");

      if (response != null && response["data"] != null) {
        final List data = response["data"];
        for (var item in data) {
          print("📋 listingType >>> ${item["listingType"]}");
        }
        print("🏠 TOTAL >>> ${data.length}");
        final allListings = data.map((e) => PropertyModel.fromJson(e)).toList();

        buyProperties.value =
            allListings.where((e) => e.listingType == "SALE").toList();

        rentProperties.value =
            allListings.where((e) => e.listingType == "RENT").toList();

        print("🏠 BUY >>> ${buyProperties.length}");
        print("🏠 RENT >>> ${rentProperties.length}");
      }
    } finally {
      isLoading(false);
    }
  }

  // ─── Popular Locations ───────────────────
  final popularLocations = <LocationModel>[
    LocationModel(imagePath: 'assets/images/location_img1.jpg', name: 'London', count: '12,600+'),
    LocationModel(imagePath: 'assets/images/location_img2.jpg', name: 'Manchester', count: '10,400+'),
    LocationModel(imagePath: 'assets/images/location_img3.jpg', name: 'Oxford', count: '11,400+'),
    LocationModel(imagePath: 'assets/images/location_img4.png', name: 'Leicester', count: '12,400+'),
  ].obs;
}

// ─────────────────────────────────────────
class LocationModel {
  final String imagePath;
  final String name;
  final String count;

  LocationModel({
    required this.imagePath,
    required this.name,
    required this.count,
  });
}
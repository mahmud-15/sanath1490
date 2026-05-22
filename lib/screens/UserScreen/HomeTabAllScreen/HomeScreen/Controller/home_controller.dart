import 'package:get/get.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../service/location/location_service.dart';
import '../../../../../utils/log_print.dart';
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

  final popularLocations = <LocationModel>[].obs;
  final isLocationLoading = false.obs;
/////////////////popular location
  RxList<PropertyModel> get currentProperties =>
      selectedTab.value == 0 ? buyProperties : rentProperties;

  @override
  void onReady() {
    super.onReady();
    fetchNearbyListings();
    fetchPopularLocations();
  }


  Future<void> fetchNearbyListings() async {
    try {
      isLoading(true);

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.nearbyListingProperty,
        queryParameters: {
          "lat": LocationService.instance.lat,
          "lng": LocationService.instance.lng,
          "radiusInMiles": 50000,
        },
      );

      if (response != null && response["data"] != null) {
        final List data = response["data"];
        final allListings = data.map((e) => PropertyModel.fromJson(e)).toList();

        buyProperties.value =
            allListings.where((e) => e.listingType == "SALE").toList();

        rentProperties.value =
            allListings.where((e) => e.listingType == "RENT").toList();
      }
    } finally {
      isLoading(false);
    }
  }

  // ─── Popular Locations ───────────────────
  Future<void> fetchPopularLocations() async {
    try {
      isLocationLoading(true);
      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.popularLocations,
      );

      if (response != null && response["data"] != null) {
        final List data = response["data"];
        popularLocations.assignAll(
          data.map((e) => LocationModel.fromJson(e)).toList(),
        );
      }
    } catch (e) {
      errorLog("fetchPopularLocations", e);
    } finally {
      isLocationLoading(false);
    }
  }

}


// ─────────────────────────────────────────
class LocationModel {
  final String id;
  final String imagePath;
  final String name;
  final String count;
  final List<PropertyModel> listings;

  LocationModel({
    required this.id,
    required this.imagePath,
    required this.name,
    required this.count,
    required this.listings,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = AppApiUrl.instance.imgBaseUrl;
    final image = json["image"] ?? "";
    final imagePath = image.isNotEmpty ? "$baseUrl$image" : "";

    final List listingsRaw = json["listings"] ?? [];
    final listings = listingsRaw
        .whereType<Map<String, dynamic>>()
        .map((e) => PropertyModel.fromJson(e))
        .toList();

    return LocationModel(
      id: json["_id"] ?? "",
      imagePath: imagePath,
      name: json["name"] ?? "",
      count: "${json["totalListing"] ?? 0}+ listings",
      listings: listings,
    );
  }
}
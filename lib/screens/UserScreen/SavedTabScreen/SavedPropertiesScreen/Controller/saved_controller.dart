import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../utils/log_print.dart';
import '../../../HomeTabAllScreen/HomeScreen/Model/property_model.dart';

class SavedController extends GetxController {
  // ─── Tab index: 0 = Properties, 1 = Searches ─────
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  // ─── Saved Properties ─────────────────────────────
  final savedProperties = <PropertyModel>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFavouriteProperties();
    fetchSavedSearches();
  }

  Future<void> fetchFavouriteProperties() async {
    try {
      isLoading(true);
      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.favouriteProperties,
      );

      if (response != null && response["success"] == true) {
        final List data = response["data"] ?? [];

        savedProperties.value = data.map((item) {
          final listing = item["listingId"] as Map<String, dynamic>;
          final model = PropertyModel.fromJson(listing);
          return PropertyModel(
            id: model.id,
            images: model.images,
            price: model.price,
            title: model.title,
            address: model.address,
            addedDate: model.addedDate,
            isFeatured: model.isFeatured,
            listingType: model.listingType,
            isFavourite: true,
          );
        }).toList();
      }
    } catch (e) {
      errorLog("fetchFavouriteProperties", e);
    } finally {
      isLoading(false);
    }
  }

  // ─── Remove from favourites via API ───────────────
  Future<void> removeProperty(int index) async {
    final property = savedProperties[index];
    savedProperties.removeAt(index);

    try {
      final response = await ApiServices.instance.postServices(
        url: AppApiUrl.instance.addFavouriteProperty,
        body: {"listingId": property.id},
        statusCodeStart: 200,
        statusCodeEnd: 299,
      );

      if (response == null || response["success"] != true) {
        savedProperties.insert(index, property);
      }
    } catch (e) {
      errorLog("removeProperty", e);
      savedProperties.insert(index, property);
    }
  }

  // ─── Saved Searches ───────────────────────────────
  final savedSearches = <SavedSearchModel>[].obs;
  final isSearchLoading = false.obs;

  Future<void> fetchSavedSearches() async {
    try {
      isSearchLoading(true);
      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.savedSearches,
      );

      if (response != null && response["success"] == true) {
        final List data = response["data"] ?? [];
        savedSearches.value = data
            .map((item) => SavedSearchModel.fromJson(item))
            .toList();
      }
    } catch (e) {
      errorLog("fetchSavedSearches", e);
    } finally {
      isSearchLoading(false);
    }
  }

  Future<void> removeSearch(int index) async {
    final search = savedSearches[index];
    savedSearches.removeAt(index);

    try {
      final response = await ApiServices.instance.deleteServices(
        url: "${AppApiUrl.instance.savedSearches}/${search.id}",
      );

      if (response == null || response["success"] != true) {
        savedSearches.insert(index, search);
      }
    } catch (e) {
      errorLog("removeSearch", e);
      savedSearches.insert(index, search);
    }
  }

  void toggleAlert(int index) {
    final item = savedSearches[index];
    savedSearches[index] = SavedSearchModel(
      id: item.id,
      location: item.location,
      type: item.type,
      beds: item.beds,
      priceRange: item.priceRange,
      newCount: item.newCount,
      alertsOn: !item.alertsOn,
    );
  }

  void viewResults(SavedSearchModel search) {
    Get.toNamed(AppRoutes.propertyListScreen);
  }
}

// ─────────────────────────────────────────────────────
class SavedSearchModel {
  final String id;
  final String location;
  final String type;
  final String beds;
  final String priceRange;
  final int newCount;
  final bool alertsOn;

  SavedSearchModel({
    required this.id,
    required this.location,
    required this.type,
    required this.beds,
    required this.priceRange,
    required this.newCount,
    required this.alertsOn,
  });

  factory SavedSearchModel.fromJson(Map<String, dynamic> json) {
    final addr = json["location"]?["address"] ?? "";
    final city = json["city"] ?? "";
    final location = addr.isNotEmpty ? addr : city;

    final listingType = json["listingType"] ?? "SALE";
    final type = listingType == "RENT" ? "For Rent" : "For Sale";

    final bedrooms = json["propertyBedrooms"] ?? 0;
    final beds = "$bedrooms+ beds";

    final price = json["askingPrice"] ?? 0;
    final priceRange = listingType == "RENT" ? "£$price/mo" : "£$price";

    return SavedSearchModel(
      id: json["_id"] ?? "",
      location: location,
      type: type,
      beds: beds,
      priceRange: priceRange,
      newCount: 0,
      alertsOn: false,
    );
  }
}
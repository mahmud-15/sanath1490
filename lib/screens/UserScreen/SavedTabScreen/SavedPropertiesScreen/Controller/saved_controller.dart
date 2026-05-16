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
  void onReady() {
    super.onReady();
    // fetchFavouriteProperties();
  }

  Future<void> fetchFavouriteProperties() async {
    try {
      isLoading(true);
      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.favouriteProperties,
      );

      if (response != null && response["success"] == true) {
        final List data = response["data"] ?? [];
        final baseUrl = AppApiUrl.instance.imgBaseUrl;

        // এটা বসাও ↓
        savedProperties.value = data.map((item) {
          final listing = item["listingId"] as Map<String, dynamic>;
          return PropertyModel.fromJson(listing);
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
    savedProperties.removeAt(index); // optimistic remove

    try {
      final response = await ApiServices.instance.postServices(
        url: AppApiUrl.instance.addFavouriteProperty,
        body: {"listingId": property.id},
        statusCodeStart: 200,
        statusCodeEnd: 299,
      );

      if (response == null || response["success"] != true) {
        savedProperties.insert(index, property); // rollback on failure
      }
    } catch (e) {
      errorLog("removeProperty", e);
      savedProperties.insert(index, property); // rollback on error
    }
  }

  // ─── Saved Searches ───────────────────────────────
  final savedSearches = <SavedSearchModel>[
    SavedSearchModel(
      location: 'London SW',
      type: 'For Sale',
      beds: '2+ beds',
      priceRange: '£500k - £1000k',
      newCount: 5,
      alertsOn: false,
    ),
    SavedSearchModel(
      location: 'Manchester',
      type: 'For Sale',
      beds: '2+ beds',
      priceRange: '£500k - £3000k',
      newCount: 5,
      alertsOn: true,
    ),
  ].obs;

  void removeSearch(int index) => savedSearches.removeAt(index);

  void toggleAlert(int index) {
    final item = savedSearches[index];
    savedSearches[index] = SavedSearchModel(
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

  // ─── Helper ───────────────────────────────────────
  String _formatDate(String isoDate) {
    try {
      final dt = DateTime.parse(isoDate);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      return "$day/${month}/${dt.year}";
    } catch (_) {
      return "";
    }
  }

  void onResumed() {
    fetchFavouriteProperties();
  }
  @override
  void onInit() {
    super.onInit();
    fetchFavouriteProperties();
  }
}

// ─────────────────────────────────────────────────────
class SavedSearchModel {
  final String location;
  final String type;
  final String beds;
  final String priceRange;
  final int newCount;
  final bool alertsOn;

  SavedSearchModel({
    required this.location,
    required this.type,
    required this.beds,
    required this.priceRange,
    required this.newCount,
    required this.alertsOn,
  });
}
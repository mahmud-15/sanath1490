import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../HomeTabAllScreen/HomeScreen/Controller/home_controller.dart';

class SavedController extends GetxController {
  // ─── Tab index: 0 = Properties, 1 = Searches ─────
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  // ─── Saved Properties ─────────────────────────────
  final savedProperties = <PropertyModel>[
    PropertyModel(
      images: ['assets/images/property_img3.png', 'assets/images/property_img2.png', 'assets/images/property_img.png'],
      price: '£875,000',
      title: '4 bed House',
      address: '42 Morning Lane, London',
      addedDate: '01/03/2026',
      isFeatured: true,
    ),
    PropertyModel(
      images: ['assets/images/property_img2.png', 'assets/images/property_img.png', 'assets/images/property_img2.png'],
      price: '£1,200,000',
      title: '5 bed Villa',
      address: '10 Park Avenue, Manchester',
      addedDate: '02/03/2026',
      isFeatured: false,
    ),
    PropertyModel(
      images: ['assets/images/property_img3.png', 'assets/images/property_img2.png', 'assets/images/property_img.png'],
      price: '£650,000',
      title: '3 bed Apartment',
      address: '8 River Street, Oxford',
      addedDate: '03/03/2026',
      isFeatured: false,
    ),
  ].obs;

  // ─── Remove a saved property by index ─────────────
  void removeProperty(int index) {
    savedProperties.removeAt(index);
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

  // ─── Remove a saved search by index ───────────────
  void removeSearch(int index) {
    savedSearches.removeAt(index);
  }

  // ─── Toggle alert on/off for a saved search ───────
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

  // ─── Navigate to results for a saved search ───────
  void viewResults(SavedSearchModel search) {
    Get.toNamed(AppRoutes.propertyListScreen);
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
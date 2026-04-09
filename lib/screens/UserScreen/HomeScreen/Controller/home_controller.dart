import 'package:get/get.dart';

class HomeController extends GetxController {
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  final searchQuery = ''.obs;

  void onSearchChanged(String value) => searchQuery.value = value;

  final buyProperties = <PropertyModel>[
    PropertyModel(
      images: [
        'assets/images/property_img.png',
        'assets/images/property_img2.png',
        'assets/images/property_img3.png',
      ],
      price: '£875,000',
      title: '4 bed House',
      address: '42 Morning Lane, London',
      addedDate: '01/03/2026',
      isFeatured: true,
    ),
    PropertyModel(
      images: [
        'assets/images/property_img3.png',
        'assets/images/property_img.png',
        'assets/images/property_img2.png',
      ],
      price: '£875,000',
      title: '4 bed House',
      address: '42 Morning Lane, London',
      addedDate: '01/03/2026',
      isFeatured: true,
    ),
  ].obs;

  final rentProperties = <PropertyModel>[
    PropertyModel(
      images: [
        'assets/images/property_img3.png',
        'assets/images/property_img2.png',
      ],
      price: '£2,500/mo',
      title: '3 bed Apartment',
      address: '8 River Street, Oxford',
      addedDate: '03/03/2026',
      isFeatured: true,
    ),
  ].obs;

  List<PropertyModel> get currentProperties =>
      selectedTab.value == 0 ? buyProperties : rentProperties;

  // ─── Popular Locations ───────────────────
  final popularLocations = <LocationModel>[
    LocationModel(imagePath: 'assets/images/location_img1.jpg', name: 'London', count: '12,600+'),
    LocationModel(imagePath: 'assets/images/location_img2.jpg', name: 'Manchester', count: '10,400+'),
    LocationModel(imagePath: 'assets/images/location_img3.jpg', name: 'Oxford', count: '11,400+'),
    LocationModel(imagePath: 'assets/images/location_img4.png', name: 'Leicester', count: '12,400+'),
  ].obs;
}

// ─────────────────────────────────────────
class PropertyModel {
  final List<String> images;
  final String price;
  final String title;
  final String address;
  final String addedDate;
  final bool isFeatured;
  final RxInt currentIndex;

  PropertyModel({
    required this.images,
    required this.price,
    required this.title,
    required this.address,
    required this.addedDate,
    required this.isFeatured,
  }) : currentIndex = 0.obs;
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
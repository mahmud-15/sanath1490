import 'package:get/get.dart';

class DummyListing {
  final String imageUrl;
  final String price;
  final bool isFeatured;
  final String title;
  final String address;
  final String addedOn;
  final int photoCount;

  const DummyListing({
    required this.imageUrl,
    required this.price,
    required this.isFeatured,
    required this.title,
    required this.address,
    required this.addedOn,
    required this.photoCount,
  });
}

class PopularLocationListingsController extends GetxController {
  final locationName = ''.obs;
  final listings = <DummyListing>[].obs;
  final selectedSort = 'Newest First'.obs;

  final sortOptions = ['Newest First', 'Oldest First', 'Price: Low to High', 'Price: High to Low'];

  @override
  void onInit() {
    super.onInit();
    _loadDummyData();
  }

  void _loadDummyData() {
    locationName.value = 'London';
    listings.assignAll([
      const DummyListing(
        imageUrl: '',
        price: '£875,000',
        isFeatured: true,
        title: '4 bed House',
        address: '42 Morning Lane, London',
        addedOn: '01/03/2026',
        photoCount: 3,
      ),
      const DummyListing(
        imageUrl: '',
        price: '£450,000',
        isFeatured: false,
        title: '3 bed Apartment',
        address: '10 Baker Street, London',
        addedOn: '15/03/2026',
        photoCount: 5,
      ),
      const DummyListing(
        imageUrl: '',
        price: '£1,200,000',
        isFeatured: true,
        title: '5 bed Detached',
        address: '8 Chelsea Road, London',
        addedOn: '20/04/2026',
        photoCount: 8,
      ),
    ]);
  }

  void changeSort(String sort) {
    selectedSort.value = sort;
  }
}
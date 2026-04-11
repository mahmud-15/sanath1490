import 'package:get/get.dart';

class EnquiriesController extends GetxController {
  // ─── Enquiry list ─────────────────────────────────
  final enquiries = <EnquiryModel>[
    EnquiryModel(
      imagePath: 'assets/images/property1.png',
      price: '£875,000',
      title: 'Stunning Victorian Terrace',
      address: '42 Morning Lane, London',
      bedrooms: 4,
      bathrooms: 3,
      sizeSqFt: 2400,
    ),
    EnquiryModel(
      imagePath: 'assets/images/property2.png',
      price: '£875,000',
      title: 'Stunning Victorian Terrace',
      address: '42 Morning Lane, London',
      bedrooms: 4,
      bathrooms: 3,
      sizeSqFt: 2400,
    ),
    EnquiryModel(
      imagePath: 'assets/images/property3.png',
      price: '£875,000',
      title: 'Stunning Victorian Terrace',
      address: '42 Morning Lane, London',
      bedrooms: 4,
      bathrooms: 3,
      sizeSqFt: 2400,
    ),
    EnquiryModel(
      imagePath: 'assets/images/property1.png',
      price: '£875,000',
      title: 'Stunning Victorian Terrace',
      address: '42 Morning Lane, London',
      bedrooms: 4,
      bathrooms: 3,
      sizeSqFt: 2400,
    ),
    EnquiryModel(
      imagePath: 'assets/images/property2.png',
      price: '£875,000',
      title: 'Stunning Victorian Terrace',
      address: '42 Morning Lane, London',
      bedrooms: 4,
      bathrooms: 3,
      sizeSqFt: 2400,
    ),
  ].obs;

  // ─── Tap on a card → navigate to details ─────────
  void onCardTap(EnquiryModel item) {
    // TODO: Get.toNamed(AppRoutes.propertyDetails, arguments: item);
  }
}

// ─────────────────────────────────────────────────────
class EnquiryModel {
  final String imagePath;
  final String price;
  final String title;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int sizeSqFt;

  EnquiryModel({
    required this.imagePath,
    required this.price,
    required this.title,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.sizeSqFt,
  });
}
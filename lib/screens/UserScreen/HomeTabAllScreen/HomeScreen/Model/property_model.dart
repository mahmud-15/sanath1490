import 'package:get/get.dart';
import '../../../../../constant/app_api_url.dart';

class PropertyModel {
  final String id;
  final List<String> images;
  final String price;
  final String title;
  final String address;
  final String addedDate;
  final bool isFeatured;
  final String listingType;
  final RxInt currentIndex;

  PropertyModel({
    this.id = "",
    required this.images,
    required this.price,
    required this.title,
    required this.address,
    required this.addedDate,
    required this.isFeatured,
    this.listingType = "SALE",
  }) : currentIndex = 0.obs;

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = AppApiUrl.instance.imgBaseUrl;

    final List<String> photos = (json["photos"] as List? ?? [])
        .map((e) => "$baseUrl$e")
        .toList();

    final price = json["listingType"] == "RENT"
        ? "£${json["askingPrice"]}/mo"
        : "£${json["askingPrice"]}";

    final address = json["location"]?["address"] ?? "";

    final addedDate = _formatDate(json["createdAt"] ?? "");

    return PropertyModel(
      id: json["_id"] ?? "",
      images: photos.isNotEmpty ? photos : ['assets/images/property_img.png'],
      price: price,
      title: json["title"] ?? "",
      address: address,
      addedDate: addedDate,
      isFeatured: json["status"] == "PUBLISHED",
      listingType: json["listingType"] ?? "SALE",
    );
  }
}

String _formatDate(String isoDate) {
  try {
    final dt = DateTime.parse(isoDate);
    final day = dt.day.toString().padLeft(2, '0');
    final month = dt.month.toString().padLeft(2, '0');
    final year = dt.year;
    return "$day/$month/$year";
  } catch (_) {
    return "";
  }
}
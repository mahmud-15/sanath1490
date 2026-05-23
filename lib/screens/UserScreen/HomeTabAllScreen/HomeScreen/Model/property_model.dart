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
  final bool isFavourite;
  final String agentImage;
  final double lat;
  final double lng;

  PropertyModel({
    this.id = "",
    required this.images,
    required this.price,
    required this.title,
    required this.address,
    required this.addedDate,
    required this.isFeatured,
    this.listingType = "SALE",
    this.isFavourite = false,
    this.agentImage = "",
    this.lat = 0.0,
    this.lng = 0.0,
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

    final agent = json["agentId"];
    final agentImage = (agent is Map)
        ? (agent["agencyLogo"] != null && agent["agencyLogo"].toString().isNotEmpty
        ? "$baseUrl${agent["agencyLogo"]}"
        : agent["profileImage"] != null && agent["profileImage"].toString().isNotEmpty
        ? "$baseUrl${agent["profileImage"]}"
        : "")
        : "";

    final coords = json["location"]?["coordinates"];
    final double lat = coords != null && coords.length >= 2
        ? (coords[0] as num).toDouble()
        : 0.0;
    final double lng = coords != null && coords.length >= 2
        ? (coords[1] as num).toDouble()
        : 0.0;

    return PropertyModel(
      id: json["_id"] ?? "",
      images: photos.isNotEmpty ? photos : [''],
      price: price,
      title: json["title"] ?? "",
      address: address,
      addedDate: addedDate,
      // isFeatured: json["isFeatured"] ?? false,
      isFeatured: false,
      listingType: json["listingType"] ?? "SALE",
      agentImage: agentImage,
      lat: lat,
      lng: lng,
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
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
  final String? tourUrl;
  final String? shareUrl;

  //
  final String bedrooms;
  final String bathrooms;
  final String propertyType;
  final String squareFoot;
  final String tenure;

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
    this.tourUrl,
    this.shareUrl,

    //
    this.bedrooms = "",
    this.bathrooms = "",
    this.propertyType = "",
    this.squareFoot = "",
    this.tenure = "",
  }) : currentIndex = 0.obs;

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = AppApiUrl.instance.imgBaseUrl;

    final List<String> photos = (json["photos"] as List? ?? [])
        .map((e) => "$baseUrl$e")
        .toList();

    final rawPrice = (json["askingPrice"] as num?)?.toInt() ?? 0;
    final formattedPrice = '£${rawPrice.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    )}';
    final price = (json["listingType"]?.toString().toUpperCase() == "RENT")
        ? "$formattedPrice pcm"
        : formattedPrice;

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
      isFeatured: json["isFeatured"] ?? false,
      // isFeatured: false,
      listingType: json["listingType"] ?? "SALE",
      agentImage: agentImage,
      lat: lat,
      lng: lng,
      tourUrl: json["threeSixtyTour"]?.toString(),
      //// When real domain link found then implement that line
      // shareUrl: json["webUrl"]?.toString(),
      shareUrl: "https://yourdomain.com/property/${json["_id"] ?? ""}",

      //
      bedrooms: "${json["propertyBedrooms"] ?? ""}",
      bathrooms: "${json["propertyBathrooms"] ?? ""}",
      propertyType: _formatPropertyType(json["propertyType"] ?? ""),
      squareFoot: "${json["propertySquareFoot"] ?? ""} sq ft",
      tenure: _capitalize(json["tenure"] ?? ""),
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
String _formatPropertyType(String type) {
  return type
      .split('_')
      .map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}')
      .join(' ');
}

String _capitalize(String value) {
  if (value.isEmpty) return '';
  return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
}
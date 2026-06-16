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
    this.bedrooms = "",
    this.bathrooms = "",
    this.propertyType = "",
    this.squareFoot = "",
    this.tenure = "",
  }) : currentIndex = 0.obs;

  factory PropertyModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = AppApiUrl.instance.imgBaseUrl.endsWith('/') 
        ? AppApiUrl.instance.imgBaseUrl.substring(0, AppApiUrl.instance.imgBaseUrl.length - 1)
        : AppApiUrl.instance.imgBaseUrl;

    // Fix Property Images URL
    final List<String> photos = (json["photos"] as List? ?? [])
        .map((e) {
          final String path = e.toString().startsWith('/') ? e.toString() : '/$e';
          return "$baseUrl$path";
        }).toList();

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

    // Fix Agent Image URL (Robust Fallback & Double Slash Prevention)
    final agent = json["agentId"] ?? json["agent"];
    String agentImg = "";
    if (agent is Map) {
      String? rawPath = (agent["agencyLogo"] != null && agent["agencyLogo"].toString().isNotEmpty)
          ? agent["agencyLogo"].toString()
          : (agent["profileImage"] != null && agent["profileImage"].toString().isNotEmpty)
              ? agent["profileImage"].toString()
              : null;
      
      if (rawPath != null) {
        final String cleanPath = rawPath.startsWith('/') ? rawPath : '/$rawPath';
        agentImg = "$baseUrl$cleanPath";
      }
    }

    final coords = json["location"]?["coordinates"];
    final double lat = coords != null && coords.length >= 2 ? (coords[0] as num).toDouble() : 0.0;
    final double lng = coords != null && coords.length >= 2 ? (coords[1] as num).toDouble() : 0.0;

    return PropertyModel(
      id: json["_id"] ?? "",
      images: photos.isNotEmpty ? photos : [''],
      price: price,
      title: json["title"] ?? "",
      address: address,
      addedDate: addedDate,
      isFeatured: json["isFeatured"] ?? false,
      listingType: json["listingType"] ?? "SALE",
      agentImage: agentImg,
      lat: lat,
      lng: lng,
      tourUrl: json["threeSixtyTour"]?.toString(),
      shareUrl: (json["shareLink"] != null && !json["shareLink"].toString().contains("undefined"))
          ? json["shareLink"].toString()
          : "http://148.230.126.149:3000/properties/${json["_id"] ?? ""}",
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
    return "${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}";
  } catch (_) {
    return "";
  }
}

String _formatPropertyType(String type) {
  return type.split('_').map((w) => w.isEmpty ? '' : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}').join(' ');
}

String _capitalize(String value) {
  if (value.isEmpty) return '';
  return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
}

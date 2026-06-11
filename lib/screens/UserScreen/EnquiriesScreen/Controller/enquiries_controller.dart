import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../utils/log_print.dart';

class EnquiriesController extends GetxController {
  final enquiries = <EnquiryModel>[].obs;
  final isLoading = false.obs;
  final currentPage = 1.obs;
  final totalPages = 1.obs;
  final hasMore = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchEnquiries();
  }

  Future<void> fetchEnquiries({bool loadMore = false}) async {
    try {
      if (loadMore) {
        if (!hasMore.value) return;
        if (isLoading.value) return;
        currentPage.value++;
      } else {
        currentPage.value = 1;
        hasMore.value = true;
      }

      isLoading(true);

      final response = await ApiServices.instance.getServices(
        AppApiUrl.instance.myEnquiries,
        queryParameters: {
          'page': currentPage.value,
          'limit': 10,
        },
      );


      if (response != null && response["success"] == true) {
        final List data = response["data"] ?? [];
        totalPages.value = response["meta"]?["totalPage"] ?? 1;
        hasMore.value = currentPage.value < totalPages.value;

        final newItems = data
            .map((item) => EnquiryModel.fromJson(item))
            .where((e) => e.title.isNotEmpty && e.price != '£0' && e.price != '£0/mo')
            .toList();


        if (newItems.isEmpty) {
          hasMore.value = false;
        }

        if (loadMore) {
          enquiries.addAll(newItems);
        } else {
          enquiries.value = newItems;
        }
      } else {
        if (!loadMore) enquiries.clear();
        hasMore.value = false;
      }
    } catch (e) {
      errorLog("fetchEnquiries", e);
      if (!loadMore) enquiries.clear();
      hasMore.value = false;
    } finally {
      isLoading(false);
    }
  }

  void onCardTap(EnquiryModel item) {
    Get.toNamed(AppRoutes.enquiryDetails, arguments: item);
  }
}

class EnquiryModel {
  final String id;
  final String imagePath;
  final String price;
  final String title;
  final String address;
  final int bedrooms;
  final int bathrooms;
  final int sizeSqFt;
  final String message;
  final String status;
  final String agentName;
  final String agentEmail;
  final String agentPhone;
  final String enquiredDate;
  final String agentImage;

  EnquiryModel({
    required this.id,
    required this.imagePath,
    required this.price,
    required this.title,
    required this.address,
    required this.bedrooms,
    required this.bathrooms,
    required this.sizeSqFt,
    required this.message,
    required this.status,
    required this.agentName,
    required this.agentEmail,
    required this.agentPhone,
    required this.enquiredDate,
    required this.agentImage,
  });

  factory EnquiryModel.fromJson(Map<String, dynamic> json) {
    final baseUrl = AppApiUrl.instance.imgBaseUrl;

    // Safe listing extract
    final listingRaw = json["listingId"];
    final listing = listingRaw is Map<String, dynamic> ? listingRaw : <String, dynamic>{};

    // Safe agent extract
    final agentRaw = listing["agentId"];
    final user = agentRaw is Map<String, dynamic> ? agentRaw : <String, dynamic>{};

    // Image
    final photos = listing["photos"] as List? ?? [];
    final rawImage = photos.isNotEmpty ? photos.first?.toString() ?? "" : "";
    final imagePath = rawImage.isNotEmpty
        ? (rawImage.startsWith('http') ? rawImage : "$baseUrl$rawImage")
        : "";
    // price
    final rawPrice    = (listing["askingPrice"] as num?)?.toInt() ?? 0;
    final formattedPrice = '£${rawPrice.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (m) => '${m[1]},',
    )}';
    final listingType = (listing["listingType"] ?? "SALE").toString().toUpperCase();
    final price       = listingType == "RENT" ? "$formattedPrice pcm" : formattedPrice;

    // Address
    final addr = listing["location"]?["address"]?.toString() ?? "";
    final postal = listing["postalCode"]?.toString() ?? "";
    final address = postal.isNotEmpty ? "$addr, $postal" : addr;

    // Date
    final createdAt = json["createdAt"]?.toString() ?? "";
    String enquiredDate = "";
    try {
      final dt = DateTime.parse(createdAt);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      enquiredDate = "$day/$month/${dt.year}";
    } catch (_) {}

    // Agent image
    final rawAgentImage = user["profileImage"]?.toString() ?? "";
    final agentImage = rawAgentImage.isNotEmpty
        ? (rawAgentImage.startsWith('http') ? rawAgentImage : "$baseUrl$rawAgentImage")
        : "";

    // Safe int fields
    int safeInt(dynamic val) =>
        val is int ? val : int.tryParse(val?.toString() ?? '') ?? 0;

    return EnquiryModel(
      id: json["_id"]?.toString() ?? "",
      imagePath: imagePath,
      price: price,
      title: listing["title"]?.toString() ?? "",
      address: address,
      bedrooms: safeInt(listing["propertyBedrooms"]),
      bathrooms: safeInt(listing["propertyBathrooms"]),
      sizeSqFt: safeInt(listing["propertySquareFoot"]),
      message: json["message"]?.toString() ?? "",
      status: json["status"]?.toString() ?? "",
      agentName: user["name"]?.toString() ?? "",
      agentEmail: json["email"]?.toString() ?? "",
      agentPhone: json["phone"]?.toString() ?? "",
      enquiredDate: enquiredDate,
      agentImage: agentImage,
    );
  }
}
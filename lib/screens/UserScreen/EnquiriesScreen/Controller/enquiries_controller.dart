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
        currentPage.value++;
      } else {
        currentPage.value = 1;
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
        final meta = response["meta"];
        totalPages.value = meta?["totalPage"] ?? 1;
        hasMore.value = currentPage.value < totalPages.value;

        final newItems = data.map((item) => EnquiryModel.fromJson(item)).toList();

        if (loadMore) {
          enquiries.addAll(newItems);
        } else {
          enquiries.value = newItems;
        }
      }
    } catch (e) {
      errorLog("fetchEnquiries", e);
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
    final listingRaw = json["listingId"];
    final listing = listingRaw is Map<String, dynamic> ? listingRaw : <String, dynamic>{};

    final agentRaw = listing["agentId"];
    final user = agentRaw is Map<String, dynamic> ? agentRaw : <String, dynamic>{};


    final photos = listing["photos"] as List? ?? [];
    final imagePath = photos.isNotEmpty ? "$baseUrl${photos.first}" : "";
    // print("📋 LISTING >>> $listing");
    // print("👤 USER >>> $user");
    // print("🏠 PHOTOS >>> $photos");
    // print("🖼️ IMAGE PATH >>> $imagePath");
    // print("👤 AGENT NAME >>> ${user["name"]}");
    // print("🔑 RAW listingId >>> ${json["listingId"].runtimeType} = ${json["listingId"]}");
    // print("🔑 RAW userId >>> ${json["userId"].runtimeType} = ${json["userId"]}");

    final askingPrice = listing["askingPrice"] ?? 0;
    final listingType = listing["listingType"] ?? "SALE";
    final price = listingType == "RENT" ? "£$askingPrice/mo" : "£$askingPrice";

    final addr = listing["location"]?["address"] ?? "";
    final postal = listing["postalCode"] ?? "";
    final address = postal.isNotEmpty ? "$addr, $postal" : addr;

    final createdAt = json["createdAt"] ?? "";
    String enquiredDate = "";
    try {
      final dt = DateTime.parse(createdAt);
      final day = dt.day.toString().padLeft(2, '0');
      final month = dt.month.toString().padLeft(2, '0');
      enquiredDate = "$day/$month/${dt.year}";
    } catch (_) {}


    return EnquiryModel(
      id: json["_id"] ?? "",
      imagePath: imagePath,
      price: price,
      title: listing["title"] ?? "",
      address: address,
      bedrooms: listing["propertyBedrooms"] ?? 0,
      bathrooms: listing["propertyBathrooms"] ?? 0,
      sizeSqFt: listing["propertySquareFoot"] ?? 0,
      message: json["message"] ?? "",
      status: json["status"] ?? "",
      agentName: user["name"] ?? "",
      agentEmail: json["email"] ?? "",
      agentPhone: json["phone"] ?? "",
      enquiredDate: enquiredDate,
      agentImage: (user["profileImage"] != null && user["profileImage"].toString().isNotEmpty)
          ? "$baseUrl${user["profileImage"]}"
          : "",
    );
  }
}
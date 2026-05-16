import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';
import '../../../../../utils/log_print.dart';
import '../../HomeScreen/Model/property_model.dart';

class PropertyDetailsController extends GetxController {
  final isLoading = false.obs;
  late PropertyModel property;

  final isFavourite = false.obs;
  final isTogglingFavourite = false.obs;

  Future<void> toggleFavourite() async {
    if (isTogglingFavourite.value) return;
    isTogglingFavourite.value = true;
    try {
      final response = await ApiServices.instance.postServices(
        url: AppApiUrl.instance.addFavouriteProperty,
        body: {"listingId": property.id},
        statusCodeStart: 200,
        statusCodeEnd: 299,
      );
      if (response != null && response["success"] == true) {
        isFavourite.value = response["data"]["isFavorite"] ?? !isFavourite.value;
      }
    } catch (e) {
      errorLog("toggleFavourite", e);
    } finally {
      isTogglingFavourite.value = false;
    }
  }


  final images = <String>[].obs;
  final floorPlans = <String>[].obs;
  final currentImageIndex = 0.obs;
  final videoUrls = <String>[].obs;

  void onImageChanged(int index) => currentImageIndex.value = index;

  final isDescriptionExpanded = false.obs;
  final title = ''.obs;
  final price = ''.obs;
  final address = ''.obs;
  final propertyType = ''.obs;
  final brochureUrl = ''.obs;
  final bedrooms = ''.obs;
  final bathrooms = ''.obs;
  final squareFoot = ''.obs;
  final tenure = ''.obs;
  final councilTaxBand = ''.obs;
  final epcLabel = ''.obs;
  final epcScore = ''.obs;
  final listedDate = ''.obs;
  final description = ''.obs;
  final features = <String>[].obs;
  final threeSixtyTour = ''.obs;
  final agentPhone = ''.obs;
  final agentName = ''.obs;
  final agentEmail = ''.obs;
  final agentImage = ''.obs;
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;

  @override
  void onReady() {
    super.onReady();
    _loadFromArguments();
  }

  void _loadFromArguments() {
    try {
      if (Get.arguments != null && Get.arguments is PropertyModel) {
        property = Get.arguments as PropertyModel;
        _mapFromPropertyModel(property);
        _fetchDetails(property.id);
      }
    } catch (e) {
      AppSnackBar.error("Failed to load property details.");
    }
  }

  void _mapFromPropertyModel(PropertyModel p) {
    images.value = p.images;
    price.value = p.price;
    title.value = p.title;
    address.value = p.address;
    listedDate.value = p.addedDate;
  }

  Future<void> _fetchDetails(String id) async {
    try {
      isLoading(true);

      final response = await ApiServices.instance.getServices(
        "${AppApiUrl.instance.listingById}/$id",
      );

      if (response != null && response["data"] != null) {
        final data = response["data"] as Map<String, dynamic>;
        final baseUrl = AppApiUrl.instance.imgBaseUrl;

        images.value = (data["photos"] as List? ?? [])
            .map((e) => "$baseUrl$e")
            .toList();

        videoUrls.value = (data["videos"] as List? ?? [])
            .map((e) => "$baseUrl$e")
            .toList();

        floorPlans.value = (data["floorPlans"] as List? ?? [])
            .map((e) => "$baseUrl$e")
            .toList();

        title.value = data["title"] ?? "";
        description.value = data["description"] ?? "";
        propertyType.value = _formatPropertyType(data["propertyType"] ?? "");
        brochureUrl.value = data["brochure"] != null
            ? "$baseUrl${data["brochure"]}"
            : "";
        bedrooms.value = "${data["propertyBedrooms"] ?? ""}";
        bathrooms.value = "${data["propertyBathrooms"] ?? ""}";
        squareFoot.value = "${data["propertySquareFoot"] ?? ""} sq ft";
        tenure.value = _capitalize(data["tenure"] ?? "");
        councilTaxBand.value = data["councilTaxBand"] ?? "";
        epcLabel.value = data["epcEnergyRating"]?["label"] ?? "";
        epcScore.value = "${data["epcEnergyRating"]?["score"] ?? ""}";
        final tour = data["threeSixtyTour"] ?? "";
        threeSixtyTour.value = tour.isNotEmpty ? "$baseUrl$tour" : "";
        listedDate.value = _formatDate(data["createdAt"] ?? "");


        final agent = data["agentId"];
        if (agent != null) {
          agentName.value = agent["name"] ?? "";
          agentEmail.value = agent["email"] ?? "";
          agentImage.value = agent["profileImage"] != null
              ? "$baseUrl${agent["profileImage"]}"
              : "";
        }

        final coords = data["location"]?["coordinates"];
        if (coords != null && coords.length >= 2) {
          longitude.value = coords[0].toDouble();
          latitude.value = coords[1].toDouble();
        }


        final listingType = data["listingType"] ?? "SALE";
        final askingPrice = data["askingPrice"] ?? 0;
        price.value = listingType == "RENT"
            ? "£$askingPrice/mo"
            : "£$askingPrice";

        features.value = (data["features"] as List? ?? [])
            .map((e) => _formatFeature(e.toString()))
            .toList();

        final addr = data["location"]?["address"] ?? "";
        final postal = data["postalCode"] ?? "";
        address.value = postal.isNotEmpty ? "$addr, $postal" : addr;
        isFavourite.value = data["isFavorite"] ?? false;
      }
    } catch (e) {
      AppSnackBar.error("Failed to fetch property details.");
    } finally {
      isLoading(false);
    }
  }

  // ─── Helpers ──────────────────────────────
  String _formatPropertyType(String type) {
    return type
        .split('_')
        .map(
          (w) => w.isEmpty
              ? ''
              : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  String _capitalize(String value) {
    if (value.isEmpty) return '';
    return '${value[0].toUpperCase()}${value.substring(1).toLowerCase()}';
  }

  String _formatFeature(String feature) {
    return feature
        .split('_')
        .map(
          (w) => w.isEmpty
              ? ''
              : '${w[0].toUpperCase()}${w.substring(1).toLowerCase()}',
        )
        .join(' ');
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

  // ─── Phone Call ───────────────────────────
  Future<void> makePhoneCall() async {
    const String phoneNumber = "(98) 9016714574";
    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);
    try {
      final bool launched = await launchUrl(
        telUri,
        mode: LaunchMode.externalApplication,
      );
      if (!launched) {
        AppSnackBar.error("Could not open dialer. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("Failed to open phone dialer.");
    }
  }
}

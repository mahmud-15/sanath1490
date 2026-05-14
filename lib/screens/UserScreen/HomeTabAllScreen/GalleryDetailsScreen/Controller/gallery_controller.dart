import 'package:get/get.dart';
import '../../PropertyDetailsScreen/Controller/property_details_controller.dart';

class GalleryController extends GetxController {
  final selectedTab = 0.obs;
  final currentViewerIndex = 0.obs;

  void openPhotoViewer(int index) => currentViewerIndex.value = index;
  void onTabChanged(int index) => selectedTab.value = index;

  // Photos
  final photos = <String>[].obs;

  //Videos
  final videos = <VideoModel>[].obs;

  // Floor plan
  final floorPlans = <String>[].obs;
  final floorPlanLabel = 'Floor Plan'.obs;

  @override
  void onReady() {
    super.onReady();
    _loadFromPropertyDetails();
  }

  void _loadFromPropertyDetails() {
    try {
      final detailsController = Get.find<PropertyDetailsController>();

      photos.value = detailsController.images;

      videos.value = detailsController.videoUrls.map((url) => VideoModel(
        url: url,
        thumbnail: detailsController.images.isNotEmpty
            ? detailsController.images.first
            : '',
        title: 'Property Video',
        duration: '',
        quality: 'HD',
      )).toList();

      floorPlans.value = detailsController.floorPlans;
    } catch (_) {}
  }

  void onCall() {}
  void onEmail() {}
}

class VideoModel {
  final String url;
  final String thumbnail;
  final String title;
  final String duration;
  final String quality;

  VideoModel({
    required this.url,
    required this.thumbnail,
    required this.title,
    required this.duration,
    required this.quality,
  });
}
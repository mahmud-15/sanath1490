import 'package:get/get.dart';

class GalleryController extends GetxController {
  final selectedTab = 0.obs;
  final currentViewerIndex = 0.obs;

  void openPhotoViewer(int index) => currentViewerIndex.value = index;
  void onTabChanged(int index) => selectedTab.value = index;

  // ─── Photos ──────────────────────────────
  final photos = [
    'assets/images/property_img.png',
    'assets/images/property_img2.png',
    'assets/images/property_img3.png',
  ];

  // ─── Videos ──────────────────────────────
  final videos = [
    VideoModel(
      thumbnail: 'assets/images/property_img2.png',
      title: 'Property walkthrough',
      duration: '3:24',
      quality: 'HD',
    ),
    VideoModel(
      thumbnail: 'assets/images/property_img.png',
      title: 'Garden tour',
      duration: '1:15',
      quality: 'HD',
    ),
  ];

  // ─── Floorplan ───────────────────────────
  final floorPlanImage = 'assets/images/floor_plan_img.png';
  final floorPlanLabel = 'Ground Floor';

  // ─── Actions ─────────────────────────────
  void onCall() {}
  void onEmail() {}
}

class VideoModel {
  final String thumbnail;
  final String title;
  final String duration;
  final String quality;

  VideoModel({
    required this.thumbnail,
    required this.title,
    required this.duration,
    required this.quality,
  });
}
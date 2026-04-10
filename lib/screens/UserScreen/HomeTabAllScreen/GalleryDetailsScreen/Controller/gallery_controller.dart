import 'package:get/get.dart';

class GalleryController extends GetxController {
  final selectedTab = 0.obs;

  void onTabChanged(int index) => selectedTab.value = index;

  // ─── Photos ──────────────────────────────
  final photos = [
    'assets/images/property_photo1.png',
    'assets/images/property_photo2.png',
    'assets/images/property_photo3.png',
  ];

  // ─── Videos ──────────────────────────────
  final videos = [
    VideoModel(
      thumbnail: 'assets/images/property_photo2.png',
      title: 'Property walkthrough',
      duration: '3:24',
      quality: 'HD',
    ),
    VideoModel(
      thumbnail: 'assets/images/property_photo3.png',
      title: 'Garden tour',
      duration: '1:15',
      quality: 'HD',
    ),
  ];

  // ─── Floorplan ───────────────────────────
  final floorplanImage = 'assets/images/floorplan.png';
  final floorplanLabel = 'Ground Floor';

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
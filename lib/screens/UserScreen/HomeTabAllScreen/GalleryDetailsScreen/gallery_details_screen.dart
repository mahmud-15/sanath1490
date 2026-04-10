import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/gallery_controller.dart';
import 'Widget/photo_viewer_screen.dart';

class GalleryDetailsScreen extends StatelessWidget {
  const GalleryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();

    return Scaffold(
      appBar: GlobalAppBar(title: ConstString.gallery),
      body: SafeArea(
        child: Column(
          children: [
            // ─── Tab Bar ─────────────────────────
            _GalleryTabBar(controller: controller),
            SizedBox(height: 11.h),

            Expanded(
              child: Obx(() {
                switch (controller.selectedTab.value) {
                  case 0:
                    return _PhotosTab(controller: controller);
                  case 1:
                    return _VideosTab(controller: controller);
                  case 2:
                    return _FloorPlanTab(controller: controller);
                  default:
                    return const SizedBox();
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _GalleryTabBar extends StatelessWidget {
  final GalleryController controller;

  const _GalleryTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final tabs = [
      {'label': 'Photos', 'icon': Icons.photo_camera_outlined},
      {'label': 'Videos', 'icon': Icons.videocam_outlined},
      {'label': 'Floorplan', 'icon': Icons.layers_outlined},
    ];

    return Container(
      color: Colors.white,
      child: Obx(
        () => Row(
          children: List.generate(tabs.length, (index) {
            final bool isSelected = controller.selectedTab.value == index;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.onTabChanged(index),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.outLineColor.withAlpha(120),
                        width: 2.h,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        tabs[index]['icon'] as IconData,
                        size: 16.sp,
                        color: isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.bodyColor,
                      ),
                      SizedBox(width: 4.w),
                      CustomText(
                        title: tabs[index]['label'] as String,
                        textColor: isSelected
                            ? ConstColor.primaryColor
                            : ConstColor.bodyColor,
                        textSize: 14.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.w400,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _PhotosTab extends StatelessWidget {
  final GalleryController controller;

  const _PhotosTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.photos.length,
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          controller.openPhotoViewer(index);
          Get.to(() => const PhotoViewerScreen());
        },
        child: AppImage(
          path: controller.photos[index],
          width: double.infinity,
          height: 200.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _VideosTab extends StatelessWidget {
  final GalleryController controller;

  const _VideosTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      itemCount: controller.videos.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final video = controller.videos[index];
        return _VideoCard(video: video);
      },
    );
  }
}

// ─────────────────────────────────────────
class _VideoCard extends StatelessWidget {
  final VideoModel video;

  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(40),
              blurRadius: 10,
              offset: const Offset(0, 4),
              spreadRadius: 1,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                AppImage(
                  path: video.thumbnail,
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),

                // ─── Play Button ──────────────────
                Container(
                  width: 60.w,
                  height: 60.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: ConstColor.primaryColor,
                    size: 42.sp,
                  ),
                ),

                // ─── Duration Badge ───────────────
                Positioned(
                  bottom: 8.h,
                  right: 8.w,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withAlpha(160),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                    child: CustomText(
                      title: video.duration,
                      textColor: Colors.white,
                      textSize: 11.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ),
                ),
              ],
            ),

            // ─── Video Info ───────────────────────
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                children: [
                  Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: ConstColor.primaryColor.withAlpha(30),
                      borderRadius: BorderRadius.circular(4),
                    ),

                    child: Center(
                      child: SvgPicture.asset("assets/icons/play_icon.svg"),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: video.title,
                        textColor: ConstColor.titleColor,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                      CustomText(
                        title: '${video.duration} ● ${video.quality}',
                        textColor: ConstColor.bodyColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _FloorPlanTab extends StatelessWidget {
  final GalleryController controller;

  const _FloorPlanTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => Get.to(
              () => _FloorPlanFullScreen(
                imagePath: controller.floorPlanImage,
                label: controller.floorPlanLabel,
              ),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: ConstColor.outLineColor),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: AppImage(
                path: controller.floorPlanImage,
                width: double.infinity,
                height: 320.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            title: controller.floorPlanLabel,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            textAlign: TextAlign.center,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _FloorPlanFullScreen extends StatelessWidget {
  final String imagePath;
  final String label;

  const _FloorPlanFullScreen({required this.imagePath, required this.label});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ─── Image ───────────────────────────
            Center(
              child: InteractiveViewer(
                child: AppImage(
                  path: imagePath,
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // ─── Back Button ─────────────────────
            Positioned(
              top: 16.h,
              left: 16.w,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(220),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 16.sp,
                  ),
                ),
              ),
            ),

            // ─── Label ───────────────────────────
            Positioned(
              bottom: 24.h,
              left: 0,
              right: 0,
              child: CustomText(
                title: label,
                textColor: Colors.white,
                textSize: 13.sp,
                fontWeight: FontWeight.w400,
                textAlign: TextAlign.center,
                maxLine: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

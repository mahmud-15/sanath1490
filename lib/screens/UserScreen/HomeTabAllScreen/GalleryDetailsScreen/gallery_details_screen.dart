import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';
import 'controller/gallery_controller.dart';

class GalleryDetailsScreen extends StatelessWidget {
  const GalleryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ─── AppBar ──────────────────────────
            _GalleryAppBar(),

            // ─── Tab Bar ─────────────────────────
            _GalleryTabBar(controller: controller),

            // ─── Content ─────────────────────────
            Expanded(
              child: Obx(() {
                switch (controller.selectedTab.value) {
                  case 0:
                    return _PhotosTab(controller: controller);
                  case 1:
                    return _VideosTab(controller: controller);
                  case 2:
                    return _FloorplanTab(controller: controller);
                  default:
                    return const SizedBox();
                }
              }),
            ),

            // ─── Bottom Buttons ───────────────────
            _BottomButtons(controller: controller),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _GalleryAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: ConstColor.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Get.back(),
            child: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 12.w),
          CustomText(
            title: 'Gallery',
            textColor: Colors.white,
            textSize: 18.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
        ],
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
      child: Obx(() => Row(
        children: List.generate(tabs.length, (index) {
          final bool isSelected = controller.selectedTab.value == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => controller.onTabChanged(index),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: isSelected ? ConstColor.primaryColor : Colors.transparent,
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
                      color: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: tabs[index]['label'] as String,
                      textColor: isSelected ? ConstColor.primaryColor : ConstColor.bodyColor,
                      textSize: 13.sp,
                      fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      )),
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
      separatorBuilder: (_, __) => SizedBox(height: 4.h),
      itemBuilder: (context, index) => AppImage(
        path: controller.photos[index],
        width: double.infinity,
        height: 200.h,
        fit: BoxFit.cover,
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
      separatorBuilder: (_, __) => SizedBox(height: 8.h),
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
    return Column(
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
              width: 52.w,
              height: 52.h,
              decoration: BoxDecoration(
                color: Colors.white.withAlpha(220),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.play_arrow_rounded,
                color: ConstColor.primaryColor,
                size: 32.sp,
              ),
            ),

            // ─── Duration Badge ───────────────
            Positioned(
              bottom: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
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
              Icon(Icons.play_circle_outline, color: ConstColor.primaryColor, size: 18.sp),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: video.title,
                    textColor: ConstColor.titleColor,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                  CustomText(
                    title: '${video.duration} • ${video.quality}',
                    textColor: ConstColor.bodyColor,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
class _FloorplanTab extends StatelessWidget {
  final GalleryController controller;

  const _FloorplanTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: ConstColor.outLineColor),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: AppImage(
              path: controller.floorplanImage,
              width: double.infinity,
              height: 320.h,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            title: controller.floorplanLabel,
            textColor: ConstColor.titleColor,
            textSize: 15.sp,
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
class _BottomButtons extends StatelessWidget {
  final GalleryController controller;

  const _BottomButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 8.r,
            offset: Offset(0, -2.h),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              onPressed: controller.onCall,
              color: ConstColor.secondaryColor,
              height: 50,
              top: 0,
              left: 0,
              right: 0,
              icon: Icon(Icons.phone_outlined, color: Colors.white, size: 18.sp),
              child: CustomText(
                title: 'Call',
                textColor: Colors.white,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: CustomElevatedButton(
              onPressed: controller.onEmail,
              isOutLined: true,
              outLineColour: ConstColor.primaryColor,
              borderColor: ConstColor.primaryColor,
              height: 50,
              top: 0,
              left: 0,
              right: 0,
              icon: Icon(Icons.email_outlined, color: ConstColor.primaryColor, size: 18.sp),
              child: CustomText(
                title: 'Email',
                textColor: ConstColor.primaryColor,
                textSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
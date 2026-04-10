import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/text/custom_text.dart';
import '../Controller/gallery_controller.dart';

class PhotoViewerScreen extends StatelessWidget {
  const PhotoViewerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GalleryController>();
    final CarouselSliderController carouselController = CarouselSliderController();

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // ─── Carousel ────────────────────────
            Center(
              child: Obx(() => CarouselSlider.builder(
                carouselController: carouselController,
                itemCount: controller.photos.length,
                options: CarouselOptions(
                  height: double.infinity,
                  viewportFraction: 1.0,
                  initialPage: controller.currentViewerIndex.value,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: false,
                  onPageChanged: (index, _) =>
                  controller.currentViewerIndex.value = index,
                ),
                itemBuilder: (context, index, _) => AppImage(
                  path: controller.photos[index],
                  width: double.infinity,
                  fit: BoxFit.contain,
                ),
              )),
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
                  child: Icon(Icons.arrow_back_ios_new,
                      color: Colors.black, size: 16.sp),
                ),
              ),
            ),

            // ─── Counter + Caption ───────────────
            Positioned(
              bottom: 24.h,
              left: 0,
              right: 0,
              child: Obx(() => Column(
                children: [
                  // ─── Thumbnail Strip ──────────
                  SizedBox(
                    height: 64.h,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      itemCount: controller.photos.length,
                      separatorBuilder: (_, __) => SizedBox(width: 6.w),
                      itemBuilder: (context, index) {
                        final bool isActive =
                            controller.currentViewerIndex.value == index;
                        return GestureDetector(
                          onTap: () {
                            controller.currentViewerIndex.value = index;
                            carouselController.animateToPage(index);
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            width: 72.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(6.r),
                              border: Border.all(
                                color: isActive
                                    ? Colors.white
                                    : Colors.transparent,
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5.r),
                              child: AppImage(
                                path: controller.photos[index],
                                width: 72.w,
                                height: 64.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // ─── Count Label ──────────────
                  CustomText(
                    title:
                    '${controller.currentViewerIndex.value + 1} of ${controller.photos.length} · Front elevation',
                    textColor: Colors.white,
                    textSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ],
              )),
            ),
          ],
        ),
      ),
    );
  }
}
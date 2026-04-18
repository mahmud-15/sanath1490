import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../Controller/add_listing_controller.dart';

class Step2PhotosMedia extends StatelessWidget {
  final AddListingController controller;

  const Step2PhotosMedia({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(() => _UploadSection(
          label: ConstString.brochure,
          required: false,
          iconPath: 'assets/icons/document_icon.svg',
          uploadLabel: ConstString.uploadBrochure,
          specText: ConstString.brochureSpec,
          buttonLabel: ConstString.chooseFile,
          onTap: controller.pickBrochure,
          mediaList: controller.brochurePath.value.isNotEmpty
              ? RxList<String>([controller.brochurePath.value])
              : RxList<String>(),
          isVideo: false,
          isPdf: true,
        )),

        SizedBox(height: 14.h),

        // ─── Property Videos ─────────────────────
        _UploadSection(
          label: ConstString.propertyVideos,
          required: false,
          iconPath: 'assets/icons/play_button.svg',
          uploadLabel: ConstString.uploadVideo,
          specText: ConstString.videoSpec,
          buttonLabel: ConstString.chooseVideos,
          onTap: controller.pickVideos,
          mediaList: controller.videos,
          isVideo: true,
        ),

        SizedBox(height: 14.h),

        // ─── Floor Plan ──────────────────────────
        _UploadSection(
          label: ConstString.floorPlan,
          required: false,
          iconPath: 'assets/icons/upload_floor_plan_icon.svg',
          uploadLabel: ConstString.uploadFloorPlan,
          specText: ConstString.photoSpec,
          buttonLabel: ConstString.choosePhotos,
          onTap: controller.pickFloorPlan,
          mediaList: controller.floorPlans,
          isVideo: false,
        ),

        SizedBox(height: 14.h),

        // ─── Brochure ────────────────────────────
        _UploadSection(
          label: ConstString.brochure,
          required: false,
          iconPath: 'assets/icons/document_icon.svg',
          uploadLabel: ConstString.uploadBrochure,
          specText: ConstString.brochureSpec,
          buttonLabel: ConstString.chooseFile,
          onTap: controller.pickBrochure,
          mediaList: RxList<String>.from(
            controller.brochurePath.value.isNotEmpty
                ? [controller.brochurePath.value]
                : [],
          ),
          isVideo: false,
          isPdf: true,
        ),

        SizedBox(height: 14.h),

        // ─── 360° Tour URL ───────────────────────
        _TourUrlSection(controller: controller),

        SizedBox(height: 16.h),
      ],
    );
  }
}

// ─── Reusable upload section card ─────────────────
class _UploadSection extends StatelessWidget {
  final String label;
  final bool required;
  final String iconPath;
  final String uploadLabel;
  final String specText;
  final String buttonLabel;
  final VoidCallback onTap;
  final RxList<String> mediaList;
  final bool isVideo;
  final bool isPdf;

  const _UploadSection({
    required this.label,
    required this.required,
    required this.iconPath,
    required this.uploadLabel,
    required this.specText,
    required this.buttonLabel,
    required this.onTap,
    required this.mediaList,
    required this.isVideo,
    this.isPdf = false,
  });

  // ─── Open image full screen ───────────────────────
  void _openFullScreen(String path) {
    Get.to(() => _FullScreenImageView(path: path));
  }

  // ─── Open video player ────────────────────────────
  void _openVideoPlayer(String path) {
    Get.to(() => _VideoPlayerView(path: path));
  }

  // ─── Open PDF viewer ─────────────────────────────
  void _openPdfViewer(String path) {
    Get.to(() => _PdfViewer(path: path));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Label ───────────────────────────────
        Row(
          children: [
            CustomText(
              title: label,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
            if (required)
              CustomText(
                title: ' *',
                textColor: Colors.red,
                textSize: 14.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
          ],
        ),
        SizedBox(height: 8.h),

        // ─── Dotted Box Area ─────────────────────
        DottedBorder(
          options: RoundedRectDottedBorderOptions(
            color: ConstColor.iconColor,
            strokeWidth: 2,
            dashPattern: const [10, 5],
            radius: Radius.circular(10.r),
            padding: EdgeInsets.zero,
          ),
          child: Container(
            width: double.infinity,
            height: 160.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Obx(() {
              final hasMedia = mediaList.isNotEmpty;

              if (hasMedia) {
                // ─── Media preview with edit + tap ──
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    // ─── Preview ──────────────────
                    GestureDetector(
                      onTap: () {
                        if (isPdf) {
                          _openPdfViewer(mediaList.first);
                        } else if (isVideo) {
                          _openVideoPlayer(mediaList.first);
                        } else {
                          _openFullScreen(mediaList.first);
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.r),
                        child: isVideo
                            ? Container(
                          color: Colors.black87,
                          child: Center(
                            child: Icon(
                              Icons.play_circle_fill,
                              color: Colors.white,
                              size: 48.sp,
                            ),
                          ),
                        )
                            : isPdf
                            ? Container(
                          color: Colors.grey.shade100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.picture_as_pdf, size: 48.sp, color: Colors.red),
                              SizedBox(height: 8.h),
                              CustomText(
                                title: 'Tap to view PDF',
                                textColor: ConstColor.bodyColor,
                                textSize: 12.sp,
                                fontWeight: FontWeight.w400,
                                maxLine: 1,
                              ),
                            ],
                          ),
                        )
                            : Image.file(
                          File(mediaList.first),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),

                    // ─── Edit pen icon (top right) ─
                    Positioned(
                      top: 8.h,
                      right: 8.w,
                      child: GestureDetector(
                        onTap: onTap, // opens MediaPickerBottomSheet again
                        child: Container(
                          width: 32.w,
                          height: 32.w,
                          decoration: BoxDecoration(
                            color: Colors.black.withAlpha(140),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/pen_icon.svg',
                              width: 16.w,
                              colorFilter: const ColorFilter.mode(
                                Colors.white,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                // ─── Empty upload UI ───────────────
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconPath,
                      width: 20.w,
                      colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      title: uploadLabel,
                      textColor: ConstColor.titleColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      title: specText,
                      textColor: ConstColor.bodyColor,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 2,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    CustomElevatedButton(
                      onPressed: onTap,
                      color: ConstColor.primaryColor,
                      height: 38,
                      width: 140,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: CustomText(
                        title: buttonLabel,
                        textColor: Colors.white,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        maxLine: 1,
                      ),
                    ),
                  ],
                );
              }
            }),
          ),
        ),
      ],
    );
  }
}


// Full screen image viewer
class _FullScreenImageView extends StatelessWidget {
  final String path;

  const _FullScreenImageView({required this.path});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Center(
        child: InteractiveViewer(
          child: Image.file(File(path), fit: BoxFit.contain),
        ),
      ),
    );
  }
}

// Video player view
class _VideoPlayerView extends StatefulWidget {
  final String path;

  const _VideoPlayerView({required this.path});

  @override
  State<_VideoPlayerView> createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<_VideoPlayerView> {
  late VideoPlayerController _videoController;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.file(File(widget.path))
      ..initialize().then((_) {
        setState(() => _isInitialized = true);
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.close, color: Colors.white),
        ),
      ),
      body: Center(
        child: _isInitialized
            ? GestureDetector(
          onTap: () {
            _videoController.value.isPlaying
                ? _videoController.pause()
                : _videoController.play();
            setState(() {});
          },
          child: Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: _videoController.value.aspectRatio,
                child: VideoPlayer(_videoController),
              ),
              if (!_videoController.value.isPlaying)
                Icon(Icons.play_circle_fill, color: Colors.white, size: 60.sp),
            ],
          ),
        )
            : const CircularProgressIndicator(color: ConstColor.primaryColor),
      ),
    );
  }
}

// Full PDF viewer using flutter_pdfview
class _PdfViewer extends StatefulWidget {
  final String path;

  const _PdfViewer({required this.path});

  @override
  State<_PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<_PdfViewer> {
  // ─── Page tracking ────────────────────────────────
  final currentPage = 0.obs;
  final totalPages  = 0.obs;
  final isReady     = false.obs;

  PDFViewController? _pdfController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(Icons.close, color: ConstColor.titleColor),
        ),
        title: CustomText(
          title: 'Brochure',
          textColor: ConstColor.titleColor,
          textSize: 16.sp,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        actions: [
          Obx(() => isReady.value
              ? Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: Center(
              child: CustomText(
                title: '${currentPage.value + 1} / ${totalPages.value}',
                textColor: ConstColor.bodyColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
            ),
          )
              : const SizedBox.shrink()),
        ],
      ),

      body: Stack(
        children: [
          PDFView(
            filePath: widget.path,
            enableSwipe: true,
            swipeHorizontal: false,
            autoSpacing: true,
            pageFling: true,
            onRender: (pages) {
              totalPages.value = pages ?? 0;
              isReady.value = true;
            },
            onViewCreated: (controller) {
              _pdfController = controller;
            },
            onPageChanged: (page, total) {
              currentPage.value = page ?? 0;
              totalPages.value  = total ?? 0;
            },
            onError: (error) {
              Get.snackbar(
                'Error',
                'Could not load PDF',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
          ),

          Obx(() => !isReady.value
              ?  Center(child: CircularProgressIndicator(color: ConstColor.primaryColor))
              : const SizedBox.shrink()),
        ],
      ),

      bottomNavigationBar: Obx(() => isReady.value
          ? Container(
        padding: EdgeInsets.fromLTRB(16.w, 8.h, 16.w, 24.h),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // ─── Previous ───────────────────
            GestureDetector(
              onTap: () {
                if (currentPage.value > 0) {
                  _pdfController?.setPage(currentPage.value - 1);
                }
              },
              child: Opacity(
                opacity: currentPage.value > 0 ? 1.0 : 0.3,
                child: Row(
                  children: [
                    Icon(Icons.chevron_left, size: 20.sp, color: ConstColor.primaryColor),
                    CustomText(
                      title: 'Previous',
                      textColor: ConstColor.primaryColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),

            CustomText(
              title: 'Page ${currentPage.value + 1} of ${totalPages.value}',
              textColor: ConstColor.bodyColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),

            // ─── Next ────────────────────────
            GestureDetector(
              onTap: () {
                if (currentPage.value < totalPages.value - 1) {
                  _pdfController?.setPage(currentPage.value + 1);
                }
              },
              child: Opacity(
                opacity: currentPage.value < totalPages.value - 1 ? 1.0 : 0.3,
                child: Row(
                  children: [
                    CustomText(
                      title: ConstString.next,
                      textColor: ConstColor.primaryColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                    Icon(Icons.chevron_right, size: 20.sp, color: ConstColor.primaryColor),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
          : const SizedBox.shrink()),
    );
  }
}

// ─── 360 tour URL input ────────────────────────────
class _TourUrlSection extends StatelessWidget {
  final AddListingController controller;

  const _TourUrlSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: ConstString.tourUrl,
          textColor: ConstColor.titleColor,
          textSize: 13.sp,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          textController: controller.tourUrlController,
          hintText: const Text(ConstString.tourUrlHint),
          validator: (_) => null,
          prefixIcon: Padding(
            padding: EdgeInsets.all(12.w),
            child: SvgPicture.asset(
              'assets/icons/url_icon.svg',
              width: 16.w,
              colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
            ),
          ),
        ),
      ],
    );
  }
}
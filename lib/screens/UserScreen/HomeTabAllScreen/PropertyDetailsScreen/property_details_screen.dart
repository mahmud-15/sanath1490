import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/AppLoader/app_loader.dart';
import 'Controller/property_details_controller.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PropertyDetailsController>();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: GlobalAppBar(title: ConstString.propertyDetails),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: AppLoader(message: "Loading your dream property..."),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: [
              _HeroImageSection(controller: controller),
              SizedBox(height: 10.h),
              _GalleryTourTab(),
              SizedBox(height: 10.h),
              _PropertyInfoCard(controller: controller),
              SizedBox(height: 10.h),
              _FloorPlanCard(controller: controller),
              SizedBox(height: 10.h),
              _DescriptionCard(controller: controller),
              SizedBox(height: 10.h),
              _PropertyFeaturesCard(controller: controller),
              SizedBox(height: 10.h),
              Obx(() => controller.brochureUrl.value.isEmpty
                  ? const SizedBox.shrink()
                  : Column(
                children: [
                  _BrochuresCard(controller: controller),
                  SizedBox(height: 10.h),
                ],
              )),
              _CouncilTaxCard(controller: controller),
              SizedBox(height: 10.h),
              _AgentCard(controller: controller),
              SizedBox(height: 10.h),
              _MapCard(controller: controller),
              SizedBox(height: 40.h),
            ],
          ),
        );
      }),
      bottomNavigationBar: _BottomActionBar(),
    );
  }
}

// ─── Hero Image Section ───────────────────────────────
class _HeroImageSection extends StatefulWidget {
  final PropertyDetailsController controller;

  const _HeroImageSection({required this.controller});

  @override
  State<_HeroImageSection> createState() => _HeroImageSectionState();
}

class _HeroImageSectionState extends State<_HeroImageSection> {
  bool _showFallback = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted && widget.controller.images.isEmpty) {
        setState(() => _showFallback = true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Stack(
      children: [
        CarouselSlider.builder(
          itemCount: widget.controller.images.isEmpty ? 1 : widget.controller.images.length,
          itemBuilder: (context, index, realIndex) {
            if (widget.controller.images.isEmpty) {
              return Container(
                width: double.infinity,
                height: 220.h,
                color: Colors.grey.shade200,
                child: Center(
                  child: _showFallback
                      ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.image_not_supported_outlined,
                          size: 48, color: Colors.grey.shade400),
                      SizedBox(height: 8.h),
                      CustomText(
                        title: 'No images available',
                        textColor: ConstColor.bodyColor,
                        textSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ],
                  )
                      : const AppLoader(message: "Preparing image preview...",),
                ),
              );
            }
            return AppImage(
              url: widget.controller.images[index],
              width: double.infinity,
              height: 220.h,
              fit: BoxFit.cover,
            );
          },
          options: CarouselOptions(
            height: 220.h,
            viewportFraction: 1.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, _) => widget.controller.onImageChanged(index),
          ),
        ),

        Positioned(
          top: 12.h,
          left: 12.w,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(140),
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Row(
              children: [
                Icon(Icons.camera_alt_outlined, size: 14.sp, color: Colors.white),
                SizedBox(width: 4.w),
                Obx(() => CustomText(
                  title: '${widget.controller.currentImageIndex.value + 1}/${widget.controller.images.isEmpty ? 1 : widget.controller.images.length}',
                  textColor: Colors.white,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                )),
              ],
            ),
          ),
        ),
      ],
    ));
  }
}

// ─── Gallery / 360 Tour Tab ───────────────────────────
class _GalleryTourTab extends StatelessWidget {
  const _GalleryTourTab();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.galleryDetailsScreen),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: ConstColor.outLineColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/gallery_icon.svg"),
                    SizedBox(width: 6.w),
                    CustomText(
                      title: ConstString.gallery,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.degreeTourScreen),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(color: ConstColor.outLineColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset("assets/icons/degree_icon.svg"),
                    SizedBox(width: 6.w),
                    CustomText(
                      title: ConstString.tourDegree,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Property Info Card ───────────────────────────────
class _PropertyInfoCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _PropertyInfoCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: CustomText(
                    title: controller.price.value,
                    textColor: ConstColor.primaryColor,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
                // SvgPicture.asset(
                //   "assets/icons/upload_icon.svg",
                //   height: 16.h,
                //   width: 16.w,
                // ),
                // SizedBox(width: 18.w),
                Obx(
                  () => GestureDetector(
                    onTap: controller.isTogglingFavourite.value
                        ? null
                        : () => controller.toggleFavourite(),
                    child: SvgPicture.asset(
                      controller.isFavourite.value
                          ? "assets/icons/favourite_click_icon.svg"
                          : "assets/icons/favourite_icon.svg",
                      height: 18.h,
                      width: 18.w,
                      colorFilter: controller.isFavourite.value
                          ? null
                          : ColorFilter.mode(ConstColor.red, BlendMode.srcIn),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),

            CustomText(
              title: controller.title.value,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              maxLine: 2,
            ),
            SizedBox(height: 6.h),

            Row(
              children: [
                SvgPicture.asset(
                  "assets/icons/location_icon.svg",
                  height: 14.h,
                  width: 14.w,
                  colorFilter: ColorFilter.mode(
                    ConstColor.primaryColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  child: CustomText(
                    title: controller.address.value,
                    textColor: ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            Row(
              children: [
                Expanded(
                  child: _SpecItem(
                    label: 'PROPERTY TYPE',
                    icon: "assets/icons/detached_icon.svg",
                    value: controller.propertyType.value,
                  ),
                ),
                Expanded(
                  child: _SpecItem(
                    label: 'BEDROOMS',
                    icon: "assets/icons/bed_room_icon.svg",
                    value: controller.bedrooms.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            Row(
              children: [
                Expanded(
                  child: _SpecItem(
                    label: 'BATHROOMS',
                    icon: "assets/icons/bathrooms_icon.svg",
                    value: controller.bathrooms.value,
                  ),
                ),
                Expanded(
                  child: _SpecItem(
                    label: 'SIZE',
                    icon: "assets/icons/square_fit_icon.svg",
                    value: controller.squareFoot.value,
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),

            _SpecItem(
              label: 'TENURE',
              icon: "assets/icons/upload_icon.svg",
              value: controller.tenure.value,
              showIcon: false,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Spec Item ────────────────────────────────────────
class _SpecItem extends StatelessWidget {
  final String label;
  final String icon;
  final String value;
  final bool showIcon;

  const _SpecItem({
    required this.label,
    required this.icon,
    required this.value,
    this.showIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          textColor: ConstColor.bodyColor,
          textSize: 10.sp,
          fontWeight: FontWeight.w400,
          maxLine: 1,
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            if (showIcon) ...[
              SvgPicture.asset(
                icon,
                width: 15.sp,
                height: 15.sp,
                colorFilter: const ColorFilter.mode(
                  ConstColor.titleColor,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
            ],
            CustomText(
              title: value,
              textColor: ConstColor.titleColor,
              textSize: 13.sp,
              fontWeight: FontWeight.w600,
              maxLine: 1,
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Floor Plan Card ──────────────────────────────────
class _FloorPlanCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _FloorPlanCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: ConstString.floorPlan,
                  textColor: ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
              ],
            ),
            SizedBox(height: 12.h),

            Obx(
              () => Container(
                width: double.infinity,
                height: 160.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.r),
                  child: controller.floorPlans.isNotEmpty
                      ? AppImage(
                    url: controller.floorPlans.first,
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  )
                      : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.layers_outlined, size: 40, color: Colors.grey.shade400),
                      SizedBox(height: 8.h),
                      CustomText(
                        title: 'Floor plan not available',
                        textColor: ConstColor.bodyColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Description Card ─────────────────────────────────
class _DescriptionCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _DescriptionCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.description.value.isEmpty) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        constraints: BoxConstraints(minHeight: 80.h),
        // ← add
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.description,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
            SizedBox(height: 10.h),

            LayoutBuilder(
              builder: (context, constraints) {
                final textSpan = TextSpan(
                  text: controller.description.value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    height: 1.6,
                    fontFamily: 'Roboto',
                  ),
                );
                final tp = TextPainter(
                  text: textSpan,
                  maxLines: 4,
                  textDirection: TextDirection.ltr,
                );
                tp.layout(maxWidth: constraints.maxWidth);
                final isOverflow = tp.didExceedMaxLines;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: controller.description.value,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: controller.isDescriptionExpanded.value ? 100 : 4,
                      textHeight: 1.6,
                    ),

                    if (isOverflow) ...[
                      SizedBox(height: 10.h),
                      GestureDetector(
                        onTap: () => controller.isDescriptionExpanded.value =
                            !controller.isDescriptionExpanded.value,
                        child: CustomText(
                          title: controller.isDescriptionExpanded.value
                              ? "View less"
                              : ConstString.viewFullDescription,
                          textColor: ConstColor.secondaryColor,
                          textSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          maxLine: 1,
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      );
    });
  }
}

// ─── Property Features Card ───────────────────────────
class _PropertyFeaturesCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _PropertyFeaturesCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final features = controller.features;
      final left = features.where((f) => features.indexOf(f).isEven).toList();
      final right = features.where((f) => features.indexOf(f).isOdd).toList();

      return Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              title: ConstString.propertyFeatures,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w700,
              maxLine: 1,
            ),
            SizedBox(height: 12.h),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: left.map((f) => _FeatureBullet(text: f)).toList(),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: right
                        .map((f) => _FeatureBullet(text: f))
                        .toList(),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}

// ─── Feature Bullet ───────────────────────────────────
class _FeatureBullet extends StatelessWidget {
  final String text;

  const _FeatureBullet({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Container(
              width: 6.w,
              height: 6.w,
              decoration: const BoxDecoration(
                color: ConstColor.primaryColor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: CustomText(
              title: text,
              textColor: ConstColor.titleColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 2,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Brochures Card ───────────────────────────────────
class _BrochuresCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _BrochuresCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.outLineColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: ConstString.brochures,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: ConstString.exploreTheBrochure,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 3,
          ),
          SizedBox(height: 14.h),

          Obx(
            () => CustomElevatedButton(
              onPressed: controller.brochureUrl.value.isNotEmpty
                  ? () => Get.to(
                    () => _BrochureFullScreen(url: controller.brochureUrl.value),
              )
                  : () {},
              isOutLined: true,
              borderColor: ConstColor.secondaryColor,
              borderWidth: 1.5,
              outLineColour: ConstColor.secondaryColor,
              color: Colors.transparent,
              buttonBorderRadius: 4,
              elevation: 0,
              height: 32.h,
              width: 124.w,
              top: 0,
              left: 0,
              right: 0,
              child: CustomText(
                title: ConstString.viewBrochure,
                textColor: ConstColor.secondaryColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w500,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class _BrochureFullScreen extends StatelessWidget {
  final String url;
  const _BrochureFullScreen({required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: InteractiveViewer(
          minScale: 0.5,
          maxScale: 4.0,
          child: AppImage(
            url: url,
            width: double.infinity,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}

// ─── Council Tax Card ─────────────────────────────────
class _CouncilTaxCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _CouncilTaxCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: _TaxItem(
                    label: 'COUNCIL TAX BAND',
                    value: controller.councilTaxBand.value,
                  ),
                ),
                Expanded(
                  child: _TaxItem(
                    label: 'EPC RATING',
                    value:
                        '${controller.epcLabel.value} (${controller.epcScore.value})',
                  ),
                ),
              ],
            ),
            SizedBox(height: 14.h),
            _TaxItem(label: 'LISTED', value: controller.listedDate.value),
          ],
        ),
      ),
    );
  }
}

// ─── Tax Item ─────────────────────────────────────────
class _TaxItem extends StatelessWidget {
  final String label;
  final String value;

  const _TaxItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: label,
          textColor: ConstColor.bodyColor,
          textSize: 10.sp,
          fontWeight: FontWeight.w500,
          maxLine: 1,
        ),
        SizedBox(height: 4.h),
        CustomText(
          title: value,
          textColor: ConstColor.titleColor,
          textSize: 14.sp,
          fontWeight: FontWeight.w600,
          maxLine: 1,
        ),
      ],
    );
  }
}

// ─── Agent Card ───────────────────────────────────────
class _AgentCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _AgentCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: ConstColor.outLineColor, width: 1),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    title: controller.agentName.value,
                    textColor: ConstColor.titleColor,
                    textSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: controller.agentEmail.value,
                    textColor: ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 2,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),

            ClipRRect(
              borderRadius: BorderRadius.circular(6.r),
              child: controller.agentImage.value.isNotEmpty
                  ? AppImage(
                      url: controller.agentImage.value,
                      width: 48.w,
                      height: 48.h,
                      fit: BoxFit.cover,
                    )
                  : Container(
                      width: 48.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: ConstColor.red,
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                      child: Center(
                        child: CustomText(
                          title: 'AGENT',
                          textColor: Colors.white,
                          textSize: 10.sp,
                          fontWeight: FontWeight.w700,
                          maxLine: 1,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Map Card ─────────────────────────────────────────
class _MapCard extends StatelessWidget {
  final PropertyDetailsController controller;

  const _MapCard({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      height: 180.h,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: ConstColor.outLineColor, width: 1),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: AppImage(
              path: "assets/images/street_map.png",
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: 10.h,
            left: 10.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(30),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: CustomText(
                title: ConstString.approximateLocation,
                textColor: ConstColor.titleColor,
                textSize: 12.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),
            ),
          ),

          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () async {
                final lat = controller.latitude.value;
                final lng = controller.longitude.value;
                final uri = Uri.parse(
                  "https://www.google.com/maps/@?api=1&map_action=pano&viewpoint=$lat,$lng",
                );
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(30),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/password_icon.svg",
                      width: 17.w,
                      height: 16.h,
                      colorFilter: ColorFilter.mode(
                        ConstColor.titleColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: ConstString.streetView,
                      textColor: ConstColor.titleColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Bottom Action Bar ────────────────────────────────
class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 6.h, 16.w, 20.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(0),
          topRight: Radius.circular(0),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomElevatedButton(
              onPressed: () =>
                  Get.find<PropertyDetailsController>().makePhoneCall(),
              color: ConstColor.secondaryColor,
              elevation: 0,
              height: 46,
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/phone_icon.svg"),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: ConstString.call,
                    textColor: Colors.white,
                    textSize: 18.sp,
                    fontWeight: FontWeight.w700,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 12.w),

          Expanded(
            child: CustomElevatedButton(
              onPressed: () => Get.toNamed(AppRoutes.contactAgentScreen),
              color: Colors.white,
              height: 46,
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    "assets/icons/email.svg",
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      ConstColor.primaryColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    title: 'Email',
                    textColor: ConstColor.primaryColor,
                    textSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

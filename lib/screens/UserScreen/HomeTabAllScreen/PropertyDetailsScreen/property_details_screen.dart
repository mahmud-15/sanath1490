import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../HomeScreen/Controller/home_controller.dart';
import 'Controller/property_details_controller.dart';

class PropertyDetailsScreen extends StatelessWidget {
  const PropertyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PropertyModel property = Get.arguments;
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      appBar: GlobalAppBar(title: ConstString.propertyDetails),

      // ─── Body ────────────────────────────────────
      body: SingleChildScrollView(
        child: Column(
          children: [
            _HeroImageSection(),

            SizedBox(height: 10.h),

            // ─── Gallery / 360 Tour Tab ───────────
            _GalleryTourTab(),

            SizedBox(height: 10.h),

            // ─── Price + Info Card ────────────────
            _PropertyInfoCard(property: property),

            SizedBox(height: 10.h),

            // ─── Floor Plan ───────────────────────
            _FloorPlanCard(),

            SizedBox(height: 10.h),

            // ─── Description ──────────────────────
            _DescriptionCard(),

            SizedBox(height: 10.h),

            // ─── Property Features ────────────────
            _PropertyFeaturesCard(),

            SizedBox(height: 10.h),

            // ─── Brochures ────────────────────────
            _BrochuresCard(),

            SizedBox(height: 10.h),

            // ─── Council Tax + EPC + Listed ───────
            _CouncilTaxCard(),

            SizedBox(height: 10.h),

            // ─── Agent Card ───────────────────────
            _AgentCard(),

            SizedBox(height: 10.h),

            // ─── Map Section ──────────────────────
            _MapCard(),
            SizedBox(height: 50.h),
            _BottomActionBar(),
          ],
        ),
      ),

      // ─── Bottom Call / Email Buttons ─────────────
      // bottomNavigationBar: _BottomActionBar(),
    );
  }
}

// ─────────────────────────────────────────────────────
// Hero image with photo count badge
// ─────────────────────────────────────────────────────
class _HeroImageSection extends StatelessWidget {
  // final PropertyModel property;

  const _HeroImageSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage(
          path: "assets/images/property_img3.png",
          width: double.infinity,
          height: 220.h,
          fit: BoxFit.cover,
        ),

        // ─── Photo count badge ───────────────────
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
                Icon(
                  Icons.camera_alt_outlined,
                  size: 14.sp,
                  color: Colors.white,
                ),
                SizedBox(width: 4.w),
                CustomText(
                  title: '1/3',
                  textColor: Colors.white,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  maxLine: 1,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────
// Gallery and 360 Tour tab row
// ─────────────────────────────────────────────────────
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
              onTap: () {
                Get.toNamed(AppRoutes.galleryDetailsScreen);
              },
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
              onTap: () {
                Get.toNamed(AppRoutes.degreeTourScreen);
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: ConstColor.outLineColor,
                  ), // Separate border
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

// ─────────────────────────────────────────────────────
// Price, title, address and property specs card
// ─────────────────────────────────────────────────────
class _PropertyInfoCard extends StatelessWidget {
  final PropertyModel property;

  const _PropertyInfoCard({required this.property});

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
          // ─── Price + Share + Favorite ────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: CustomText(
                  title: property.price,
                  textColor: ConstColor.primaryColor,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  maxLine: 1,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/upload_icon.svg",
                height: 16.h,
                width: 16.w,
              ),
              SizedBox(width: 14.w),
              SvgPicture.asset(
                "assets/icons/favourite_icon.svg",
                height: 14.h,
                width: 16.w,
                colorFilter: ColorFilter.mode(ConstColor.red, BlendMode.srcIn),
              ),
            ],
          ),
          SizedBox(height: 6.h),

          // ─── Title ───────────────────────────────
          CustomText(
            title: property.title,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLine: 2,
          ),
          SizedBox(height: 6.h),

          // ─── Address ──────────────────────────────
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
                  title: property.address,
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // ─── Property Type + Bedrooms ─────────────
          Row(
            children: [
              Expanded(
                child: _SpecItem(
                  label: 'PROPERTY TYPE',
                  icon: "assets/icons/detached_icon.svg",
                  value: 'Detached',
                ),
              ),
              Expanded(
                child: _SpecItem(
                  label: 'BEDROOMS',
                  icon: "assets/icons/bed_room_icon.svg",
                  value: '3',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // ─── Bathrooms + Size ─────────────────────
          Row(
            children: [
              Expanded(
                child: _SpecItem(
                  label: 'BATHROOMS',
                  icon: "assets/icons/bathrooms_icon.svg",
                  value: '2',
                ),
              ),
              Expanded(
                child: _SpecItem(
                  label: 'SIZE',
                  icon: "assets/icons/square_fit_icon.svg",
                  value: '2400 sq ft',
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // ─── Tenure ───────────────────────────────
          _SpecItem(
            label: 'TENURE',
            icon: "assets/icons/upload_icon.svg",
            value: 'Freehold',
            showIcon: false,
          ),
        ],
      ),
    );
  }
}

// ─── Single spec row item ──────────────────────────
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
                colorFilter: const ColorFilter.mode(ConstColor.titleColor, BlendMode.srcIn),
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

class _FloorPlanCard extends StatelessWidget {
  const _FloorPlanCard();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: open full floor plan
      },
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
            // ─── Header ─────────────────────────────
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


                SvgPicture.asset("assets/icons/arrow_indicator.svg",
                  colorFilter: ColorFilter.mode(ConstColor.titleColor, BlendMode.srcIn),
                )
              ],
            ),
            SizedBox(height: 12.h),

            // ─── Floor plan image placeholder ────────
            Container(
              width: double.infinity,
              height: 160.h,
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: AppImage(
                  path: "assets/images/floor_img.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DescriptionCard extends StatelessWidget {
  const _DescriptionCard();

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
            title: ConstString.description,
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w700,
            maxLine: 1,
          ),
          SizedBox(height: 10.h),
          CustomText(
            title:
                'A well-presented and spacious three-bedroom detached home, ideally located on the popular Colombe Road in Ashford. Offering a practical layout and comfortable living space, this property is perfect for...',
            textColor: ConstColor.titleColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 4,
          ),
          SizedBox(height: 10.h),

          // ─── View full description ───────────────
          GestureDetector(
            onTap: () {
              // TODO: expand full description
            },
            child: CustomText(
              title: ConstString.viewFullDescription,
              textColor: ConstColor.secondaryColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Property features card with 2-column bullet list
// ─────────────────────────────────────────────────────
class _PropertyFeaturesCard extends StatelessWidget {
  const _PropertyFeaturesCard();

  static const _features = [
    'Period features',
    'Modern kitchen',
    'Private garden',
    'Close to transport',
    'Original fireplaces',
    'Wood flooring',
    'Double glazing',
    'Recently renovated',
  ];

  @override
  Widget build(BuildContext context) {
    // Split features into two columns
    final left = _features.where((f) => _features.indexOf(f).isEven).toList();
    final right = _features.where((f) => _features.indexOf(f).isOdd).toList();

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
              // ─── Left column ──────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: left.map((f) => _FeatureBullet(text: f)).toList(),
                ),
              ),
              // ─── Right column ─────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: right.map((f) => _FeatureBullet(text: f)).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Single bullet feature item ───────────────────
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

// ─────────────────────────────────────────────────────
// Brochures card
// ─────────────────────────────────────────────────────
class _BrochuresCard extends StatelessWidget {
  const _BrochuresCard();

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
            title:
                ConstString.exploreTheBrochure,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 3,
          ),
          SizedBox(height: 14.h),

          // ─── View brochure outlined button ────────
          CustomElevatedButton(
            onPressed: () {
              // TODO: open brochure PDF
            },
            isOutLined: true,
            borderColor: ConstColor.secondaryColor,
            borderWidth: 1.5,
            outLineColour: ConstColor.secondaryColor,
            color: Colors.transparent,
            buttonBorderRadius: 4,
            elevation: 0,
            height: 35.h,
            width: 124.w,
            top: 0,
            left: 0,
            right: 0,
            child: CustomText(
              title: ConstString.viewBrochure,
              textColor: ConstColor.secondaryColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ),
        ],
      ),
    );
  }
}

class _CouncilTaxCard extends StatelessWidget {
  const _CouncilTaxCard();

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
          // ─── Council Tax + EPC Rating ─────────────
          Row(
            children: [
              Expanded(
                child: _TaxItem(label: 'COUNCIL TAX BAND', value: 'G'),
              ),
              Expanded(
                child: _TaxItem(label: 'CPC RATING', value: 'C'),
              ),
            ],
          ),
          SizedBox(height: 14.h),

          // ─── Listed date ──────────────────────────
          _TaxItem(label: 'LISTED', value: '15 January 2024'),
        ],
      ),
    );
  }
}

// ─── Single tax/label item ─────────────────────────
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


class _AgentCard extends StatelessWidget {
  const _AgentCard();

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
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  title: 'Sarah Mitchell',
                  textColor: ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  maxLine: 1,
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: '6 Station Approach, Ashford, TW15 2QN',
                  textColor: ConstColor.bodyColor,
                  textSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),

          // ─── Agent logo placeholder ───────────────
          Container(
            width: 48.w,
            height: 48.h,
            decoration: BoxDecoration(
              color: ConstColor.red,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Center(
              child: CustomText(
                title: 'LOGO',
                textColor: Colors.white,
                textSize: 10.sp,
                fontWeight: FontWeight.w700,
                maxLine: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _MapCard extends StatelessWidget {
  const _MapCard();

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
          // ─── Map placeholder ──────────────────────
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.grey.shade300,
              child: Center(
                child: AppImage(
                  path: "assets/images/street_map.png",
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // ─── Approximate location label ───────────
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
                ]
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

          // ─── Street view button ───────────────────
          Positioned(
            bottom: 10.h,
            right: 10.w,
            child: GestureDetector(
              onTap: () {
                // TODO: open street view
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
                    SvgPicture.asset("assets/icons/password_icon.svg",
                    width: 17.w,
                    height: 16.h,
                      colorFilter: ColorFilter.mode(ConstColor.titleColor, BlendMode.srcIn),
                    
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

// ─────────────────────────────────────────────────────
// Bottom Call and Email action bar
// ─────────────────────────────────────────────────────
class _BottomActionBar extends StatelessWidget {
  const _BottomActionBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 40.h),
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.r),
          topRight: Radius.circular(0.r),
        ),
      ),
      child: Row(
        children: [
          // ─── Call Button ──────────────────────────
          Expanded(
            child: CustomElevatedButton(
              onPressed: () {
                Get.find<PropertyDetailsController>().makePhoneCall();   // ← এই লাইনটা পরিবর্তন
              },
              color: ConstColor.secondaryColor,
              elevation: 0,
              height: 48,
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

          // ─── Email Button ─────────────────────────
          Expanded(
            child: CustomElevatedButton(
              onPressed: () {
                Get.toNamed(AppRoutes.contactAgentScreen);
              },
              color: Colors.white,
              height: 48,
              top: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset("assets/icons/email.svg",
                  width: 20.w,
                  height: 20.h,
                    colorFilter: ColorFilter.mode(ConstColor.primaryColor, BlendMode.srcIn),
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

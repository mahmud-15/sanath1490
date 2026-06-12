import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../Model/property_model.dart';

class PropertyCard extends StatelessWidget {
  final PropertyModel property;
  final VoidCallback? onTap;

  const PropertyCard({
    super.key,
    required this.property,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // The Card
        GestureDetector(
          onTap: onTap,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAFC),
              borderRadius: BorderRadius.circular(14.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(15),
                  blurRadius: 10.r,
                  offset: Offset(0, 4.h),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Inner Image Slider
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(14.r)),
                      child: CarouselSlider.builder(
                        itemCount: property.images.length,
                        itemBuilder: (context, index, realIndex) {
                          return Hero(
                            tag: 'property_image_${property.id}',
                            child: AppImage(
                              url: property.images[index],
                              width: double.infinity,
                              height: 260.h,
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        options: CarouselOptions(
                          height: 260.h,
                          viewportFraction: 1.0,
                          enableInfiniteScroll: false,
                          onPageChanged: (index, reason) {
                            property.currentIndex.value = index;
                          },
                        ),
                      ),
                    ),

                    // Image Counter
                    Positioned(
                      top: 10.h,
                      left: 10.w,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: ConstColor.primaryColor,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset("assets/icons/camera_icon.svg"),
                            SizedBox(width: 4.w),
                            Obx(() => CustomText(
                              title: '${property.currentIndex.value + 1}/${property.images.length}',
                              textColor: Colors.white,
                              textSize: 11.sp,
                              fontWeight: FontWeight.w500,
                              maxLine: 1,
                            )),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                // Price + Featured
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: Container(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          color: ConstColor.secondaryColor,
                          child: CustomText(
                            title: property.price,
                            textColor: Colors.white,
                            textSize: 36.sp,
                            fontWeight: FontWeight.w700,
                            maxLine: 1,
                          ),
                        ),
                      ),

                      // Featured Badge
                      if (property.isFeatured)
                        Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                          color: ConstColor.primaryColor,
                          child: CustomText(
                            title: 'FEATURED\nPROPERTY',
                            textColor: Colors.white,
                            textSize: 9.sp,
                            fontWeight: FontWeight.w700,
                            textAlign: TextAlign.center,
                            maxLine: 2,
                          ),
                        ),
                    ],
                  ),
                ),

                // Info
                Padding(
                  padding: EdgeInsets.all(12.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  title: property.title,
                                  textColor: ConstColor.titleColor,
                                  textSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  maxLine: 2,
                                ),
                                SizedBox(height: 4.h),
                                CustomText(
                                  title: property.address,
                                  textColor: ConstColor.primaryColor,
                                  textSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  maxLine: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4.r),
                            child: AppImage(
                              url: property.agentImage,
                              width: 80.w,
                              height: 45.h,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 36.h),
                      CustomText(
                        title: 'Added on ${property.addedDate}',
                        textColor: ConstColor.bodyColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
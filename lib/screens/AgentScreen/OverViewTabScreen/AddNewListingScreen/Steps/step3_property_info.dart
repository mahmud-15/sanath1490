import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../Controller/add_listing_controller.dart';

class Step3PropertyInfo extends StatelessWidget {
  final AddListingController controller;

  const Step3PropertyInfo({super.key, required this.controller});

  static const _epcColors = {
    'A': Color(0xFF02C680),
    'B': Color(0xFF18B459),
    'C': Color(0xFF7CCF00),
    'D': Color(0xFFFDC700),
    'E': Color(0xFFFF8904),
    'F': Color(0xFFFF6900),
    'G': Color(0xFFFB2C36),
  };

  static const _epcLabels = {
    'A': '92+', 'B': '81-91', 'C': '69-80',
    'D': '55-68', 'E': '39-54', 'F': '21-38', 'G': '1-20',
  };

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionLabel(title: ConstString.propertyType, required: true),
        SizedBox(height: 8.h),
        Obx(() => GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 3,
          crossAxisSpacing: 8.w,
          mainAxisSpacing: 8.h,
          childAspectRatio: 2.2,
          // ─── UPDATED: Using map with PropertyTypeModel ───
          children: controller.propertyTypes.map((typeModel) {
            final isSelected = controller.propertyType.value == typeModel.title;
            return GestureDetector(
              onTap: () => controller.setPropertyType(typeModel.title),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: isSelected ? ConstColor.primaryColor : Colors.white,
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(
                    color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      typeModel.icon,
                      width: 16.w,
                      colorFilter: ColorFilter.mode(
                        isSelected ? Colors.white : ConstColor.bodyColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 3.h),
                    CustomText(
                      title: typeModel.title,
                      textColor: isSelected ? Colors.white : ConstColor.titleColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),

        // ─── Room & Size ─────────────────────────
        _SectionLabel(title: ConstString.roomSize, required: true),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: _RoomField(
                label: ConstString.beds,
                icon: 'assets/icons/bed_room_icon.svg',
                controller: controller.bedsController,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _RoomField(
                label: ConstString.baths,
                icon: 'assets/icons/bathrooms_icon.svg',
                controller: controller.bathsController,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _RoomField(
                label: ConstString.sqFt,
                icon: 'assets/icons/square_fit_icon.svg',
                controller: controller.sqFtController,
              ),
            ),
          ],
        ),

        SizedBox(height: 16.h),

        // ─── Tenure ──────────────────────────────
        _SectionLabel(title: ConstString.tenure),
        SizedBox(height: 8.h),
        Obx(() => Row(
          children: controller.tenureTypes.map((typeModel) {
            final isSelected = controller.tenureType.value == typeModel.title;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setTenure(typeModel.title),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    right: typeModel.title != controller.tenureTypes.last.title ? 8.w : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? ConstColor.primaryColor : Colors.white,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
                    ),
                  ),
                  child: Column(
                    children: [
                      SvgPicture.asset(
                        typeModel.icon,
                        width: 16.w,
                        colorFilter: ColorFilter.mode(
                          isSelected ? Colors.white : ConstColor.bodyColor,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      CustomText(
                        title: typeModel.title,
                        textColor: isSelected ? Colors.white : ConstColor.titleColor,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        maxLine: 2,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),

        // ─── Council Tax Band ────────────────────
        _SectionLabel(title: ConstString.councilTaxBand),
        SizedBox(height: 8.h),
        Obx(() => Row(
          children: controller.councilBands.map((band) {
            final isSelected = controller.councilBand.value == band;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setCouncilBand(band),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    right: band != controller.councilBands.last ? 4.w : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  decoration: BoxDecoration(
                    color: isSelected ? ConstColor.primaryColor : Colors.white,
                    border: Border.all(
                      color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
                    ),
                  ),
                  child: CustomText(
                    title: band,
                    textColor: isSelected ? Colors.white : ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: FontWeight.w700,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ),
              ),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),

        // ─── EPC Energy Rating ───────────────────
        _SectionLabel(title: ConstString.epcEnergyRating),
        SizedBox(height: 8.h),
        Obx(() => Row(
          children: controller.epcRatings.map((rating) {
            final isSelected = controller.epcRating.value == rating;
            final color = _epcColors[rating] ?? Colors.grey;
            return Expanded(
              child: GestureDetector(
                onTap: () => controller.setEpcRating(rating),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.only(
                    right: rating != controller.epcRatings.last ? 3.w : 0,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  decoration: BoxDecoration(
                    color: color,
                    border: isSelected
                        ? Border.all(color: Color(0xFF33913f), width: 4)
                        : null,
                  ),
                  child: Column(
                    children: [
                      CustomText(
                        title: rating,
                        textColor: Colors.white,
                        textSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                      ),
                      CustomText(
                        title: _epcLabels[rating] ?? '',
                        textColor: Colors.white,
                        textSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        textAlign: TextAlign.center,
                        maxLine: 1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        )),

        SizedBox(height: 16.h),
      ],
    );
  }
}

// ─── Room field with label + icon ──────────────────
class _RoomField extends StatelessWidget {
  final String label;
  final String icon;
  final TextEditingController controller;

  const _RoomField({
    required this.label,
    required this.icon,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 14.w,
              colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
            ),
            SizedBox(width: 4.w),
            CustomText(
              title: label,
              textColor: ConstColor.bodyColor,
              textSize: 11.sp,
              fontWeight: FontWeight.w500,
              maxLine: 1,
            ),
          ],
        ),
        SizedBox(height: 4.h),
        CustomTextFormField(
          textController: controller,
          // hintText: const Text('0'),
          numeric: true,
          validator: (_) => null,
        ),
      ],
    );
  }
}

// ─── Section label ─────────────────────────────────
class _SectionLabel extends StatelessWidget {
  final String title;
  final bool required;

  const _SectionLabel({required this.title, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          title: title,
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
    );
  }
}
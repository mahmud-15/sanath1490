import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/text/custom_text.dart';
import '../../../../../widget/CustomTextFormField/custom_text_form_field.dart';
import '../Controller/add_listing_controller.dart';

class Step1PropertyBasics extends StatelessWidget {
  final AddListingController controller;

  const Step1PropertyBasics({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.step1FormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionLabel(title: ConstString.listingType, required: true),
          SizedBox(height: 8.h),
          Obx(() => Row(
            children: [
              _ListingTypeCard(
                icon: 'assets/icons/for_sale_house_icon.svg',
                title: ConstString.forSale,
                subtitle: ConstString.setAskingPrice,
                isSelected: controller.listingType.value == 'sale',
                onTap: () => controller.setListingType('sale'),
              ),
              SizedBox(width: 10.w),
              _ListingTypeCard(
                icon: 'assets/icons/key_icon.svg',
                title: ConstString.toRent,
                subtitle: ConstString.setMonthlyRent,
                isSelected: controller.listingType.value == 'rent',
                onTap: () => controller.setListingType('rent'),
              ),
            ],
          )),

          SizedBox(height: 16.h),
          _SectionLabel(title: ConstString.propertyTitle, required: true),
          CustomTextFormField(
            textController: controller.titleController,
            hintText: const Text(ConstString.propertyTitleHint),
            onChanged: (_) {},
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomText(
                title: ConstString.propertyTitleHelper,
                textColor: ConstColor.bodyColor,
                textSize: 11.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              ),

              ValueListenableBuilder<TextEditingValue>(
                valueListenable: controller.titleController,
                builder: (context, value, child) {
                  return CustomText(
                    title: '${value.text.length}/100',
                    textColor: ConstColor.bodyColor,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w400,
                    maxLine: 1,
                  );
                },
              ),
              // ─────────────────────────────────────────────────────────────
            ],
          ),

          SizedBox(height: 16.h),

          // ─── Asking Price ────────────────────────
          _SectionLabel(title: ConstString.askingPrice, required: true),
          CustomTextFormField(
            textController: controller.priceController,
            hintText: const Text(ConstString.askingPriceHint),
            numeric: true,
            prefixIcon: Container(
              padding: EdgeInsets.only(left: 16.w),
              alignment: Alignment.centerLeft,
              width: 40.w,
              child: CustomText(
                title: '£',
                textColor: ConstColor.bodyColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // ─── Country ─────────────────────────────
          _SectionLabel(title: ConstString.country, required: true),
          CustomTextFormField(
            textController: controller.countryController,
            hintText: const Text(ConstString.countryHint),
            suffixIcon: Padding(
              padding: EdgeInsets.all(12.w),
              child: SvgPicture.asset(
                'assets/icons/chevron_down_icon.svg',
                width: 16.w,
                colorFilter: const ColorFilter.mode(ConstColor.bodyColor, BlendMode.srcIn),
              ),
            ),
          ),

          // ─── City ────────────────────────────────
          _SectionLabel(title: ConstString.city, required: true),
          CustomTextFormField(
            textController: controller.cityController,
            hintText: const Text(ConstString.cityHint),
          ),

          // ─── Postcode ────────────────────────────
          _SectionLabel(title: ConstString.postcode, required: true),
          CustomTextFormField(
            textController: controller.postcodeController,
            hintText: const Text(ConstString.postcodeHint),
          ),

          // ─── Full Street Address ─────────────────
          _SectionLabel(title: ConstString.fullStreetAddress, required: true),
          CustomTextFormField(
            textController: controller.addressController,
            hintText: const Text(ConstString.fullStreetAddressHint),
          ),

          SizedBox(height: 16.h),

          // ─── Location Preview (map placeholder) ──
          _SectionLabel(title: ConstString.locationPreview, required: true),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: Container(
              width: double.infinity,
              height: 160.h,
              color: Colors.grey.shade300,
              child: Image.asset(
                "assets/images/street_map.png",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}

// ─── Listing type card ─────────────────────────────
class _ListingTypeCard extends StatelessWidget {
  final String icon;
  final String title;
  final String subtitle;
  final bool isSelected;
  final VoidCallback onTap;

  const _ListingTypeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.primaryColor : Colors.white,
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(
              color: isSelected ? ConstColor.primaryColor : ConstColor.outLineColor,
            ),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                icon,
                width: 22.w,
                colorFilter: ColorFilter.mode(
                  isSelected ? Colors.white : ConstColor.bodyColor,
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      title: title,
                      textColor: isSelected ? Colors.white : ConstColor.titleColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    CustomText(
                      title: subtitle,
                      textColor: isSelected ? Colors.white.withAlpha(180) : ConstColor.bodyColor,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Section label with optional required star ─────
class _SectionLabel extends StatelessWidget {
  final String title;
  final bool required;

  const _SectionLabel({required this.title, this.required = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Row(
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
      ),
    );
  }
}
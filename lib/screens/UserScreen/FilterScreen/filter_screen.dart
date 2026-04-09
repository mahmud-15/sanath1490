import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/CustomElevatedButton/custom_elevated_button.dart';
import '../../../../widget/text/custom_text.dart';
import 'Controller/filter_controller.dart';
import 'Widget/added_bottom_sheet.dart';
import 'Widget/price_bottom_sheet.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<FilterController>();

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            GlobalAppBar(
              showBack: false,
              title: ConstString.filter,
              action: SvgPicture.asset(
                'assets/icons/remove_icon.svg',
                width: 24.0,
                height: 24.0,
                colorFilter: ColorFilter.mode(
                  ConstColor.backgroundColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 16.h),
                    _SectionTitle(title: ConstString.location),
                    SizedBox(height: 8.h),
                    _LocationField(controller: controller),
                    SizedBox(height: 18.h),
                    _RadiusSection(controller: controller),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.propertyType),
                    SizedBox(height: 10.h),
                    _PropertyTypeGrid(controller: controller),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.priceRange),
                    SizedBox(height: 10.h),
                    _PriceRangeRow(controller: controller),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.bedrooms),
                    SizedBox(height: 10.h),
                    _OptionSelector(
                      options: controller.bedroomOptions,
                      selected: controller.selectedBedroom,
                      onSelect: controller.selectBedroom,
                    ),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.bathroom),
                    SizedBox(height: 10.h),
                    _OptionSelector(
                      options: controller.bathroomOptions,
                      selected: controller.selectedBathroom,
                      onSelect: controller.selectBathroom,
                    ),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.addedToSite),
                    SizedBox(height: 10.h),
                    AddedToSiteFieldWidget(controller: controller),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.tenure),
                    SizedBox(height: 10.h),
                    _TenureRow(controller: controller),
                    SizedBox(height: 20.h),
                    _SectionTitle(title: ConstString.propertyFeatures),
                    SizedBox(height: 10.h),
                    _FeaturesRow(controller: controller),
                    SizedBox(height: 24.h),
                    _BottomButtons(controller: controller),
                    SizedBox(height: 26.h),
                  ],
                ),
              ),
            ),

            // ─── Bottom Buttons ───────────────────

          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;

  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      textColor: ConstColor.titleColor,
      textSize: 16.sp,
      fontWeight: FontWeight.w600,
      maxLine: 1,
    );
  }
}

// ─────────────────────────────────────────
class _LocationField extends StatelessWidget {
  final FilterController controller;

  const _LocationField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 46.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.outLineColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          SizedBox(width: 12.w),
          SvgPicture.asset(
            'assets/icons/location_icon.svg',
            width: 24.0,
            height: 24.0,
            colorFilter: ColorFilter.mode(
              ConstColor.bodyColor,
              BlendMode.srcIn,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: TextField(
              controller: controller.locationController,
              style: TextStyle(
                fontSize: 13.sp,
                color: ConstColor.bodyColor,
                fontFamily: 'Roboto',
              ),
              decoration: InputDecoration(
                hintText: ConstString.searchLocationOr,
                hintStyle: TextStyle(
                  fontSize: 16.sp,
                  color: ConstColor.iconColor,
                  fontFamily: 'Roboto',
                ),
                border: InputBorder.none,
                isDense: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _RadiusSection extends StatelessWidget {
  final FilterController controller;

  const _RadiusSection({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _SectionTitle(title: ConstString.radius),
            Obx(
              () => CustomText(
                title: '${controller.radius.value.toInt()} miles',
                textColor: ConstColor.primaryColor,
                textSize: 16.sp,
                fontWeight: FontWeight.w600,
                maxLine: 1,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        Obx(
          () => SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: ConstColor.primaryColor,
              inactiveTrackColor: ConstColor.outLineColor,
              thumbColor: ConstColor.primaryColor,
              overlayColor: ConstColor.primaryColor.withAlpha(30),
              trackHeight: 4.h,
              thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8.r),
            ),
            child: Slider(
              value: controller.radius.value,
              min: 1,
              max: 50,
              onChanged: controller.onRadiusChanged,
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────
class _PropertyTypeGrid extends StatelessWidget {
  final FilterController controller;

  const _PropertyTypeGrid({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 10.w,
        runSpacing: 10.h,
        children: controller.propertyTypes.map((type) {
          final bool isSelected = controller.selectedPropertyType.value == type;
          return GestureDetector(
            onTap: () => controller.selectPropertyType(type),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: (MediaQuery.of(context).size.width - 52.w) / 3,
              padding: EdgeInsets.symmetric(vertical: 9.h),
              decoration: BoxDecoration(
                color: isSelected ? ConstColor.primaryColor : Colors.white,
                border: Border.all(
                  color: isSelected
                      ? ConstColor.primaryColor
                      : ConstColor.outLineColor,
                ),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Column(
                children: [
                  SvgPicture.asset(
                    controller.propertyTypeIcons[controller.propertyTypes
                        .indexOf(type)],
                    width: 16.w,
                    height: 18.h,
                    colorFilter: ColorFilter.mode(
                      isSelected ? Colors.white : ConstColor.bodyColor,
                      BlendMode.srcIn,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  CustomText(
                    title: type,
                    textColor: isSelected
                        ? Colors.white
                        : ConstColor.bodyColor,
                    textSize: 12.sp,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    textAlign: TextAlign.center,
                    maxLine: 1,
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _PriceRangeRow extends StatelessWidget {
  final FilterController controller;

  const _PriceRangeRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _PriceField(controller: controller.minPriceController)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: CustomText(
            title: 'To',
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
        ),
        Expanded(child: _PriceField(controller: controller.maxPriceController)),
      ],
    );
  }
}

// ─────────────────────────────────────────


class _PriceField extends StatelessWidget {
  final TextEditingController controller;

  const _PriceField({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ConstColor.outLineColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      alignment: Alignment.centerLeft,
      child: TextField(
        controller: controller,
        readOnly: true,
        onTap: () {
          Get.bottomSheet(
            MinPriceBottomSheetWidget(controller: controller),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        style: TextStyle(
          fontSize: 14.sp,
          color: ConstColor.titleColor,
          fontFamily: 'Roboto',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          isDense: true,
          hintText: "Select Min Price",
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────
class _OptionSelector extends StatelessWidget {
  final List<String> options;
  final RxString selected;
  final Function(String) onSelect;

  const _OptionSelector({
    required this.options,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: options.map((option) {
          final bool isSelected = selected.value == option;
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: GestureDetector(
              onTap: () => onSelect(option),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: isSelected ? ConstColor.primaryColor : Colors.white,
                  border: Border.all(
                    color: isSelected
                        ? ConstColor.primaryColor
                        : ConstColor.outLineColor,
                  ),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: CustomText(
                  title: option,
                  textColor: isSelected ? Colors.white : ConstColor.titleColor,
                  textSize: 14.sp,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  maxLine: 1,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

//─────────────────────────────────────────


class AddedToSiteFieldWidget extends StatelessWidget {
  final FilterController controller;

  const AddedToSiteFieldWidget({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
          () => GestureDetector(
        onTap: () {
          // ─── Open Bottom Sheet on Tap
          Get.bottomSheet(
            AddedToSiteBottomSheetWidget(controller: controller),
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
          );
        },
        child: Container(
          height: 46.h,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: ConstColor.outLineColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ─── Selected Value Text
              CustomText(
                title: controller.selectedAddedToSite.value,
                textColor: ConstColor.titleColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              // ─── Dropdown Icon
              Icon(
                Icons.keyboard_arrow_down,
                color: ConstColor.iconColor,
                size: 20.sp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//─────────────────────────────────────────
class _TenureRow extends StatelessWidget {
  final FilterController controller;

  const _TenureRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          _CheckItem(
            label: 'Freehold',
            value: controller.isFreehold.value,
            onTap: controller.toggleFreehold,
          ),
          SizedBox(width: 16.w),
          _CheckItem(
            label: 'Leasehold',
            value: controller.isLeasehold.value,
            onTap: controller.toggleLeasehold,
          ),
          SizedBox(width: 16.w),
          _CheckItem(
            label: 'Share of Freehold',
            value: controller.isShareOfFreehold.value,
            onTap: controller.toggleShareOfFreehold,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _FeaturesRow extends StatelessWidget {
  final FilterController controller;

  const _FeaturesRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: [
          _CheckItem(
            label: 'Garden',
            value: controller.hasGarden.value,
            onTap: controller.toggleGarden,
          ),
          SizedBox(width: 16.w),
          _CheckItem(
            label: 'Parking',
            value: controller.hasParking.value,
            onTap: controller.toggleParking,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _CheckItem extends StatelessWidget {
  final String label;
  final bool value;
  final VoidCallback onTap;

  const _CheckItem({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 19.w,
            height: 19.h,
            decoration: BoxDecoration(
              color: value ? ConstColor.primaryColor : Colors.white,
              border: Border.all(
                color: value
                    ? ConstColor.primaryColor
                    : ConstColor.outLineColor,
                width: 2.5,
              ),
              borderRadius: BorderRadius.circular(3.r),
            ),
            child: value
                ? Icon(Icons.check, color: Colors.white, size: 14.sp)
                : null,
          ),
          SizedBox(width: 6.w),
          CustomText(
            title: label,
            textColor: ConstColor.titleColor,
            textSize: 13.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _BottomButtons extends StatelessWidget {
  final FilterController controller;

  const _BottomButtons({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomElevatedButton(
            onPressed: controller.onClear,
            color: ConstColor.backgroundColor,
            borderColor: ConstColor.outLineColor,
            borderWidth: 1.5,
            height: 46,
            top: 0,
            left: 0,
            right: 0,
            child: CustomText(
              title: ConstString.clear,
              textColor: ConstColor.titleColor,
              textSize: 16.sp,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: CustomElevatedButton(
            onPressed: controller.onSearch,
            color: ConstColor.secondaryColor,
            height: 46,
            top: 0,
            left: 0,
            right: 0,
            child: CustomText(
              title: ConstString.search,
              textColor: Colors.white,
              textSize: 16.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/AuthAppBar/global_app_bar.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../../widget/AppImage/app_image.dart';
import '../HomeScreen/Widget/property_card.dart';
import 'Controller/property_list_controller.dart';
import 'Widget/sort_bottom_sheet.dart';

class PropertyListScreen extends StatelessWidget {
  const PropertyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PropertyListController());

    return Scaffold(
      backgroundColor: ConstColor.backgroundColor,
      appBar: GlobalAppBar(
        title: ConstString.searchResult,
        action: Row(
          children: [
            GestureDetector(
              onTap: () => Get.toNamed(AppRoutes.filterScreen),
              child: SvgPicture.asset(
                "assets/icons/filter_icon.svg",
                colorFilter: ColorFilter.mode(ConstColor.outLineColor, BlendMode.srcIn),
              ),
            ),
          ],
        ),
      ),

      body: Obx(() => controller.isListView.value
          ? _ListView(controller: controller)
          : _MapView(controller: controller)),

      bottomNavigationBar: _ListMapToggle(controller: controller),
    );
  }
}

// ─── List View ────────────────────────────────────────
class _ListView extends StatelessWidget {
  final PropertyListController controller;

  const _ListView({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 8.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Obx(() => CustomText(
                title: '${controller.properties.length} results',
                textColor: ConstColor.bodyColor,
                textSize: 14.sp,
                fontWeight: FontWeight.w400,
                maxLine: 1,
              )),
              Obx(() => GestureDetector(
                onTap: () {
                  Get.bottomSheet(
                    SortBottomSheetWidget(controller: controller),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );
                },
                child: Row(
                  children: [
                    CustomText(
                      title: controller.selectedSort.value,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                    SizedBox(width: 4.w),
                    Icon(Icons.keyboard_arrow_down, size: 18.sp, color: ConstColor.titleColor),
                  ],
                ),
              )),
            ],
          ),
        ),
        Divider(height: 1.h, color: ConstColor.outLineColor),
        Expanded(
          child: Obx(() {
            if (controller.properties.isEmpty) {
              return Center(
                child: CustomText(
                  title: 'No properties found',
                  textColor: ConstColor.bodyColor,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  maxLine: 1,
                ),
              );
            }
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              itemCount: controller.properties.length,
              separatorBuilder: (_, _) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final property = controller.properties[index];
                return PropertyCard(
                  onTap: () => Get.toNamed(AppRoutes.propertyDetails, arguments: property),
                  property: property,
                );
              },
            );
          }),
        ),
      ],
    );
  }
}

// ─── Map View ─────────────────────────────────────────
class _MapView extends StatefulWidget {
  final PropertyListController controller;

  const _MapView({required this.controller});

  @override
  State<_MapView> createState() => _MapViewState();
}

class _MapViewState extends State<_MapView> {
  GoogleMapController? _mapController;

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final properties = widget.controller.properties;
      final selectedIndex = widget.controller.selectedMapIndex.value;

      // ─── Build markers ─────────────────────
      final markers = properties
          .asMap()
          .entries
          .where((e) => e.value.lat != 0.0 && e.value.lng != 0.0)
          .map((e) {
        final isSelected = e.key == selectedIndex;
        return Marker(
          markerId: MarkerId(e.value.id),
          position: LatLng(e.value.lat, e.value.lng),
          onTap: () => widget.controller.onMapMarkerTap(e.key),
          icon: isSelected
              ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
              : BitmapDescriptor.defaultMarker,
        );
      }).toSet();

      // ─── Initial position ──────────────────
      final initialTarget = properties.isNotEmpty && properties.first.lat != 0.0
          ? LatLng(properties.first.lat, properties.first.lng)
          : const LatLng(51.5074, -0.1278);

      return Stack(
        children: [
          // ─── Google Map ───────────────────────
          GoogleMap(
            onMapCreated: (c) => _mapController = c,
            initialCameraPosition: CameraPosition(
              target: initialTarget,
              zoom: 13,
            ),
            markers: markers,
            onTap: (_) => widget.controller.selectedMapIndex.value = -1,
            zoomControlsEnabled: true,
            myLocationButtonEnabled: false,
            mapToolbarEnabled: false,
            compassEnabled: false,
          ),

          // ─── Selected Property Card ────────────
          if (selectedIndex >= 0 && selectedIndex < properties.length)
            Positioned(
              bottom: 16.h,
              left: 16.w,
              right: 16.w,
              child: _MapPropertyCard(
                property: properties[selectedIndex],
                onClose: () => widget.controller.selectedMapIndex.value = -1,
                onTap: () => Get.toNamed(
                  AppRoutes.propertyDetails,
                  arguments: properties[selectedIndex],
                ),
              ),
            ),
        ],
      );
    });
  }
}

// ─── Map Property Card ────────────────────────────────
class _MapPropertyCard extends StatelessWidget {
  final dynamic property;
  final VoidCallback onClose;
  final VoidCallback onTap;

  const _MapPropertyCard({
    required this.property,
    required this.onClose,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(30),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // ─── Image ──────────────────────────
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
              child: property.images.isNotEmpty && property.images.first.isNotEmpty
                  ? AppImage(
                url: property.images.first,
                width: 100.w,
                height: 100.h,
                fit: BoxFit.cover,
              )
                  : Container(
                width: 100.w,
                height: 100.h,
                color: Colors.grey.shade200,
                child: Icon(Icons.home_outlined, color: Colors.grey.shade400),
              ),
            ),

            // ─── Info ───────────────────────────
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(12.w, 10.h, 8.w, 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: property.price,
                      textColor: ConstColor.primaryColor,
                      textSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 4.h),
                    CustomText(
                      title: property.title,
                      textColor: ConstColor.titleColor,
                      textSize: 13.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 12.sp, color: ConstColor.primaryColor),
                        SizedBox(width: 2.w),
                        Expanded(
                          child: CustomText(
                            title: property.address,
                            textColor: ConstColor.bodyColor,
                            textSize: 11.sp,
                            fontWeight: FontWeight.w400,
                            maxLine: 1,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    CustomText(
                      title: 'Added ${property.addedDate}',
                      textColor: ConstColor.bodyColor,
                      textSize: 10.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),
            ),

            // ─── Close Button ───────────────────
            Padding(
              padding: EdgeInsets.only(right: 8.w, top: 8.h),
              child: Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: onClose,
                  child: Container(
                    width: 22.w,
                    height: 22.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.close, size: 14.sp, color: ConstColor.titleColor),
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

// ─── List Map Toggle ──────────────────────────────────
class _ListMapToggle extends StatelessWidget {
  final PropertyListController controller;

  const _ListMapToggle({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 55.h,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        border: Border(
          top: BorderSide(color: ConstColor.outLineColor, width: 1.h),
        ),
      ),
      child: Obx(() => Padding(
        padding: EdgeInsets.only(bottom: 23.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ToggleItem(
              icon: Icons.list,
              label: ConstString.list,
              isSelected: controller.isListView.value,
              onTap: () => controller.isListView.value = true,
            ),
            Container(
              height: 20.h,
              width: 1.w,
              color: ConstColor.outLineColor,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
            ),
            _ToggleItem(
              icon: Icons.map_outlined,
              label: ConstString.map,
              isSelected: !controller.isListView.value,
              onTap: () => controller.isListView.value = false,
            ),
          ],
        ),
      )),
    );
  }
}

// ─── Toggle Item ──────────────────────────────────────
class _ToggleItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.icon,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected ? ConstColor.secondaryColor : ConstColor.white;

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 18.sp, color: color),
          SizedBox(width: 6.w),
          CustomText(
            title: label,
            textColor: color,
            textSize: 13.sp,
            fontWeight: FontWeight.w600,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
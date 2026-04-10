import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../constant/const_color.dart';
import '../../../../widget/text/custom_text.dart';
import '../../../widget/AuthAppBar/global_app_bar.dart';
import '../HomeTabAllScreen/HomeScreen/Widget/property_card.dart';
import 'Controller/saved_controller.dart';

class SavedPropertiesScreen extends StatelessWidget {
  const SavedPropertiesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SavedController());

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      // ─── AppBar ──────────────────────────────────
      appBar: GlobalAppBar(title: 'Saved', showBack: false),

      body: Column(
        children: [
          SizedBox(height: 12.h),

          // ─── Tab Row ──────────────────────────────
          _TabRow(controller: controller),

          SizedBox(height: 12.h),

          // ─── Tab Content ──────────────────────────
          Expanded(
            child: Obx(() => controller.selectedTab.value == 0
                ? _SavedPropertiesTab(controller: controller)
                : _SavedSearchesTab(controller: controller)),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Tab row — Properties (3) | Searches (2)
// ─────────────────────────────────────────────────────
class _TabRow extends StatelessWidget {
  final SavedController controller;

  const _TabRow({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ConstColor.outLineColor),
      ),
      child: Row(
        children: [
          _TabItem(
            label: 'Properties (${controller.savedProperties.length})',
            isSelected: controller.selectedTab.value == 0,
            onTap: () => controller.onTabChanged(0),
            isLeft: true,
          ),
          _TabItem(
            label: 'Searches (${controller.savedSearches.length})',
            isSelected: controller.selectedTab.value == 1,
            onTap: () => controller.onTabChanged(1),
            isLeft: false,
          ),
        ],
      ),
    ));
  }
}

// ─── Single tab item ──────────────────────────────
class _TabItem extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLeft;

  const _TabItem({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isLeft,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(vertical: 11.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.only(
              topLeft: isLeft ? Radius.circular(9.r) : Radius.zero,
              bottomLeft: isLeft ? Radius.circular(9.r) : Radius.zero,
              topRight: !isLeft ? Radius.circular(9.r) : Radius.zero,
              bottomRight: !isLeft ? Radius.circular(9.r) : Radius.zero,
            ),
          ),
          child: CustomText(
            title: label,
            textColor: isSelected ? Colors.white : ConstColor.bodyColor,
            textSize: 13.sp,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
            textAlign: TextAlign.center,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Tab 1 — Saved Properties list
// ─────────────────────────────────────────────────────
class _SavedPropertiesTab extends StatelessWidget {
  final SavedController controller;

  const _SavedPropertiesTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.savedProperties.isEmpty) {
        return _EmptyState(
          icon: Icons.favorite_border,
          message: 'No saved properties yet',
        );
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        itemCount: controller.savedProperties.length,
        separatorBuilder: (_, __) => SizedBox(height: 16.h),
        itemBuilder: (context, index) {
          final property = controller.savedProperties[index];

          // ─── Wrap PropertyCard in Stack to overlay heart icon ───
          return Stack(
            children: [
              // Existing PropertyCard — zero changes to its design
              PropertyCard(property: property),

              // ─── Heart icon at bottom right ──────────────────────
              Positioned(
                // 12h for the dot indicators height below card + padding
                bottom: 30.h,
                right: 14.w,
                child: GestureDetector(
                  onTap: () => controller.removeProperty(index),
                  child: Container(
                    width: 34.w,
                    height: 34.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(20),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.favorite,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    });
  }
}

// ─────────────────────────────────────────────────────
// Tab 2 — Saved Searches list
// ─────────────────────────────────────────────────────
class _SavedSearchesTab extends StatelessWidget {
  final SavedController controller;

  const _SavedSearchesTab({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.savedSearches.isEmpty) {
        return _EmptyState(
          icon: Icons.search_off,
          message: 'No saved searches yet',
        );
      }

      return ListView.separated(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 4.h),
        itemCount: controller.savedSearches.length,
        separatorBuilder: (_, __) => SizedBox(height: 12.h),
        itemBuilder: (context, index) {
          final search = controller.savedSearches[index];
          return _SavedSearchCard(
            search: search,
            onRemove: () => controller.removeSearch(index),
            onToggleAlert: () => controller.toggleAlert(index),
            onViewResults: () => controller.viewResults(search),
          );
        },
      );
    });
  }
}

// ─────────────────────────────────────────────────────
// Saved search card
// ─────────────────────────────────────────────────────
class _SavedSearchCard extends StatelessWidget {
  final SavedSearchModel search;
  final VoidCallback onRemove;
  final VoidCallback onToggleAlert;
  final VoidCallback onViewResults;

  const _SavedSearchCard({
    required this.search,
    required this.onRemove,
    required this.onToggleAlert,
    required this.onViewResults,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Location + new badge + close ──────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18.sp,
                color: ConstColor.primaryColor,
              ),
              SizedBox(width: 6.w),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      title: search.location,
                      textColor: ConstColor.titleColor,
                      textSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      maxLine: 1,
                    ),
                    SizedBox(height: 2.h),
                    CustomText(
                      title: '${search.type} • ${search.beds}',
                      textColor: ConstColor.bodyColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              // ─── New count badge ──────────────────
              if (search.newCount > 0) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ConstColor.secondaryColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                  child: CustomText(
                    title: '${search.newCount} new',
                    textColor: Colors.white,
                    textSize: 11.sp,
                    fontWeight: FontWeight.w600,
                    maxLine: 1,
                  ),
                ),
                SizedBox(width: 8.w),
              ],

              // ─── Close / Remove button ────────────
              GestureDetector(
                onTap: onRemove,
                child: Icon(
                  Icons.close,
                  size: 18.sp,
                  color: ConstColor.bodyColor,
                ),
              ),
            ],
          ),

          SizedBox(height: 6.h),

          // ─── Price range ───────────────────────────
          Padding(
            padding: EdgeInsets.only(left: 24.w),
            child: CustomText(
              title: search.priceRange,
              textColor: ConstColor.bodyColor,
              textSize: 12.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ),

          SizedBox(height: 10.h),
          Divider(height: 1.h, color: ConstColor.outLineColor),
          SizedBox(height: 10.h),

          // ─── Alerts toggle + View results ──────────
          Row(
            children: [
              // ─── Alert toggle ─────────────────────
              GestureDetector(
                onTap: onToggleAlert,
                child: Row(
                  children: [
                    Icon(
                      search.alertsOn
                          ? Icons.notifications_active_outlined
                          : Icons.notifications_off_outlined,
                      size: 16.sp,
                      color: search.alertsOn
                          ? ConstColor.primaryColor
                          : ConstColor.bodyColor,
                    ),
                    SizedBox(width: 4.w),
                    CustomText(
                      title: search.alertsOn ? 'Alerts on' : 'Alerts off',
                      textColor: search.alertsOn
                          ? ConstColor.primaryColor
                          : ConstColor.bodyColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      maxLine: 1,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // ─── View results ─────────────────────
              GestureDetector(
                onTap: onViewResults,
                child: Row(
                  children: [
                    CustomText(
                      title: 'View results',
                      textColor: ConstColor.primaryColor,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      maxLine: 1,
                    ),
                    SizedBox(width: 4.w),
                    Icon(
                      Icons.arrow_forward,
                      size: 14.sp,
                      color: ConstColor.primaryColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────
// Empty state widget
// ─────────────────────────────────────────────────────
class _EmptyState extends StatelessWidget {
  final IconData icon;
  final String message;

  const _EmptyState({required this.icon, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48.sp, color: ConstColor.outLineColor),
          SizedBox(height: 12.h),
          CustomText(
            title: message,
            textColor: ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: FontWeight.w400,
            maxLine: 1,
          ),
        ],
      ),
    );
  }
}
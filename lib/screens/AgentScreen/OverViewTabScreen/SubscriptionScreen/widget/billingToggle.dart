import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../constant/const_color.dart';
import '../../../../../../widget/text/custom_text.dart';

class BillingToggle extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onToggle;

  const BillingToggle({
    super.key,
    required this.selectedIndex,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: ConstColor.borderColor, width: 1),
      ),
      child: Row(
        children: [
          _ToggleItem(
            title: 'Monthly',
            isSelected: selectedIndex == 0,
            onTap: () => onToggle(0),
          ),
          _ToggleItem(
            title: 'Annual',
            isSelected: selectedIndex == 1,
            onTap: () => onToggle(1),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────
class _ToggleItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.title,
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
          padding: EdgeInsets.symmetric(vertical: 10.h),
          decoration: BoxDecoration(
            color: isSelected ? ConstColor.primaryColor : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: CustomText(
            title: title,
            textColor: isSelected ? Colors.white : ConstColor.bodyColor,
            textSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            maxLine: 1,
          ),
        ),
      ),
    );
  }
}
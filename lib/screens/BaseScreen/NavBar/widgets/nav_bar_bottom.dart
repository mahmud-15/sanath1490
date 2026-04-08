import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../constant/const_color.dart';

class NavBarBottom extends StatelessWidget {
  final Function(int) onTap;
  final List<String> icons;
  final int selectedIndex;

  const NavBarBottom({
    super.key,
    required this.onTap,
    required this.icons,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final bool isUser = icons.length == 3;

    final List<String> labels = isUser
        ? ['Overview', 'Listing', 'Leads', 'Profile']
        : ['Home', 'Saved', 'Enquires', 'Profile'];

    return Container(
      height: 64.h + MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: ConstColor.primaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(30),
            blurRadius: 12.r,
            offset: Offset(0, -3.h),
          ),
        ],
      ),
      child: Row(
        children: List.generate(icons.length, (index) {
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: InkWell(
              onTap: () => onTap(index),
              overlayColor: WidgetStateProperty.all(Colors.transparent),
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      icons[index],
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? ConstColor.secondaryColor
                            : Colors.white.withAlpha(153),
                        BlendMode.srcIn,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      labels.length > index ? labels[index] : '',
                      style: TextStyle(
                        color: isSelected
                            ? ConstColor.secondaryColor
                            : Colors.white.withAlpha(153),
                        fontSize: 12.sp,
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
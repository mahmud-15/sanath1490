import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:panorama_viewer/panorama_viewer.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AppImage/app_image.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';

import '../../../../Widget/text/custom_text.dart';

class DegreeTourScreen extends StatelessWidget {
  const DegreeTourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalAppBar(title: ConstString.tourDegree,),
      body: Stack(
        children: [
          Positioned.fill(
            child: PanoramaViewer(
              minZoom: 0.8,
              maxZoom: 3.0,
              sensitivity: 2.0,
              child: Image.asset(
                "assets/images/property_img3.png",
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            top: 20.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Color(0xFF6F6C6B).withAlpha(200),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: AppImage(
                path: "assets/images/degree_view_.png",
                width: 46.w,
                height: 27.h,
              )
            ),
          ),
        ],
      ),
    );
  }
}

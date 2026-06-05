import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
// import 'package:panorama_viewer/panorama_viewer.dart'; // TODO: Uncomment when publishing
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/constant/const_string.dart';
import 'package:sanath1490_flutter_app/widget/AppImage/app_image.dart';
import 'package:sanath1490_flutter_app/widget/AuthAppBar/global_app_bar.dart';
import 'package:sanath1490_flutter_app/widget/AppLoader/app_loader.dart';
import '../../../../Widget/text/custom_text.dart';
import '../PropertyDetailsScreen/Controller/property_details_controller.dart';

class DegreeTourScreen extends StatefulWidget {
  const DegreeTourScreen({super.key});

  @override
  State<DegreeTourScreen> createState() => _DegreeTourScreenState();
}

class _DegreeTourScreenState extends State<DegreeTourScreen> {
  bool _showNotFound = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) setState(() => _showNotFound = true);
    });
  }

  @override
  Widget build(BuildContext context) {
    String tourUrl = '';
    try {
      tourUrl = Get.find<PropertyDetailsController>().threeSixtyTour.value;
    } catch (_) {}

    return Scaffold(
      appBar: GlobalAppBar(title: ConstString.tourDegree),
      body: tourUrl.isEmpty
          ? _showNotFound
          ? Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.threesixty, size: 64, color: Colors.grey.shade400),
            SizedBox(height: 12.h),
            CustomText(
              title: '360° tour not available',
              textColor: ConstColor.bodyColor,
              textSize: 14.sp,
              fontWeight: FontWeight.w400,
              maxLine: 1,
            ),
          ],
        ),
      )
          : const Center(
        child: AppLoader(message: "Loading 360° view, please wait...",),
      )
          : Stack(
        children: [
          Positioned.fill(
            // TODO: Uncomment PanoramaViewer when publishing
            // child: PanoramaViewer(
            //   minZoom: 0.8,
            //   maxZoom: 3.0,
            //   sensitivity: 2.0,
            //   child: Image.network(
            //     tourUrl,
            //     fit: BoxFit.cover,
            //     errorBuilder: (context, error, stackTrace) => Container(
            //       color: Colors.black,
            //       child: const Center(
            //         child: Icon(Icons.threesixty, size: 64, color: Colors.white54),
            //       ),
            //     ),
            //   ),
            // ),
            child: Container(
              color: Colors.black,
              child: const Center(
                child: Icon(Icons.threesixty, size: 64, color: Colors.white54),
              ),
            ),
          ),

          Positioned(
            top: 20.h,
            left: 16.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: const Color(0xFF6F6C6B).withAlpha(200),
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: AppImage(
                path: "assets/images/degree_view_.png",
                width: 46.w,
                height: 27.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
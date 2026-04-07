
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../constant/const_color.dart';
import '../../../widget/AppImage/app_image.dart';
import 'Controller/splash_screen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SplashScreenController>(
      init: SplashScreenController(),
      builder: (controller) {
        return Scaffold(
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  ConstColor.primaryColor,
                  ConstColor.primaryDeepColor,
                ],
              ),
            ),
            child: Obx(
                  () => Center(
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 2),
                  opacity: controller.animation.value,
                  child: AnimatedScale(
                    scale: controller.animation.value,
                    duration: const Duration(seconds: 2),
                    curve: Curves.easeOutExpo,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.w),
                      child: AppImage(
                        path: "assets/images/app_logo.png",
                        width: 400.w,
                        height: 150.h,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
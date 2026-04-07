import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/constant/const_color.dart';
import 'package:sanath1490_flutter_app/routes/app_routes/app_routes.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../Widget/text/custom_text.dart';
import '../../../constant/const_string.dart';
import '../../../widget/AppImage/app_image.dart';
class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding_one.png",
      "title": ConstString.findYourPerfectHome,
      "desc": ConstString.browseThousandsOfProperties,
    },
    {
      "image": "assets/images/onboarding_two.png",
      "title": ConstString.exploreBeforeYouVisit,
      "desc": ConstString.viewPhotosVideos,
    },
    {
      "image": "assets/images/onboarding_three.png",
      "title": ConstString.contactAgentsEasily,
      "desc": ConstString.callOrEmailAgentsDirectly,
    },
  ];

  void _goToNext() {
    if (_currentIndex == _onboardingData.length - 1) {
      _navigateToLogin();
    } else {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _navigateToLogin() {
    Get.toNamed(AppRoutes.signInScreen);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── PageView ──────────────────────────────────────────
          PageView.builder(
            controller: _controller,
            itemCount: _onboardingData.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  // Background Image
                  AppImage(
                    path: _onboardingData[index]['image'],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),

                  // Gradient Overlay
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.transparent,
                            Colors.black.withAlpha(180),
                            Colors.black,
                          ],
                          stops: const [0.0, 0.40, 0.55, 1.0],
                        ),
                      ),
                    ),
                  ),

                  // Title & Description
                  Positioned(
                    bottom: 140.h,
                    left: 24.w,
                    right: 24.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: _onboardingData[index]['title']!,
                          textColor: Colors.white,
                          textSize: 36.sp,
                          fontWeight: FontWeight.w700,
                          textHeight: 1.2,
                          maxLine: 3,
                        ),
                        SizedBox(height: 13.h),
                        CustomText(
                          title: _onboardingData[index]['desc']!,
                          textColor: Colors.white.withAlpha(204),
                          textSize: 17.sp,
                          fontWeight: FontWeight.w400,
                          maxLine: 4,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // ── Page Indicator ────────────────────────────────────
          Positioned(
            bottom: 323.h,
            left: 24.w,
            child: SmoothPageIndicator(
              controller: _controller,
              count: _onboardingData.length,
              effect: ExpandingDotsEffect(
                activeDotColor: Colors.white,
                dotColor: Colors.white.withAlpha(100),
                dotHeight: 4.h,
                dotWidth: 8.w,
                spacing: 8.w,
              ),
            ),
          ),

          // ── Next Button (Long) + Arrow Circle Button ──────────
          Positioned(
            bottom: 55.h,
            left: 24.w,
            right: 24.w,
            child: _NextButton(
              isLast: _currentIndex == _onboardingData.length - 1,
              onTap: _goToNext,
            ),
          ),

          // ── Skip Button (Top Right) ───────────────────────────
          Positioned(
            top: 52.h,
            right: 20.w,
            child: GestureDetector(
              onTap: _navigateToLogin,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(220),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: CustomText(
                  title: ConstString.skip,
                  textColor: Colors.black,
                  textSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Next Button Widget ─────────────────────────────────────────────────────────
class _NextButton extends StatelessWidget {
  final bool isLast;
  final VoidCallback onTap;

  const _NextButton({required this.isLast, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 56.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(100.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: CustomText(
                  title: isLast ? 'Get Started' : 'Next',
                  textColor: ConstColor.primaryColor,
                  textSize: 18.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            // Arrow Circle
            Padding(
              padding: EdgeInsets.only(right: 6.w),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: const BoxDecoration(
                  color: ConstColor.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/arrow_indicator.svg",
                    width: 6.w,
                    height: 12.h,
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

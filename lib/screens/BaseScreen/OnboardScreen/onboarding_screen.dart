import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../constant/const_string.dart';

class OnboardScreen extends StatefulWidget {
  const OnboardScreen({super.key});

  @override
  State<OnboardScreen> createState() => _OnboardScreenState();
}

class _OnboardScreenState extends State<OnboardScreen> {
  final PageController _controller = PageController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // PageView Section
          PageView.builder(
            controller: _controller,
            itemCount: _onboardingData.length,
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  Positioned.fill(
                    child: Image.asset(
                      _onboardingData[index]['image']!,
                      fit: BoxFit.cover,
                      alignment: Alignment.center,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Center(
                              child: Icon(Icons.error, color: Colors.red)),
                        );
                      },
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withAlpha(150),
                            Colors.black,
                          ],
                          stops: const [0.45, 0.75, 1.0],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 40.h,
                    left: 24.w,
                    right: 24.w,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _onboardingData[index]['title']!,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.sp,
                            fontWeight: FontWeight.bold,
                            height: 1.2,
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Text(
                                _onboardingData[index]['desc']!,
                                style: TextStyle(
                                  color: Colors.white.withAlpha(204),
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.w),
                            // GestureDetector(
                            //   onTap: () {
                            //     if (index == _onboardingData.length - 1) {
                            //       Navigator.pushReplacement(
                            //         context,
                            //         MaterialPageRoute(
                            //           builder: (context) => const RollSelectedScreen(),
                            //         ),
                            //       );
                            //     } else {
                            //       _controller.nextPage(
                            //         duration: const Duration(milliseconds: 300),
                            //         curve: Curves.easeIn,
                            //       );
                            //     }
                            //   },
                            //   child: Container(
                            //     padding: EdgeInsets.all(12.w),
                            //     decoration: const BoxDecoration(
                            //       color: Colors.white,
                            //       shape: BoxShape.circle,
                            //     ),
                            //     child: const Icon(Icons.arrow_forward, color: Colors.black),
                            //   ),
                            // ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),

          // Page Indicator Section
          Positioned(
            bottom: 200.h,
            left: 0,
            right: 0,
            child: Center(
              child: SmoothPageIndicator(
                controller: _controller,
                count: _onboardingData.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.white,
                  dotColor: Colors.grey,
                  dotHeight: 8.h,
                  dotWidth: 8.w,
                  spacing: 8.w,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
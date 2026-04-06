import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../../utils/app_size.dart';
import '../text/custom_text.dart';

class AppSnackBar {
  static error(String parameterValue, {int seconds = 6}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(SnackBar(content:  Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomText(title: "Error!", textColor: Colors.white, textSize: 18, fontWeight: FontWeight.w900),
        const SizedBox(height: 5),
        // const SpaceWidget(spaceHeight: 5),
        CustomText(title: parameterValue, textColor: Colors.white, textAlign: TextAlign.center),
      ],
    )));
    // Get.showSnackbar(
    //   GetSnackBar(
    //     backgroundColor: Colors.grey,
    //     animationDuration: const Duration(seconds: 2),
    //     duration: Duration(seconds: seconds),
    //     isDismissible: true,
    //     onTap: (snack) {
    //       SchedulerBinding.instance.addPostFrameCallback((_) {
    //         Get.closeAllSnackbars();
    //       });
    //     },
    //     messageText: Column(
    //       mainAxisSize: MainAxisSize.min,
    //       mainAxisAlignment: MainAxisAlignment.start,
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         const CustomText(title: "Error!", textColor: Colors.white, textSize: 18, fontWeight: FontWeight.w900),
    //         const SizedBox(height: 5),
    //         // const SpaceWidget(spaceHeight: 5),
    //         CustomText(title: parameterValue, textColor: Colors.white, textAlign: TextAlign.center),
    //       ],
    //     ),
    //     borderRadius: AppSize.width(value: 20),
    //     padding: EdgeInsets.all(AppSize.width(value: 10)),
    //     margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 40.0), vertical: AppSize.width(value: 30)),
    //     snackPosition: SnackPosition.TOP,
    //   ),
    // );
  }

  static success(String parameterValue, {int seconds = 6}) {
    Get.showSnackbar(
      GetSnackBar(
        // backgroundColor: ConstColor.primaryColor,
        animationDuration: const Duration(seconds: 2),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: CustomText(title: parameterValue, textColor: Colors.white, textAlign: TextAlign.center),
        borderRadius: AppSize.width(value: 20.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 40.0), vertical: AppSize.width(value: 30)),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }

  static message(String parameterValue, {Color backgroundColor = Colors.grey, Color color = Colors.white, int seconds = 10}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: backgroundColor,
        animationDuration: const Duration(seconds: 2),
        duration: Duration(seconds: seconds),
        isDismissible: true,
        onTap: (snack) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            Get.closeAllSnackbars();
          });
        },
        messageText: CustomText(title: parameterValue, textColor: color, textSize: 16, textAlign: TextAlign.center, fontWeight: FontWeight.w400),
        borderRadius: AppSize.width(value: 20.0),
        padding: EdgeInsets.all(AppSize.width(value: 10.0)),
        margin: EdgeInsets.symmetric(horizontal: AppSize.width(value: 40.0), vertical: AppSize.width(value: 30)),
        snackPosition: SnackPosition.TOP,
      ),
    );
  }
}

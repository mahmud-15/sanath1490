import 'package:get/get.dart';
import '../../../../routes/app_routes/app_routes.dart';

class SplashScreenController extends GetxController {

  RxDouble animation = 0.0.obs;

  Future<void> onAppInitialDataLoad() async {
    try {
      animation.value = 0;
      await Future.delayed(const Duration(milliseconds: 500));
      animation.value = 1;

      await Future.delayed(const Duration(seconds: 3));

      Get.offAllNamed(AppRoutes.onboardingScreen);

    } catch (e) {
      Get.offAllNamed(AppRoutes.onboardingScreen);
    }
  }

  @override
  void onInit() {
    super.onInit();
    onAppInitialDataLoad();
  }
}
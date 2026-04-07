// =========================================================
// File: lib/views/controller/splash_screen_controller.dart
// Description: Controller handling only animation and simple routing
// =========================================================
import 'package:get/get.dart';
import '../../../../routes/app_routes/app_routes.dart';

class SplashScreenController extends GetxController {

  // --- Reactive Animation State ---
  RxDouble animation = 0.0.obs;

  // --- Animation & Initial Load Logic ---
  Future<void> onAppInitialDataLoad() async {
    try {
      // Start Animation
      animation.value = 0;
      await Future.delayed(const Duration(milliseconds: 500));
      animation.value = 1;

      // Wait for 3 seconds to show the splash screen
      await Future.delayed(const Duration(seconds: 3));

      // --- Simple Routing (Removed Role/Token logic as requested) ---
      Get.offAllNamed(AppRoutes.onboardScreen); // Modify route if needed

    } catch (e) {
      Get.offAllNamed(AppRoutes.onboardScreen);
    }
  }

  // --- Lifecycle Method ---
  @override
  void onInit() {
    super.onInit();
    onAppInitialDataLoad();
  }
}
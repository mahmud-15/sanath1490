import 'package:get/get.dart';
import 'package:sanath1490_flutter_app/Widget/app_snack_bar/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class PropertyDetailsController extends GetxController {

  final RxBool isFavourite = false.obs;

  void toggleFavourite() {
    isFavourite.value = !isFavourite.value;
  }

  // ─── Property images ──────────────────────────────
  final images = <String>[
    'assets/images/property_img3.png',
    'assets/images/property_img2.png',
    'assets/images/property_img.png',
  ].obs;

  final currentImageIndex = 0.obs;

  void onImageChanged(int index) => currentImageIndex.value = index;

  final RxBool isDescriptionExpanded = false.obs;

  Future<void> makePhoneCall() async {
    const String phoneNumber = "(98) 9016714574";

    final Uri telUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      final bool launched = await launchUrl(
        telUri,
        mode: LaunchMode.externalApplication,
      );

      if (!launched) {
        AppSnackBar.error("Could not open dialer. Please try again.");
      }
    } catch (e) {
      AppSnackBar.error("Failed to open phone dialer.");
    }
  }
}
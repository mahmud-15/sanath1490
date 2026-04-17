import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

class PersonalInfoController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController(text: 'Sarah Johnson');
  final emailController = TextEditingController(text: 'sarah.j@email.com');
  final phoneController = TextEditingController(text: '+1 (555) 123-4567');
  final postalController = TextEditingController();

  // Reactive fields
  final avatarPath = 'assets/images/profile_img.jpg'.obs;
  final selectedCountry = ''.obs;

  final ImagePicker _picker = ImagePicker();

  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );

      if (image != null) {
        avatarPath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to pick image from gallery");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );

      if (image != null) {
        avatarPath.value = image.path;
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to capture image from camera");
    }
  }

  void pickCountry() {
    selectedCountry.value = 'United Kingdom';
  }

  void saveChanges() {
    if (formKey.currentState?.validate() ?? false) {
      Get.back();
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    postalController.dispose();
    super.onClose();
  }
}
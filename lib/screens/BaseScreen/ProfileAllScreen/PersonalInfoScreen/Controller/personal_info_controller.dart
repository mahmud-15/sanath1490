import 'dart:io';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../service/UserService/user_service.dart';
import '../../../../../utils/log_print.dart';
import '../../../../../widget/AppLoader/app_loader.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../UserProfileModel/user_profile_model.dart';
import '../../UserRepository/user_repository.dart';

class PersonalInfoController extends GetxController {
  final formKey = GlobalKey<FormState>();

  final nameController   = TextEditingController();
  final emailController  = TextEditingController();
  final phoneController  = TextEditingController();
  final postalController = TextEditingController();

  final avatarPath = Rxn<String>();
  final selectedCountry     = ''.obs;
  final selectedCountryCode = ''.obs;
  final isLoading        = false.obs;
  final isSaving         = false.obs;

  File? _imageFile;

  final _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  // ==================== GET Profile ====================
  Future<void> fetchProfile() async {
    try {
      final cached = UserService.instance.profile.value;
      if (cached != null) {
        _fillFields(cached);
        return;
      }

      isLoading.value = true;
      final profile = await UserRepository.instance.getProfile();
      isLoading.value = false;

      if (profile != null) {
        UserService.instance.updateProfile(profile);
        _fillFields(profile);
      }
    } catch (e) {
      isLoading.value = false;
      errorLog("PersonalInfoController.fetchProfile", e);
      AppSnackBar.error("Failed to load profile. Please try again.");
    }
  }

  // Fill fields from profile ──────────────────
  void _fillFields(UserProfileModel profile) {
    nameController.text   = profile.name   ?? '';
    emailController.text  = profile.email  ?? '';
    phoneController.text  = profile.phone  ?? '';
    postalController.text = profile.postalCode ?? '';
    selectedCountry.value     = profile.country     ?? '';
    selectedCountryCode.value = profile.countryCode ?? '';

    avatarPath.value = profile.profileImage != null
        ? "${AppApiUrl.instance.imgBaseUrl}${profile.profileImage}"
        : 'assets/images/profile_img.jpg';
  }

  // ==================== PATCH Profile ====================
  Future<void> saveChanges() async {
    if (!(formKey.currentState?.validate() ?? false)) return;

    try {
      isSaving.value = true;
      AppLoader.show(message: 'Saving changes...');

      if (_imageFile != null) {
        await UserRepository.instance.updateProfileImage(_imageFile!);
        _imageFile = null;
      }

      final request = UpdateProfileRequestModel(
        name:        nameController.text.trim(),
        phone:       phoneController.text.trim(),
        country:     selectedCountry.value,
        countryCode: selectedCountryCode.value.isNotEmpty
            ? selectedCountryCode.value
            : null,
        postalCode:  postalController.text.trim(),
      );

      final response = await UserRepository.instance.updateProfile(request);

      AppLoader.hide();
      isSaving.value = false;

      if (response != null) {
        UserService.instance.updateProfile(response);
        AppSnackBar.success("Profile updated successfully!");
        await Future.delayed(const Duration(milliseconds: 1500));
        Navigator.of(Get.context!).pop();
      }
    } catch (e) {
      AppLoader.hide();
      isSaving.value = false;
      errorLog("PersonalInfoController.saveChanges", e);
      AppSnackBar.error("Failed to save changes. Please try again.");
    }
  }

  // ==================== Image Picker ====================
  Future<void> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (image != null) {
        _imageFile       = File(image.path);
        avatarPath.value = image.path;
      }
    } catch (e) {
      errorLog("pickImageFromGallery", e);
      AppSnackBar.error("Failed to pick image from gallery.");
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 80,
      );
      if (image != null) {
        _imageFile       = File(image.path);
        avatarPath.value = image.path;
      }
    } catch (e) {
      errorLog("pickImageFromCamera", e);
      AppSnackBar.error("Failed to capture image from camera.");
    }
  }

  // ==================== Country Picker ====================
  void pickCountry(context) {
    showCountryPicker(
      context: context,
      showPhoneCode: false,
      showSearch: true,
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.circular(16),
        inputDecoration: InputDecoration(
          hintText: 'Search country...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      onSelect: (Country country) {
        selectedCountry.value  = country.name;
        selectedCountryCode.value = "+\${country.phoneCode}";
      },
    );
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
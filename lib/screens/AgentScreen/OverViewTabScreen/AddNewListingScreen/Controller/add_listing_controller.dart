import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddListingController extends GetxController {
  final currentStep = 1.obs;
  static const totalSteps = 5;

  void nextStep() {
    if (currentStep.value < totalSteps) currentStep.value++;
  }

  void prevStep() {
    if (currentStep.value > 1) currentStep.value--;
  }

  double get progress => currentStep.value / totalSteps;

  final listingType     = 'sale'.obs;
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final countryController  = TextEditingController();
  final cityController     = TextEditingController();
  final postcodeController = TextEditingController();
  final addressController  = TextEditingController();
  final step1FormKey = GlobalKey<FormState>();

  int get titleCharCount => titleController.text.length;

  void setListingType(String type) => listingType.value = type;

  bool validateStep1() => step1FormKey.currentState?.validate() ?? false;

  ///////////////////STEP 2 — Photos & Media
  final photos    = <String>[].obs;
  final videos    = <String>[].obs;
  final floorPlans = <String>[].obs;
  final tourUrlController = TextEditingController();

  void pickPhotos()    { /* TODO: image_picker */ }
  void pickVideos()    { /* TODO: file_picker  */ }
  void pickFloorPlan() { /* TODO: image_picker */ }
  void pickBrochure()  { /* TODO: file_picker  */ }

  /////////////////STEP 3 — Property Information
  final propertyType = 'Detached'.obs;
  final bedsController  = TextEditingController(text: '3');
  final bathsController = TextEditingController(text: '2');
  final sqFtController  = TextEditingController(text: '1,200');
  final tenureType   = 'Freehold'.obs;
  final councilBand  = 'D'.obs;
  final epcRating    = 'C'.obs;

  final propertyTypes = ['Detached', 'Semi', 'Terraced', 'Bungalow', 'Flat', 'Park Home'];
  final tenureTypes   = ['Freehold', 'Leasehold', 'Share of Freehold'];
  final councilBands  = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H'];
  final epcRatings    = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  void setPropertyType(String type) => propertyType.value = type;
  void setTenure(String type)       => tenureType.value = type;
  void setCouncilBand(String band)  => councilBand.value = band;
  void setEpcRating(String rating)  => epcRating.value = rating;

  ///////////////////STEP 4 — Features & Description
  final allFeatures = [
    'Garden', 'Parking', 'New Build', 'Chain Free',
    'Swimming Pool', 'Gym', 'Concierge', 'Balcony',
    'Terrace', 'Lift', 'Fitted Kitchen', 'Underfloor Heating',
    'Solar Panels', 'Off-Street Parking', 'Driveway', 'Alarm System',
  ];

  final selectedFeatures = <String>{}.obs;
  final descriptionController = TextEditingController();

  void toggleFeature(String feature) {
    if (selectedFeatures.contains(feature)) {
      selectedFeatures.remove(feature);
    } else {
      selectedFeatures.add(feature);
    }
  }

  bool isFeatureSelected(String feature) => selectedFeatures.contains(feature);

  /////////////////// STEP 5 — Review & Publish checklist
  bool get step1Done => titleController.text.isNotEmpty && addressController.text.isNotEmpty;
  bool get step2Done => photos.isNotEmpty;
  bool get step3Done => propertyType.value.isNotEmpty;
  bool get step4Done => descriptionController.text.isNotEmpty;

  int get completedSteps => [step1Done, step2Done, step3Done, step4Done].where((e) => e).length;

  void saveDraft() {
    // TODO: save locally or call draft API
    Get.back();
  }

  void publishProperty() {
    // TODO: call publish API then navigate to success
    currentStep.value = 6;
  }

  @override
  void onClose() {
    titleController.dispose();
    priceController.dispose();
    countryController.dispose();
    cityController.dispose();
    postcodeController.dispose();
    addressController.dispose();
    tourUrlController.dispose();
    bedsController.dispose();
    bathsController.dispose();
    sqFtController.dispose();
    descriptionController.dispose();
    super.onClose();
  }
}
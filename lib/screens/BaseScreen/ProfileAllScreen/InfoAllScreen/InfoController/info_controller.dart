import 'package:get/get.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../InfoRepository/info_repository.dart';

class InfoController extends GetxController {
  final _repo = InfoRepository.instance;

  // ==================== About ====================
  final aboutContent = ''.obs;
  final isAboutLoading = false.obs;

  Future<void> loadAbout() async {
    if (aboutContent.value.isNotEmpty) return;
    try {
      isAboutLoading.value = true;
      final res = await _repo.fetchAbout();
      if (res != null) aboutContent.value = res;
    } catch (e) {
      AppSnackBar.error('Failed to load About Us. Please try again.');
    } finally {
      isAboutLoading.value = false;
    }
  }

  // ==================== Privacy ====================
  final privacyContent = ''.obs;
  final isPrivacyLoading = false.obs;

  Future<void> loadPrivacy() async {
    if (privacyContent.value.isNotEmpty) return;
    try {
      isPrivacyLoading.value = true;
      final res = await _repo.fetchPrivacy();
      if (res != null) privacyContent.value = res;
    } catch (e) {
      AppSnackBar.error('Failed to load Privacy Policy. Please try again.');
    } finally {
      isPrivacyLoading.value = false;
    }
  }

  // ==================== Terms ====================
  final termsContent = ''.obs;
  final isTermsLoading = false.obs;

  Future<void> loadTerms() async {
    if (termsContent.value.isNotEmpty) return;
    try {
      isTermsLoading.value = true;
      final res = await _repo.fetchTerms();
      if (res != null) termsContent.value = res;
    } catch (e) {
      AppSnackBar.error('Failed to load Terms & Conditions. Please try again.');
    } finally {
      isTermsLoading.value = false;
    }
  }

  // ==================== FAQ ====================
  final faqs = <FaqItemModel>[].obs;
  final isFaqLoading = false.obs;
  final expandedIndex = (-1).obs;

  Future<void> loadFaqs() async {
    if (faqs.isNotEmpty) return;
    try {
      isFaqLoading.value = true;
      final res = await _repo.fetchFaqs();
      if (res != null) faqs.assignAll(res);
    } catch (e) {
      AppSnackBar.error('Failed to load FAQs. Please try again.');
    } finally {
      isFaqLoading.value = false;
    }
  }

  void toggleFaq(int index) {
    expandedIndex.value = expandedIndex.value == index ? -1 : index;
  }
}
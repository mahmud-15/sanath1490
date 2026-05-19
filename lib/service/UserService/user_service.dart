import 'package:get/get.dart';

import '../../screens/BaseScreen/ProfileAllScreen/UserProfileModel/user_profile_model.dart';
import '../../screens/BaseScreen/ProfileAllScreen/UserRepository/user_repository.dart';
import '../../utils/log_print.dart';
class UserService {
  UserService._();
  static final UserService instance = UserService._();

  // ✅ Global reactive profile — সব screen এ Obx দিয়ে listen করা যাবে
  final Rx<UserProfileModel?> profile = Rx<UserProfileModel?>(null);
  final isLoading = false.obs;

  // ─── Shortcut getters ──────────────────────────
  String get name         => profile.value?.name         ?? '';
  String get email        => profile.value?.email        ?? '';
  String get phone        => profile.value?.phone        ?? '';
  String get role         => profile.value?.role         ?? '';
  String get country      => profile.value?.country      ?? '';
  String get postalCode   => profile.value?.postalCode   ?? '';
  String get city         => profile.value?.city         ?? '';
  String get profileImage => profile.value?.profileImage ?? '';
  String get agencyName   => profile.value?.agencyName   ?? '';
  bool   get isVerified   => profile.value?.verified     ?? false;

  // ==================== Init (app start এ call করুন) ====================
  Future<void> init() async {
    await fetchProfile();
  }

  // ==================== Fetch & Cache ====================
  Future<void> fetchProfile() async {
    try {
      isLoading.value = true;
      final data = await UserRepository.instance.getProfile();
      isLoading.value = false;
      if (data != null) profile.value = data;
    } catch (e) {
      isLoading.value = false;
      errorLog("UserService.fetchProfile", e);
    }
  }

  // ==================== Update local cache ====================
  /// API success হলে response দিয়ে local cache update করুন
  /// এতে আর getProfile call করতে হবে না
  void updateProfile(UserProfileModel updated) {
    profile.value = updated;
  }

  // ==================== Clear (logout এ call করুন) ====================
  void clearProfile() {
    profile.value = null;
  }
}
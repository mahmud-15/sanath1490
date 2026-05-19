import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../../constant/app_api_url.dart';
import '../../../../../utils/log_print.dart';
import '../../../../../widget/app_snack_bar/app_snack_bar.dart';
import '../../../../service/api/api_service.dart';
import '../UserProfileModel/user_profile_model.dart';
class UserRepository {
  UserRepository._();
  static final UserRepository instance = UserRepository._();

  final _api    = ApiServices.instance;
  final _apiUrl = AppApiUrl.instance;

  // ─── Error handler ─────────────────────────────
  void _handleError(dynamic e, String tag) {
    errorLog(tag, e);
    if (e is DioException && e.response?.data != null) {
      final msg = e.response?.data["message"];
      if (msg != null && msg.toString().isNotEmpty) {
        AppSnackBar.error(msg.toString());
        return;
      }
    }
    AppSnackBar.error("Something went wrong. Please try again.");
  }

  // ==================== GET Profile ====================
  Future<UserProfileModel?> getProfile() async {
    try {
      final response = await _api.getServices(
        _apiUrl.userProfileInfo,
        statusCode: 200,
      );
      if (response == null) return null;
      final result = UserProfileResponseModel.fromJson(response);
      return result.data;
    } catch (e) {
      _handleError(e, "getProfile");
      return null;
    }
  }

  // ==================== PATCH Profile (text fields) ====================
  Future<UserProfileModel?> updateProfile(UpdateProfileRequestModel request) async {
    try {
      final response = await _api.patchServices(
        url: _apiUrl.userProfile,
        body: request.toJson(),
        statusCode: 200,
      );
      if (response == null) return null;
      final result = UserProfileResponseModel.fromJson(response);
      return result.data;
    } catch (e) {
      _handleError(e, "updateProfile");
      return null;
    }
  }

  // ==================== PATCH Profile Image ====================
  Future<UserProfileModel?> updateProfileImage(File imageFile) async {
    try {
      final formData = FormData.fromMap({
        "profileImage": await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
      });

      final response = await _api.patchServices(
        url: _apiUrl.userProfile,
        body: formData,
        statusCode: 200,
        options: Options(contentType: 'multipart/form-data'),
      );
      if (response == null) return null;
      final result = UserProfileResponseModel.fromJson(response);
      return result.data;
    } catch (e) {
      _handleError(e, "updateProfileImage");
      return null;
    }
  }
}
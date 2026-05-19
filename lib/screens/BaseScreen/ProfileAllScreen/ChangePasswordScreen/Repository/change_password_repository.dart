import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';

class ChangePasswordRepository {
  ChangePasswordRepository._privateConstructor();
  static final ChangePasswordRepository _instance =
  ChangePasswordRepository._privateConstructor();
  static ChangePasswordRepository get instance => _instance;

  final _api = ApiServices.instance;

  Future<bool> changePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    final res = await _api.postServices(
      url: AppApiUrl.instance.changePassword,
      body: {
        "currentPassword": currentPassword,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
      },
    );

    return res != null && res['success'] == true;
  }
}
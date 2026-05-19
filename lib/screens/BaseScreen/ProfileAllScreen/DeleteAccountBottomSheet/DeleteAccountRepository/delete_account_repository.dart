import '../../../../../constant/app_api_url.dart';
import '../../../../../service/api/api_service.dart';

class DeleteAccountRepository {
  DeleteAccountRepository._privateConstructor();
  static final DeleteAccountRepository _instance =
  DeleteAccountRepository._privateConstructor();
  static DeleteAccountRepository get instance => _instance;

  final _api = ApiServices.instance;

  Future<bool> deleteAccount({required String password}) async {
    final res = await _api.deleteServices(
      url: AppApiUrl.instance.userDeleteProfile,
      body: {"password": password},
    );
    return res != null && res['success'] == true;
  }
}
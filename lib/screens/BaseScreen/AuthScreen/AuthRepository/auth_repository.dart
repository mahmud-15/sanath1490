import '../../../../service/api/api_service.dart';
import '../../../../../constant/app_api_url.dart';
import '../AccountVerifyOtpScreen/Model/otp_verify_model.dart';
import '../CreateAccountScreen/Model/register_model.dart';
import '../ForgotPasswordScreen/Model/forgot_password_model.dart';
import '../ResetPassword/Model/reset_password_model.dart';
import '../ResetVerifyOtpScreen/Model/reset_verify_otp_model.dart';
import '../SignInScreen/Model/sign_in_model.dart';

class AuthRepository {
  AuthRepository._privateConstructor();
  static final AuthRepository _instance = AuthRepository._privateConstructor();
  static AuthRepository get instance => _instance;

  final _apiServices = ApiServices.instance;
  final _apiUrl      = AppApiUrl.instance;

  // ==================== Register ====================
  Future<RegisterResponseModel?> register(RegisterRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.register,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return RegisterResponseModel.fromJson(response);
  }

  // ==================== Register Verify OTP ====================
  Future<OtpVerifyResponseModel?> verifyOtp(OtpVerifyRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.registerVerifyOtp,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return OtpVerifyResponseModel.fromJson(response);
  }

  // ==================== Sign In ====================
  Future<SignInResponseModel?> signIn(SignInRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.singIn,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return SignInResponseModel.fromJson(response);
  }

  // ==================== Forgot Password ====================
  Future<ForgotPasswordResponseModel?> forgotPassword(ForgotPasswordRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.forgotPassword,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return ForgotPasswordResponseModel.fromJson(response);
  }

  // ==================== Forgot Verify OTP ====================
  Future<ResetVerifyOtpResponseModel?> forgotVerifyOtp(ResetVerifyOtpRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.forgotVerifyOtp,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return ResetVerifyOtpResponseModel.fromJson(response);
  }

  // ==================== Reset Password ====================
  Future<ResetPasswordResponseModel?> resetPassword(ResetPasswordRequestModel request) async {
    final response = await _apiServices.postServices(
      url: _apiUrl.resetPassword,
      body: request.toJson(),
      statusCodeStart: 200,
      statusCodeEnd: 299,
    );
    if (response == null) return null;
    return ResetPasswordResponseModel.fromJson(response);
  }
}
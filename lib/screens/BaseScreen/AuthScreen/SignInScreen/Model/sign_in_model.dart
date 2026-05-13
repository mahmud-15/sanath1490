class SignInRequestModel {
  final String email;
  final String password;

  const SignInRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "password": password,
  };
}
class SignInResponseModel {
  final bool success;
  final String message;
  final SignInData? data;

  const SignInResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory SignInResponseModel.fromJson(Map<String, dynamic> json) =>
      SignInResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? SignInData.fromJson(json["data"])
            : null,
      );
}

class SignInData {
  final String? accessToken;
  final String? refreshToken;

  const SignInData({
    this.accessToken,
    this.refreshToken,
  });

  factory SignInData.fromJson(Map<String, dynamic> json) => SignInData(
    accessToken:  json["token"]?.toString(),
    refreshToken: json["refreshToken"]?.toString(),
  );
}
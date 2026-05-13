class OtpVerifyRequestModel {
  final String email;
  final int oneTimeCode;

  const OtpVerifyRequestModel({
    required this.email,
    required this.oneTimeCode,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "oneTimeCode": oneTimeCode,
  };
}

class OtpVerifyResponseModel {
  final bool success;
  final String message;

  const OtpVerifyResponseModel({
    required this.success,
    required this.message,
  });

  factory OtpVerifyResponseModel.fromJson(Map<String, dynamic> json) =>
      OtpVerifyResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );
}
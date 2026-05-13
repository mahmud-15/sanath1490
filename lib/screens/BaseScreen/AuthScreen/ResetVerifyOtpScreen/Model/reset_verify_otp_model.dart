// ==================== Request ====================
class ResetVerifyOtpRequestModel {
  final String email;
  final int oneTimeCode;

  const ResetVerifyOtpRequestModel({
    required this.email,
    required this.oneTimeCode,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "oneTimeCode": oneTimeCode,
  };
}

// ==================== Response ====================
class ResetVerifyOtpResponseModel {
  final bool success;
  final String message;

  const ResetVerifyOtpResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetVerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetVerifyOtpResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );
}
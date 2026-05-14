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
  final String? resetToken; // ✅ data field = resetToken

  const ResetVerifyOtpResponseModel({
    required this.success,
    required this.message,
    this.resetToken,
  });

  factory ResetVerifyOtpResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetVerifyOtpResponseModel(
        success:    json["success"] ?? false,
        message:    json["message"] ?? "",
        resetToken: json["data"]?.toString(),
      );
}
// ==================== Request ====================
class ResetPasswordRequestModel {
  final String email;
  final String newPassword;

  const ResetPasswordRequestModel({
    required this.email,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => {
    "email": email,
    "newPassword": newPassword,
  };
}

// ==================== Response ====================
class ResetPasswordResponseModel {
  final bool success;
  final String message;

  const ResetPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ResetPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ResetPasswordResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );
}
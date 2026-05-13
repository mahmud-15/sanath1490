// ==================== Request ====================
class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({required this.email});

  Map<String, dynamic> toJson() => {"email": email};
}

// ==================== Response ====================
class ForgotPasswordResponseModel {
  final bool success;
  final String message;

  const ForgotPasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      ForgotPasswordResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
      );
}
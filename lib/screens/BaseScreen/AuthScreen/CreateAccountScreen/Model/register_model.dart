class RegisterRequestModel {
  final String name;
  final String email;
  final String password;
  final String role;

  const RegisterRequestModel({
    required this.name,
    required this.email,
    required this.password,
    this.role = "USER",
  });

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "role": role,
  };
}
class RegisterResponseModel {
  final bool success;
  final String message;
  final RegisterData? data;

  const RegisterResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      RegisterResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data: json["data"] != null
            ? RegisterData.fromJson(json["data"])
            : null,
      );
}

class RegisterData {
  final String? id;
  final String? name;
  final String? email;
  final String? role;

  const RegisterData({
    this.id,
    this.name,
    this.email,
    this.role,
  });

  factory RegisterData.fromJson(Map<String, dynamic> json) => RegisterData(
    id: json["_id"]?.toString(),
    name: json["name"]?.toString(),
    email: json["email"]?.toString(),
    role: json["role"]?.toString(),
  );
}
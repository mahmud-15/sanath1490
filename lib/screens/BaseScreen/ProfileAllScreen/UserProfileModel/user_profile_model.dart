// ==================== User Profile Model ====================
class UserProfileModel {
  final String? id;
  final String? name;
  final String? email;
  final String? phone;
  final String? role;
  final String? profileImage;
  final String? country;
  final String? countryCode;
  final String? postalCode;
  final String? city;
  final String? dateOfBirth;
  final String? agencyName;
  final String? agencyLogo;
  final LocationModel? location;
  final bool isSubscribed;
  final bool verified;
  final String? status;

  const UserProfileModel({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.role,
    this.profileImage,
    this.country,
    this.countryCode,
    this.postalCode,
    this.city,
    this.dateOfBirth,
    this.agencyName,
    this.agencyLogo,
    this.location,
    this.isSubscribed = false,
    this.verified = false,
    this.status,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id:           json["_id"]?.toString(),
      name:         json["name"]?.toString(),
      email:        json["email"]?.toString(),
      phone:        json["phone"]?.toString(),
      role:         json["role"]?.toString(),
      profileImage: json["profileImage"]?.toString(),
      country:      json["country"]?.toString(),
      countryCode:  json["countryCode"]?.toString(),
      postalCode:   json["postalCode"]?.toString(),
      city:         json["city"]?.toString(),
      dateOfBirth:  json["dateOfBirth"]?.toString(),
      agencyName:   json["agencyName"]?.toString(),
      agencyLogo:   json["agencyLogo"]?.toString(),
      location:     json["location"] != null
          ? LocationModel.fromJson(json["location"])
          : null,
      isSubscribed: json["isSubscribed"] ?? false,
      verified:     json["verified"] ?? false,
      status:       json["status"]?.toString(),
    );
  }
}

class LocationModel {
  final String? type;
  final String? address;

  const LocationModel({this.type, this.address});

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    type:    json["type"]?.toString(),
    address: json["address"]?.toString(),
  );
}

// ==================== Update Profile Request ====================
class UpdateProfileRequestModel {
  final String? name;
  final String? phone;
  final String? country;
  final String? countryCode;
  final String? postalCode;
  final String? city;

  const UpdateProfileRequestModel({
    this.name,
    this.phone,
    this.country,
    this.countryCode,
    this.postalCode,
    this.city,
  });

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (name != null)        map["name"]        = name;
    if (phone != null)       map["phone"]       = phone;
    if (country != null)     map["country"]     = country;
    if (countryCode != null) map["countryCode"] = countryCode;
    if (postalCode != null)  map["postalCode"]  = postalCode;
    if (city != null)        map["city"]        = city;
    return map;
  }
}

// ==================== Response Wrapper ====================
class UserProfileResponseModel {
  final bool success;
  final String message;
  final UserProfileModel? data;

  const UserProfileResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory UserProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      UserProfileResponseModel(
        success: json["success"] ?? false,
        message: json["message"] ?? "",
        data:    json["data"] != null
            ? UserProfileModel.fromJson(json["data"])
            : null,
      );
}
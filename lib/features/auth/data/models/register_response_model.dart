import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final RegisterResponseData data;

  RegisterResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable()
class RegisterResponseData {
  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'user')
  final User user;

  RegisterResponseData({
    required this.token,
    required this.user,
  });

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDataToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'bio')
  final String bio;

  @JsonKey(name: 'avatar')
  final String avatar;

  @JsonKey(name: 'cover')
  final String cover;

  @JsonKey(name: 'role_name')
  final String roleName;

  User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.bio,
    required this.avatar,
    required this.cover,
    required this.roleName,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

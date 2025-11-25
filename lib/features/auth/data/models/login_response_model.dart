import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data', includeIfNull: false)
  final LoginResponseData? data;

  LoginResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] != null
          ? LoginResponseData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }
}

@JsonSerializable()
class LoginResponseData {
  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'user')
  final User user;

  LoginResponseData({
    required this.token,
    required this.user,
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);
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
}

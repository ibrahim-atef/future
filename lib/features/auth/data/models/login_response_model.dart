import 'package:json_annotation/json_annotation.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final LoginResponseData data;

  LoginResponseModel(
      {required this.success,
      required this.status,
      required this.message,
      required this.data});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);
}

@JsonSerializable()
class LoginResponseData {
  @JsonKey(name: 'token')
  final String token;

  @JsonKey(name: 'user_id')
  final int userId;

  // @JsonKey(name: 'profile_completion')
  // final List<String> profileCompletion;

  LoginResponseData({
    required this.token,
    required this.userId,
    // required this.profileCompletion
  });

  factory LoginResponseData.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseDataFromJson(json);
}

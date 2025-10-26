import 'package:json_annotation/json_annotation.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel {
  String username;
  String password;
  @JsonKey(name: 'device_id')
  String deviceId;

  @JsonKey(name: 'access_id')
  String accessId;

  LoginRequestModel(
      {required this.username,
      required this.password,
      required this.deviceId,
      required this.accessId});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}

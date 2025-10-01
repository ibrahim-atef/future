import 'package:json_annotation/json_annotation.dart';

part 'register_step2_response_model.g.dart';

@JsonSerializable()
class RegisterStep2ResponseModel {
  @JsonKey(name: "success")
  bool success;

  @JsonKey(name: "status")
  String status;

  @JsonKey(name: "message")
  String message;

  @JsonKey(name: "data")
  RegisterStep2ResponseData? data;

  RegisterStep2ResponseModel({
    required this.success,
    required this.status,
    required this.message,
    this.data,
  });

  factory RegisterStep2ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterStep2ResponseModelFromJson(json);
}

@JsonSerializable()
class RegisterStep2ResponseData {
  @JsonKey(name: "code")
  String code;

  @JsonKey(name: "user_id")
  int userId;

  @JsonKey(name: "full_name")
  String fullName;

  @JsonKey(name: "token")
  String token;

  RegisterStep2ResponseData({
    required this.code,
    required this.userId,
    required this.fullName,
    required this.token,
  });

  factory RegisterStep2ResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterStep2ResponseDataFromJson(json);
}

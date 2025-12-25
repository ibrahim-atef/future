import 'package:json_annotation/json_annotation.dart';

part 'register_request_model.g.dart';

@JsonSerializable()
class RegisterRequestModel {
  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'password')
  final String password;

  @JsonKey(name: 'role')
  final String role;

  @JsonKey(name: 'college')
  final String college;

  @JsonKey(name: 'level')
  final String level;

  RegisterRequestModel({
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.password,
    required this.role,
    required this.college,
    required this.level,
  });

  factory RegisterRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestModelFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestModelToJson(this);
}

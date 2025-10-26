import 'package:json_annotation/json_annotation.dart';

part 'update_password_response_model.g.dart';

@JsonSerializable()
class UpdatePasswordResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  UpdatePasswordResponseModel({
    required this.success,
    required this.message,
  });

  factory UpdatePasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordResponseModelToJson(this);
}

@JsonSerializable()
class UpdatePasswordRequestModel {
  @JsonKey(name: 'current_password')
  final String currentPassword;

  @JsonKey(name: 'new_password')
  final String newPassword;

  @JsonKey(name: 'new_password_confirmation')
  final String newPasswordConfirmation;

  UpdatePasswordRequestModel({
    required this.currentPassword,
    required this.newPassword,
    required this.newPasswordConfirmation,
  });

  factory UpdatePasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdatePasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdatePasswordRequestModelToJson(this);
}

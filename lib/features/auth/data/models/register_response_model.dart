import 'package:json_annotation/json_annotation.dart';

part 'register_response_model.g.dart';

@JsonSerializable()
class RegisterResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final RegisterResponseData data;

  RegisterResponseModel({
    required this.success,
    required this.status,
    required this.message,
    required this.data,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseModelToJson(this);
}

@JsonSerializable()
class RegisterResponseData {
  @JsonKey(name: 'user_id')
  final int userId;

  RegisterResponseData({
    required this.userId,
  });

  factory RegisterResponseData.fromJson(Map<String, dynamic> json) =>
      _$RegisterResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterResponseDataToJson(this);
}

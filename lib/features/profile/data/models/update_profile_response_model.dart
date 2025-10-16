import 'package:json_annotation/json_annotation.dart';

part 'update_profile_response_model.g.dart';

@JsonSerializable()
class UpdateProfileResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  UpdateProfileResponseModel({
    required this.success,
    required this.message,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileResponseModelToJson(this);
}

@JsonSerializable()
class UpdateProfileRequestModel {
  @JsonKey(name: 'full_name')
  final String fullName;

  @JsonKey(name: 'mobile')
  final String mobile;

  @JsonKey(name: 'bio')
  final String bio;

  @JsonKey(name: 'about')
  final String about;

  UpdateProfileRequestModel({
    required this.fullName,
    required this.mobile,
    required this.bio,
    required this.about,
  });

  factory UpdateProfileRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateProfileRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateProfileRequestModelToJson(this);
}

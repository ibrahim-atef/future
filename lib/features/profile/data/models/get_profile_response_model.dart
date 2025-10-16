import 'package:json_annotation/json_annotation.dart';

part 'get_profile_response_model.g.dart';

@JsonSerializable()
class GetProfileResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final ProfileData data;

  GetProfileResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetProfileResponseModelFromJson(json);
}

@JsonSerializable()
class ProfileData {
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

  @JsonKey(name: 'about')
  final String about;

  @JsonKey(name: 'avatar')
  final String avatar;

  @JsonKey(name: 'cover')
  final String cover;

  ProfileData({
    required this.id,
    required this.fullName,
    required this.email,
    required this.mobile,
    required this.bio,
    required this.about,
    required this.avatar,
    required this.cover,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) =>
      _$ProfileDataFromJson(json);
}

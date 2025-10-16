// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_profile_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetProfileResponseModel _$GetProfileResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetProfileResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: ProfileData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetProfileResponseModelToJson(
        GetProfileResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

ProfileData _$ProfileDataFromJson(Map<String, dynamic> json) => ProfileData(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      bio: json['bio'] as String,
      about: json['about'] as String,
      avatar: json['avatar'] as String,
      cover: json['cover'] as String,
    );

Map<String, dynamic> _$ProfileDataToJson(ProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'bio': instance.bio,
      'about': instance.about,
      'avatar': instance.avatar,
      'cover': instance.cover,
    };

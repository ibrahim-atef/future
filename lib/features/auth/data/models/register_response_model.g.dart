// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: RegisterResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

RegisterResponseData _$RegisterResponseDataFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseData(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseDataToJson(
        RegisterResponseData instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      bio: json['bio'] as String,
      avatar: json['avatar'] as String,
      cover: json['cover'] as String,
      roleName: json['role_name'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'bio': instance.bio,
      'avatar': instance.avatar,
      'cover': instance.cover,
      'role_name': instance.roleName,
    };

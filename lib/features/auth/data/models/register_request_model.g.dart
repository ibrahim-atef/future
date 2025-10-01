// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterRequestModel _$RegisterRequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterRequestModel(
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      password: json['password'] as String,
      passwordConfirmation: json['password_confirmation'] as String,
      deviceId: json['device_id'] as String,
      roleName: json['role_name'] as String,
    );

Map<String, dynamic> _$RegisterRequestModelToJson(
        RegisterRequestModel instance) =>
    <String, dynamic>{
      'full_name': instance.fullName,
      'email': instance.email,
      'mobile': instance.mobile,
      'password': instance.password,
      'password_confirmation': instance.passwordConfirmation,
      'device_id': instance.deviceId,
      'role_name': instance.roleName,
    };

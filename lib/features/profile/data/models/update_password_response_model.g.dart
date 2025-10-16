// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_password_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdatePasswordResponseModel _$UpdatePasswordResponseModelFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$UpdatePasswordResponseModelToJson(
        UpdatePasswordResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

UpdatePasswordRequestModel _$UpdatePasswordRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdatePasswordRequestModel(
      currentPassword: json['current_password'] as String,
      newPassword: json['new_password'] as String,
      newPasswordConfirmation: json['new_password_confirmation'] as String,
    );

Map<String, dynamic> _$UpdatePasswordRequestModelToJson(
        UpdatePasswordRequestModel instance) =>
    <String, dynamic>{
      'current_password': instance.currentPassword,
      'new_password': instance.newPassword,
      'new_password_confirmation': instance.newPasswordConfirmation,
    };

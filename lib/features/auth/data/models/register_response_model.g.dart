// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterResponseModel _$RegisterResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseModel(
      success: json['success'] as bool,
      status: json['status'] as String,
      message: json['message'] as String,
      data: RegisterResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterResponseModelToJson(
        RegisterResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RegisterResponseData _$RegisterResponseDataFromJson(
        Map<String, dynamic> json) =>
    RegisterResponseData(
      userId: (json['user_id'] as num).toInt(),
    );

Map<String, dynamic> _$RegisterResponseDataToJson(
        RegisterResponseData instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
    };

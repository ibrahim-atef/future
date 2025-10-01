// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_step2_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterStep2ResponseModel _$RegisterStep2ResponseModelFromJson(
        Map<String, dynamic> json) =>
    RegisterStep2ResponseModel(
      success: json['success'] as bool,
      status: json['status'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : RegisterStep2ResponseData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RegisterStep2ResponseModelToJson(
        RegisterStep2ResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': instance.status,
      'message': instance.message,
      'data': instance.data,
    };

RegisterStep2ResponseData _$RegisterStep2ResponseDataFromJson(
        Map<String, dynamic> json) =>
    RegisterStep2ResponseData(
      code: json['code'] as String,
      userId: (json['user_id'] as num).toInt(),
      fullName: json['full_name'] as String,
      token: json['token'] as String,
    );

Map<String, dynamic> _$RegisterStep2ResponseDataToJson(
        RegisterStep2ResponseData instance) =>
    <String, dynamic>{
      'code': instance.code,
      'user_id': instance.userId,
      'full_name': instance.fullName,
      'token': instance.token,
    };

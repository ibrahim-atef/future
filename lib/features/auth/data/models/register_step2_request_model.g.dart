// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_step2_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RegisterStep2RequestModel _$RegisterStep2RequestModelFromJson(
        Map<String, dynamic> json) =>
    RegisterStep2RequestModel(
      code: json['code'] as String,
      userId: (json['user_id'] as num).toInt(),
      fullName: json['full_name'] as String,
    );

Map<String, dynamic> _$RegisterStep2RequestModelToJson(
        RegisterStep2RequestModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'user_id': instance.userId,
      'full_name': instance.fullName,
    };

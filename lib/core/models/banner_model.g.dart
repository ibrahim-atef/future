// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'banner_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BannerResponseModel _$BannerResponseModelFromJson(Map<String, dynamic> json) =>
    BannerResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: BannerResponseData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BannerResponseModelToJson(
        BannerResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

BannerResponseData _$BannerResponseDataFromJson(Map<String, dynamic> json) =>
    BannerResponseData(
      banners:
          (json['banners'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$BannerResponseDataToJson(BannerResponseData instance) =>
    <String, dynamic>{
      'banners': instance.banners,
    };

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      image: json['image'] as String?,
      link: json['link'] as String?,
      order: (json['order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image': instance.image,
      'link': instance.link,
      'order': instance.order,
    };

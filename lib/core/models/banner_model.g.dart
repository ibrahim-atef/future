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
      banners: (json['banners'] as List<dynamic>)
          .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BannerResponseDataToJson(BannerResponseData instance) =>
    <String, dynamic>{
      'banners': instance.banners,
    };

BannerModel _$BannerModelFromJson(Map<String, dynamic> json) => BannerModel(
      id: json['id'] as String?,
      title: json['title'] as String?,
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      linkUrl: json['linkUrl'] as String?,
      linkType: json['linkType'] as String?,
      relatedId: json['relatedId'] as String?,
      order: (json['order'] as num?)?.toInt(),
      isActive: json['isActive'] as bool?,
      startDate: json['startDate'] as String?,
      endDate: json['endDate'] as String?,
    );

Map<String, dynamic> _$BannerModelToJson(BannerModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'imageUrl': instance.imageUrl,
      'linkUrl': instance.linkUrl,
      'linkType': instance.linkType,
      'relatedId': instance.relatedId,
      'order': instance.order,
      'isActive': instance.isActive,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
    };

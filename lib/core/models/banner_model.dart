import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final BannerResponseData data;

  BannerResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory BannerResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseModelToJson(this);
}

@JsonSerializable()
class BannerResponseData {
  @JsonKey(name: 'banners')
  final List<BannerModel> banners;

  BannerResponseData({
    required this.banners,
  });

  factory BannerResponseData.fromJson(Map<String, dynamic> json) =>
      _$BannerResponseDataFromJson(json);

  Map<String, dynamic> toJson() => _$BannerResponseDataToJson(this);
}

@JsonSerializable()
class BannerModel {
  @JsonKey(name: 'id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imageUrl')
  final String? imageUrl;

  @JsonKey(name: 'linkUrl')
  final String? linkUrl;

  @JsonKey(name: 'linkType')
  final String? linkType;

  @JsonKey(name: 'relatedId')
  final String? relatedId;

  @JsonKey(name: 'order')
  final int? order;

  @JsonKey(name: 'isActive')
  final bool? isActive;

  @JsonKey(name: 'startDate')
  final String? startDate;

  @JsonKey(name: 'endDate')
  final String? endDate;

  BannerModel({
    this.id,
    this.title,
    this.description,
    this.imageUrl,
    this.linkUrl,
    this.linkType,
    this.relatedId,
    this.order,
    this.isActive,
    this.startDate,
    this.endDate,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

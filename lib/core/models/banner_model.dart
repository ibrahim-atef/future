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
  final List<String> banners;

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
  final int? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'link')
  final String? link;

  @JsonKey(name: 'order')
  final int? order;

  BannerModel({
    this.id,
    this.title,
    this.image,
    this.link,
    this.order,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) =>
      _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}

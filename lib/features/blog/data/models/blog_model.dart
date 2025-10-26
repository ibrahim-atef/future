import 'package:freezed_annotation/freezed_annotation.dart';

part 'blog_model.freezed.dart';
part 'blog_model.g.dart';

// Get Posts Response Model
@freezed
class GetPostsResponseModel with _$GetPostsResponseModel {
  const factory GetPostsResponseModel({
    required bool success,
    required String message,
    required List<PostModel> data,
    required PaginationModel pagination,
  }) = _GetPostsResponseModel;

  factory GetPostsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostsResponseModelFromJson(json);
}

// Post Model
@freezed
class PostModel with _$PostModel {
  const factory PostModel({
    required String id,
    required String title,
    required String excerpt,
    required String content,
    required dynamic imageUrl,
    required String author,
    required List<dynamic> tags,
    required int viewsCount,
    required String publishedAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// Pagination Model
@freezed
class PaginationModel with _$PaginationModel {
  const factory PaginationModel({
    @JsonKey(name: 'current_page') required int currentPage,
    @JsonKey(name: 'per_page') required int perPage,
    @JsonKey(name: 'total_items') required int totalItems,
    @JsonKey(name: 'total_pages') required int totalPages,
  }) = _PaginationModel;

  factory PaginationModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationModelFromJson(json);
}

// Get Post Details Response Model
@freezed
class GetPostDetailsResponseModel with _$GetPostDetailsResponseModel {
  const factory GetPostDetailsResponseModel({
    required bool success,
    required String message,
    required PostDetailsModel data,
  }) = _GetPostDetailsResponseModel;

  factory GetPostDetailsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetPostDetailsResponseModelFromJson(json);
}

// Post Details Model
@freezed
class PostDetailsModel with _$PostDetailsModel {
  const factory PostDetailsModel({
    required String id,
    required String title,
    required String content,
    required dynamic imageUrl,
    required String author,
    required List<dynamic> tags,
    required int viewsCount,
    required String publishedAt,
  }) = _PostDetailsModel;

  factory PostDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$PostDetailsModelFromJson(json);
}


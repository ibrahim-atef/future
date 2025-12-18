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

// Post Category Response Model
class GetPostCategoriesResponseModel {
  final bool success;
  final String message;
  final List<PostCategoryModel> data;

  GetPostCategoriesResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetPostCategoriesResponseModel.fromJson(Map<String, dynamic> json) {
    return GetPostCategoriesResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PostCategoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
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

// Post Category Model
class PostCategoryModel {
  final String id;
  final String name;
  final String slug;
  final String? description;
  final String? parent;
  final int count;
  final String taxonomy;

  PostCategoryModel({
    required this.id,
    required this.name,
    required this.slug,
    this.description,
    this.parent,
    required this.count,
    required this.taxonomy,
  });

  factory PostCategoryModel.fromJson(Map<String, dynamic> json) {
    return PostCategoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String?,
      parent: json['parent']?.toString(),
      count: (json['count'] as num).toInt(),
      taxonomy: json['taxonomy'] as String,
    );
  }
}

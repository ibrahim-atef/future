// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GetPostsResponseModelImpl _$$GetPostsResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPostsResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => PostModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetPostsResponseModelImplToJson(
        _$GetPostsResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

_$PostModelImpl _$$PostModelImplFromJson(Map<String, dynamic> json) =>
    _$PostModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      excerpt: json['excerpt'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'],
      author: json['author'] as String,
      tags: json['tags'] as List<dynamic>,
      viewsCount: (json['viewsCount'] as num).toInt(),
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$$PostModelImplToJson(_$PostModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'excerpt': instance.excerpt,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
      'tags': instance.tags,
      'viewsCount': instance.viewsCount,
      'publishedAt': instance.publishedAt,
    };

_$PaginationModelImpl _$$PaginationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PaginationModelImpl(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$$PaginationModelImplToJson(
        _$PaginationModelImpl instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };

_$GetPostDetailsResponseModelImpl _$$GetPostDetailsResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$GetPostDetailsResponseModelImpl(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: PostDetailsModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$GetPostDetailsResponseModelImplToJson(
        _$GetPostDetailsResponseModelImpl instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

_$PostDetailsModelImpl _$$PostDetailsModelImplFromJson(
        Map<String, dynamic> json) =>
    _$PostDetailsModelImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      imageUrl: json['imageUrl'],
      author: json['author'] as String,
      tags: json['tags'] as List<dynamic>,
      viewsCount: (json['viewsCount'] as num).toInt(),
      publishedAt: json['publishedAt'] as String,
    );

Map<String, dynamic> _$$PostDetailsModelImplToJson(
        _$PostDetailsModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'imageUrl': instance.imageUrl,
      'author': instance.author,
      'tags': instance.tags,
      'viewsCount': instance.viewsCount,
      'publishedAt': instance.publishedAt,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCoursesResponseModel _$GetCoursesResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetCoursesResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: (json['data'] as List<dynamic>)
          .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      pagination:
          PaginationData.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCoursesResponseModelToJson(
        GetCoursesResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'pagination': instance.pagination,
    };

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      excerpt: json['excerpt'] as String,
      teacherName: json['teacherName'] as String,
      teacherId: json['teacherId'] as String,
      imageUrl: json['imageUrl'] as String,
      level: json['level'] as String,
      language: json['language'] as String,
      totalHours: (json['totalHours'] as num).toInt(),
      totalDuration: (json['totalDuration'] as num).toInt(),
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      studentsCount: (json['studentsCount'] as num?)?.toInt() ?? 0,
      isFree: json['isFree'] as bool? ?? false,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      categories: (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      status: json['status'] as String,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
    );

Map<String, dynamic> _$CourseModelToJson(CourseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'excerpt': instance.excerpt,
      'teacherName': instance.teacherName,
      'teacherId': instance.teacherId,
      'imageUrl': instance.imageUrl,
      'level': instance.level,
      'language': instance.language,
      'totalHours': instance.totalHours,
      'totalDuration': instance.totalDuration,
      'rating': instance.rating,
      'studentsCount': instance.studentsCount,
      'isFree': instance.isFree,
      'price': instance.price,
      'categories': instance.categories,
      'tags': instance.tags,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

GetSingleCourseResponseModel _$GetSingleCourseResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetSingleCourseResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: CourseModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetSingleCourseResponseModelToJson(
        GetSingleCourseResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

PaginationData _$PaginationDataFromJson(Map<String, dynamic> json) =>
    PaginationData(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationDataToJson(PaginationData instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };

GetCourseContentResponseModel _$GetCourseContentResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetCourseContentResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: CourseContentData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetCourseContentResponseModelToJson(
        GetCourseContentResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

CourseContentData _$CourseContentDataFromJson(Map<String, dynamic> json) =>
    CourseContentData(
      lectures: (json['lectures'] as List<dynamic>)
          .map((e) => LectureModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CourseContentDataToJson(CourseContentData instance) =>
    <String, dynamic>{
      'lectures': instance.lectures,
    };

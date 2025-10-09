import 'package:json_annotation/json_annotation.dart';

part 'courses_model.g.dart';

// Main Response Model
@JsonSerializable()
class GetCoursesResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final List<CourseModel> data;

  @JsonKey(name: 'pagination')
  final PaginationData pagination;

  GetCoursesResponseModel({
    required this.success,
    required this.message,
    required this.data,
    required this.pagination,
  });

  factory GetCoursesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetCoursesResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetCoursesResponseModelToJson(this);
}

// Course Model
@JsonSerializable()
class CourseModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'description')
  final String description;

  @JsonKey(name: 'excerpt')
  final String excerpt;

  @JsonKey(name: 'teacherName')
  final String teacherName;

  @JsonKey(name: 'teacherId')
  final String teacherId;

  @JsonKey(name: 'imageUrl')
  final String imageUrl;

  @JsonKey(name: 'level')
  final String level;

  @JsonKey(name: 'language')
  final String language;

  @JsonKey(name: 'totalHours')
  final int totalHours;

  @JsonKey(name: 'totalDuration')
  final int totalDuration;

  @JsonKey(name: 'rating')
  final double rating;

  @JsonKey(name: 'studentsCount')
  final int studentsCount;

  @JsonKey(name: 'isFree')
  final bool isFree;

  @JsonKey(name: 'price')
  final double price;

  @JsonKey(name: 'categories')
  final List<String> categories;

  @JsonKey(name: 'tags')
  final List<String> tags;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'createdAt')
  final String createdAt;

  @JsonKey(name: 'updatedAt')
  final String updatedAt;

  CourseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.excerpt,
    required this.teacherName,
    required this.teacherId,
    required this.imageUrl,
    required this.level,
    required this.language,
    required this.totalHours,
    required this.totalDuration,
    this.rating = 0.0,
    this.studentsCount = 0,
    this.isFree = false,
    this.price = 0.0,
    this.categories = const [],
    this.tags = const [],
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModelToJson(this);

  // Helper getters
  String get priceText => isFree ? 'مجانًا' : '${price.toInt()} ج.م';

  String get durationText => totalHours > 0 ? '$totalHours ساعة' : '';

  String get ratingText => rating > 0 ? rating.toStringAsFixed(1) : '';
}

// Single Course Response Model
@JsonSerializable()
class GetSingleCourseResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final CourseModel data;

  GetSingleCourseResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetSingleCourseResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetSingleCourseResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetSingleCourseResponseModelToJson(this);
}

// Pagination Model
@JsonSerializable()
class PaginationData {
  @JsonKey(name: 'current_page')
  final int currentPage;

  @JsonKey(name: 'per_page')
  final int perPage;

  @JsonKey(name: 'total_items')
  final int totalItems;

  @JsonKey(name: 'total_pages')
  final int totalPages;

  PaginationData({
    required this.currentPage,
    required this.perPage,
    required this.totalItems,
    required this.totalPages,
  });

  factory PaginationData.fromJson(Map<String, dynamic> json) =>
      _$PaginationDataFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationDataToJson(this);

  // Helper getters
  bool get hasNextPage => currentPage < totalPages;
  bool get hasPreviousPage => currentPage > 1;
}

import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/core/network/api_service.dart';
import 'dart:developer';

class CollegeRepo {
  final ApiService _apiService;
  CollegeRepo(this._apiService);

  // Get college banners
  Future<ApiResult<BannerResponseModel>> getBanners() async {
    try {
      log('🌐 CollegeRepo: Calling getBanners API');
      final response = await _apiService.getBanners(
        ApiConstants.apiKey,
        ApiConstants.appSource,
        'college',
      );
      return ApiResult.success(response);
    } catch (e) {
      log('❌ CollegeRepo: Get banners API error: ${e.toString()}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // Get college courses by category (1=future, 2=books, 3=tables)
  Future<ApiResult<GetCoursesResponseModel>> getCourses({
    int? categoryId,
    int? filtersLevels,
    int page = 1,
    int limit = 100,
  }) async {
    try {
      log('🌐 CollegeRepo: Calling getCourses API - category: $categoryId');
      final response = await _apiService.getCourses(
        ApiConstants.apiKey,
        ApiConstants.appSource,
        page,
        limit,
        categoryId,
        filtersLevels,
      );
      log('✅ CollegeRepo: Get courses API success - ${response.data.length} courses');
      return ApiResult.success(response);
    } catch (e) {
      log('❌ CollegeRepo: Get courses API error: ${e.toString()}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}

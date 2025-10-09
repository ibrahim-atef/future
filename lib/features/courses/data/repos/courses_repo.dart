import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/features/courses/data/models/courses_model.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/core/network/api_service.dart';
import 'dart:developer';

class CoursesRepo {
  final ApiService _apiService;
  CoursesRepo(this._apiService);

  // get courses with pagination
  Future<ApiResult<GetCoursesResponseModel>> getCourses({
    required int page,
    required int limit,
  }) async {
    try {
      final response = await _apiService.getCourses(
        ApiConstants.apiKey,
        ApiConstants.appSource,
        page,
        limit,
      );
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // get banners
  Future<ApiResult<BannerResponseModel>> getBanners() async {
    try {
      log('🌐 CoursesRepo: Calling getBanners API...');
      final response = await _apiService.getBanners(
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      log('✅ CoursesRepo: Banner API success - ${response.data.banners.length} banners');
      log('Banner URLs: ${response.data.banners}');
      return ApiResult.success(response);
    } catch (e) {
      log('❌ CoursesRepo: Banner API error: ${e.toString()}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}

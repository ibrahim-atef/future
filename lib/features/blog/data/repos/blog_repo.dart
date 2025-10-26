import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/features/blog/data/models/blog_model.dart';
import 'package:future_app/core/network/api_service.dart';
import 'dart:developer';

class BlogRepo {
  final ApiService _apiService;
  BlogRepo(this._apiService);

  // Get posts with pagination
  Future<ApiResult<GetPostsResponseModel>> getPosts({
    required int page,
    required int limit,
  }) async {
    try {
      log('🌐 BlogRepo: Calling getPosts API - page: $page, limit: $limit');
      final response = await _apiService.getPosts(
        ApiConstants.apiKey,
        ApiConstants.appSource,
        page,
        limit,
      );
      log('✅ BlogRepo: Get posts API success - ${response.data.length} posts');
      return ApiResult.success(response);
    } catch (e) {
      log('❌ BlogRepo: Get posts API error: ${e.toString()}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // Get post details by ID
  Future<ApiResult<GetPostDetailsResponseModel>> getPostDetails(
      String postId) async {
    try {
      log('🌐 BlogRepo: Calling getPostDetails API for postId: $postId');
      final response = await _apiService.getPostDetails(
        postId,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      log('✅ BlogRepo: Get post details API success');
      return ApiResult.success(response);
    } catch (e) {
      log('❌ BlogRepo: Get post details API error: ${e.toString()}');
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}


import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/core/models/banner_model.dart';
import 'package:future_app/core/network/api_service.dart';
import 'dart:developer';

class HomeRepo {
  final ApiService _apiService;
  HomeRepo(this._apiService);

  // get banners
  Future<ApiResult<BannerResponseModel>> getBanners() async {
    try {
      final response = await _apiService.getBanners(
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}

import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/features/profile/data/models/get_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_profile_response_model.dart';
import 'package:future_app/features/profile/data/models/update_password_response_model.dart';
import 'dart:developer';

class ProfileRepo {
  final ApiService _apiService;
  ProfileRepo(this._apiService);

  // get profile
  Future<ApiResult<GetProfileResponseModel>> getProfile() async {
    try {
      final response = await _apiService.getProfile(
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // update profile
  Future<ApiResult<UpdateProfileResponseModel>> updateProfile(
    UpdateProfileRequestModel request,
  ) async {
    try {
      final response = await _apiService.updateProfile(
        request,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // update password
  Future<ApiResult<UpdatePasswordResponseModel>> updatePassword(
    UpdatePasswordRequestModel request,
  ) async {
    try {
      final response = await _apiService.updatePassword(
        request,
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

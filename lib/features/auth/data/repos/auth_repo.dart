import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/features/auth/data/models/login_request_model.dart';
import 'package:future_app/features/auth/data/models/login_response_model.dart';
import 'package:future_app/features/auth/data/models/register_request_model.dart';
import 'package:future_app/features/auth/data/models/register_response_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_request_model.dart';
import 'package:future_app/features/auth/data/models/register_step2_response_model.dart';

import '../../../../core/network/api_service.dart';
import 'dart:developer';

class AuthRepo {
  final ApiService _apiService;
  AuthRepo(this._apiService);

  // login
  Future<ApiResult<LoginResponseModel>> login(LoginRequestModel request) async {
    try {
      final response = await _apiService.login(
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

  // logout
  Future<ApiResult<void>> logout() async {
    try {
      final response = await _apiService.logout(
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // register step 1
  Future<ApiResult<RegisterResponseModel>> registerStep1(
      RegisterRequestModel request) async {
    try {
      final response = await _apiService.registerStep1(
        request,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // register step 2
  Future<ApiResult<RegisterStep2ResponseModel>> registerStep2(
      RegisterStep2RequestModel request) async {
    try {
      final response = await _apiService.registerStep2(
        request,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }
}

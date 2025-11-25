import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_error_model.dart';
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
      
      // Check if login was unsuccessful
      if (!response.success) {
        // Create error model from the response with the Arabic message
        return ApiResult.failure(
          ApiErrorModel(
            success: response.success,
            message: response.message,
            errors: null,
          ),
        );
      }
      
      return ApiResult.success(response);
    } on DioException catch (e) {
      // Handle DioException - might be a parsing error or network error
      log(e.toString());
      
      // If it's a bad response, try to extract error message from response data
      if (e.type == DioExceptionType.badResponse && e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic>) {
          // Check if this is a success: false response
          if (responseData['success'] == false) {
            final message = responseData['message'] ?? 'حدث خطأ غير متوقع';
            return ApiResult.failure(
              ApiErrorModel(
                success: false,
                message: message.toString(),
                errors: null,
              ),
            );
          }
        }
      }
      
      return ApiResult.failure(ApiErrorHandler.handle(e));
    } catch (e) {
      // Handle other exceptions (like parsing errors)
      log(e.toString());
      
      // If it's a parsing error, the original response might be in the exception
      // Try to extract it if possible
      if (e is DioException && e.response?.data != null) {
        final responseData = e.response!.data;
        if (responseData is Map<String, dynamic> && responseData['success'] == false) {
          final message = responseData['message'] ?? 'حدث خطأ غير متوقع';
          return ApiResult.failure(
            ApiErrorModel(
              success: false,
              message: message.toString(),
              errors: null,
            ),
          );
        }
      }
      
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

import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/network/api_error_handel.dart';
import 'package:future_app/core/network/api_result.dart';
import 'package:future_app/features/courses/data/models/quiz_models.dart';
import 'package:future_app/core/network/api_service.dart';
import 'dart:developer';

class QuizRepo {
  final ApiService _apiService;
  QuizRepo(this._apiService);

  // start quiz
  Future<ApiResult<StartQuizResponseModel>> startQuiz(String quizId) async {
    try {
      final response = await _apiService.startQuiz(
        quizId,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      return ApiResult.success(response);
    } catch (e) {
      log(e.toString());
      return ApiResult.failure(ApiErrorHandler.handle(e));
    }
  }

  // send quiz result
  Future<ApiResult<QuizResultResponseModel>> sendQuizResult(
    String quizId,
    QuizResultRequestModel request,
  ) async {
    try {
      final response = await _apiService.sendQuizResult(
        quizId,
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

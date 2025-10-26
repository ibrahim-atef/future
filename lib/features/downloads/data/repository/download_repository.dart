import 'package:dio/dio.dart';
import 'package:future_app/core/network/api_service.dart';
import 'package:future_app/core/network/api_constants.dart';
import 'package:future_app/core/models/download_model.dart';

abstract class DownloadRepository {
  Future<DownloadResponseModel> downloadLesson(String lessonId);
}

class DownloadRepositoryImpl implements DownloadRepository {
  final ApiService _apiService;

  DownloadRepositoryImpl(this._apiService);

  @override
  Future<DownloadResponseModel> downloadLesson(String lessonId) async {
    try {
      print('Downloading lesson with ID: $lessonId');
      final response = await _apiService.downloadLesson(
        lessonId,
        ApiConstants.apiKey,
        ApiConstants.appSource,
      );
      print('Download API response received successfully');
      return response;
    } catch (e) {
      print('Download API error: $e');
      // Check if it's a DioException with specific error message
      if (e is DioException) {
        String errorMessage = 'حدث خطأ أثناء التحميل';

        if (e.response?.data != null) {
          final responseData = e.response!.data;
          if (responseData is Map<String, dynamic>) {
            final message = responseData['message'] ??
                responseData['error'] ??
                responseData['error_message'];
            if (message != null && message.toString().isNotEmpty) {
              errorMessage = message.toString();
            }
          }
        }

        throw Exception(errorMessage);
      }
      rethrow;
    }
  }
}

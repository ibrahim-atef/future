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
      rethrow;
    }
  }
}

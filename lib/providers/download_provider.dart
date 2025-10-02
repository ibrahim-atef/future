// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io';
// import '../core/services/storage_service.dart';
// import '../core/models/lecture_model.dart';

// class DownloadProvider extends ChangeNotifier {
//   List<DownloadTask> _downloadTasks = [];
//   List<Map<String, dynamic>> _completedDownloads = [];
//   bool _isLoading = false;
//   String? _error;
//   bool _isWifiOnly = false;
//   String _downloadQuality = 'عالية الجودة';

//   List<DownloadTask> get downloadTasks => _downloadTasks;
//   List<Map<String, dynamic>> get completedDownloads => _completedDownloads;
//   bool get isLoading => _isLoading;
//   String? get error => _error;
//   bool get isWifiOnly => _isWifiOnly;
//   String get downloadQuality => _downloadQuality;

//   DownloadProvider() {
//     _initializeDownloads();
//   }

//   Future<void> _initializeDownloads() async {
//     _isWifiOnly = StorageService.isWifiOnly;
//     _downloadQuality = StorageService.downloadQuality;
//     _completedDownloads = StorageService.getAllDownloads();
//     notifyListeners();
//   }

//   Future<bool> downloadLecture(LectureModel lecture) async {
//     try {
//       // Check permissions
//       if (!await _checkPermissions()) {
//         _setError('يجب السماح بالوصول إلى التخزين');
//         return false;
//       }

//       // Check if already downloaded
//       if (_isAlreadyDownloaded(lecture.id)) {
//         _setError('تم تحميل هذا الملف مسبقاً');
//         return false;
//       }

//       // Check WiFi only setting
//       if (_isWifiOnly && !await _isConnectedToWifi()) {
//         _setError('يجب الاتصال بشبكة Wi-Fi للتحميل');
//         return false;
//       }

//       final url = lecture.contentUrl;
//       if (url.isEmpty) {
//         _setError('رابط التحميل غير متوفر');
//         return false;
//       }

//       final directory = await _getDownloadDirectory();
//       final fileName = _generateFileName(lecture);
//       final filePath = '${directory.path}/$fileName';

//       final taskId = await FlutterDownloader.enqueue(
//         url: url,
//         savedDir: directory.path,
//         fileName: fileName,
//         showNotification: true,
//         openFileFromNotification: true,
//         headers: {
//           'x-api-key': 'zDg3RLGdt0xOR1Kqhjw3iFiVLv5npnxFfb26dBWa4DcL4ByH6qH6DseVMf9l3Vcy',
//           'X-App-Source': 'anmka',
//         },
//       );

//       if (taskId != null) {
//         // Save download info
//         final downloadInfo = {
//           'id': lecture.id,
//           'taskId': taskId,
//           'title': lecture.title,
//           'type': lecture.type,
//           'courseId': lecture.courseId,
//           'filePath': filePath,
//           'url': url,
//           'downloadedAt': DateTime.now().toIso8601String(),
//         };

//         await StorageService.saveDownloadInfo(lecture.id, downloadInfo);
//         _completedDownloads.add(downloadInfo);
        
//         notifyListeners();
//         return true;
//       } else {
//         _setError('فشل في بدء التحميل');
//         return false;
//       }
//     } catch (e) {
//       _setError('حدث خطأ أثناء التحميل');
//       return false;
//     }
//   }

//   Future<void> downloadAllLectures(List<LectureModel> lectures) async {
//     _setLoading(true);
//     _clearError();

//     try {
//       for (final lecture in lectures) {
//         if (lecture.isDownloadable && !_isAlreadyDownloaded(lecture.id)) {
//           await downloadLecture(lecture);
//           // Add delay between downloads to avoid overwhelming the system
//           await Future.delayed(const Duration(seconds: 1));
//         }
//       }
//     } catch (e) {
//       _setError('حدث خطأ أثناء تحميل المحاضرات');
//     } finally {
//       _setLoading(false);
//     }
//   }

//   Future<void> pauseDownload(String taskId) async {
//     try {
//       await FlutterDownloader.pause(taskId: taskId);
//       notifyListeners();
//     } catch (e) {
//       _setError('فشل في إيقاف التحميل مؤقتاً');
//     }
//   }

//   Future<void> resumeDownload(String taskId) async {
//     try {
//       await FlutterDownloader.resume(taskId: taskId);
//       notifyListeners();
//     } catch (e) {
//       _setError('فشل في استئناف التحميل');
//     }
//   }

//   Future<void> cancelDownload(String taskId) async {
//     try {
//       await FlutterDownloader.cancel(taskId: taskId);
//       _removeDownloadInfo(taskId);
//       notifyListeners();
//     } catch (e) {
//       _setError('فشل في إلغاء التحميل');
//     }
//   }

//   Future<void> deleteDownload(String lectureId) async {
//     try {
//       final downloadInfo = _completedDownloads.firstWhere(
//         (download) => download['id'] == lectureId,
//         orElse: () => {},
//       );

//       if (downloadInfo.isNotEmpty) {
//         final filePath = downloadInfo['filePath'] as String;
//         final file = File(filePath);
        
//         if (await file.exists()) {
//           await file.delete();
//         }

//         await StorageService.removeDownloadInfo(lectureId);
//         _completedDownloads.removeWhere((download) => download['id'] == lectureId);
//         notifyListeners();
//       }
//     } catch (e) {
//       _setError('فشل في حذف الملف');
//     }
//   }

//   Future<void> clearAllDownloads() async {
//     try {
//       for (final download in _completedDownloads) {
//         final filePath = download['filePath'] as String;
//         final file = File(filePath);
        
//         if (await file.exists()) {
//           await file.delete();
//         }
//       }

//       await StorageService.clearAllDownloads();
//       _completedDownloads.clear();
//       notifyListeners();
//     } catch (e) {
//       _setError('فشل في مسح جميع التحميلات');
//     }
//   }

//   void setWifiOnly(bool value) {
//     _isWifiOnly = value;
//     StorageService.isWifiOnly = value;
//     notifyListeners();
//   }

//   void setDownloadQuality(String quality) {
//     _downloadQuality = quality;
//     StorageService.downloadQuality = quality;
//     notifyListeners();
//   }

//   bool _isAlreadyDownloaded(String lectureId) {
//     return _completedDownloads.any((download) => download['id'] == lectureId);
//   }

//   void _removeDownloadInfo(String taskId) {
//     _completedDownloads.removeWhere((download) => download['taskId'] == taskId);
//   }

//   Future<bool> _checkPermissions() async {
//     final status = await Permission.storage.request();
//     return status.isGranted;
//   }

//   Future<bool> _isConnectedToWifi() async {
//     // This is a simplified check - in a real app you'd use connectivity_plus
//     return true; // Placeholder
//   }

//   Future<Directory> _getDownloadDirectory() async {
//     final directory = await getExternalStorageDirectory();
//     final downloadDir = Directory('${directory!.path}/FutureApp/Downloads');
    
//     if (!await downloadDir.exists()) {
//       await downloadDir.create(recursive: true);
//     }
    
//     return downloadDir;
//   }

//   String _generateFileName(LectureModel lecture) {
//     final extension = _getFileExtension(lecture.type);
//     final sanitizedTitle = lecture.title.replaceAll(RegExp(r'[^\w\s-]'), '');
//     return '${sanitizedTitle}_${lecture.id}.$extension';
//   }

//   String _getFileExtension(String type) {
//     switch (type) {
//       case 'video':
//         return 'mp4';
//       case 'pdf':
//         return 'pdf';
//       case 'audio':
//         return 'mp3';
//       default:
//         return 'file';
//     }
//   }

//   void _setLoading(bool loading) {
//     _isLoading = loading;
//     notifyListeners();
//   }

//   void _setError(String error) {
//     _error = error;
//     notifyListeners();
//   }

//   void _clearError() {
//     _error = null;
//     notifyListeners();
//   }

//   void clearError() {
//     _clearError();
//   }
// }

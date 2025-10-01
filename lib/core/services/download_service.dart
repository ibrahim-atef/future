import 'dart:io';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'storage_service.dart';

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;
  DownloadService._internal();

  Future<void> init() async {
    await FlutterDownloader.initialize(debug: true);
    
    // Register callback for download updates
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @pragma('vm:entry-point')
  static void downloadCallback(String id, int status, int progress) {
    // Handle download status updates
    final downloadStatus = DownloadTaskStatus.values[status];
    
    // Update stored download info
    final downloadInfo = StorageService.getDownloadInfo(id);
    if (downloadInfo != null) {
      downloadInfo['status'] = downloadStatus.toString();
      downloadInfo['progress'] = progress;
      StorageService.saveDownloadInfo(id, downloadInfo);
    }
  }

  Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      final status = await Permission.storage.request();
      return status.isGranted;
    }
    return true; // iOS doesn't need storage permission for app directory
  }

  Future<String?> downloadFile({
    required String url,
    required String fileName,
    required String fileType,
    required String title,
    String? thumbnailUrl,
    String quality = 'عالية الجودة',
  }) async {
    try {
      // Check permissions
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        throw Exception('تحتاج إلى إذن الوصول للتخزين');
      }

      // Get download directory
      final directory = await getDownloadDirectory();
      if (directory == null) {
        throw Exception('لا يمكن الوصول لمجلد التحميل');
      }

      // Create subdirectories based on file type
      final typeDirectory = Directory('${directory.path}/$fileType');
      if (!await typeDirectory.exists()) {
        await typeDirectory.create(recursive: true);
      }

      // Check if file already exists
      final filePath = '${typeDirectory.path}/$fileName';
      final file = File(filePath);
      if (await file.exists()) {
        // File already downloaded
        return filePath;
      }

      // Start download
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: typeDirectory.path,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: true,
      );

      if (taskId != null) {
        // Save download info
        final downloadInfo = {
          'id': taskId,
          'title': title,
          'fileName': fileName,
          'fileType': fileType,
          'filePath': filePath,
          'thumbnailUrl': thumbnailUrl,
          'quality': quality,
          'status': DownloadTaskStatus.enqueued.toString(),
          'progress': 0,
          'downloadedAt': DateTime.now().toIso8601String(),
          'fileSize': 0, // Will be updated during download
        };

        await StorageService.saveDownloadInfo(taskId, downloadInfo);
        return taskId;
      }

      return null;
    } catch (e) {
      throw Exception('خطأ في التحميل: ${e.toString()}');
    }
  }

  Future<Directory?> getDownloadDirectory() async {
    if (Platform.isAndroid) {
      return await getExternalStorageDirectory();
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  Future<List<Map<String, dynamic>>> getDownloadedFiles() async {
    final downloads = StorageService.getAllDownloads();
    
    // Filter only completed downloads
    return downloads.where((download) {
      final status = download['status'] as String?;
      return status == DownloadTaskStatus.complete.toString();
    }).toList();
  }

  Future<List<Map<String, dynamic>>> getDownloadsByType(String fileType) async {
    final downloads = await getDownloadedFiles();
    return downloads.where((download) => download['fileType'] == fileType).toList();
  }

  Future<bool> deleteDownload(String downloadId) async {
    try {
      final downloadInfo = StorageService.getDownloadInfo(downloadId);
      if (downloadInfo != null) {
        final filePath = downloadInfo['filePath'] as String?;
        if (filePath != null) {
          final file = File(filePath);
          if (await file.exists()) {
            await file.delete();
          }
        }
        
        // Remove from storage
        await StorageService.removeDownloadInfo(downloadId);
        
        // Cancel download task if still running
        await FlutterDownloader.cancel(taskId: downloadId);
      }
      
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> clearAllDownloads() async {
    final downloads = StorageService.getAllDownloads();
    
    for (final download in downloads) {
      final downloadId = download['id'] as String?;
      if (downloadId != null) {
        await deleteDownload(downloadId);
      }
    }
    
    await StorageService.clearAllDownloads();
  }

  Future<int> getTotalDownloadSize() async {
    final downloads = await getDownloadedFiles();
    int totalSize = 0;
    
    for (final download in downloads) {
      final filePath = download['filePath'] as String?;
      if (filePath != null) {
        final file = File(filePath);
        if (await file.exists()) {
          final stat = await file.stat();
          totalSize += stat.size;
        }
      }
    }
    
    return totalSize;
  }

  String formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    if (bytes < 1024 * 1024 * 1024) return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    return '${(bytes / (1024 * 1024 * 1024)).toStringAsFixed(1)} GB';
  }

  Future<void> pauseDownload(String taskId) async {
    await FlutterDownloader.pause(taskId: taskId);
  }

  Future<void> resumeDownload(String taskId) async {
    await FlutterDownloader.resume(taskId: taskId);
  }

  Future<void> cancelDownload(String taskId) async {
    await FlutterDownloader.cancel(taskId: taskId);
    await StorageService.removeDownloadInfo(taskId);
  }
}



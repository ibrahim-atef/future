import 'dart:io';
import 'dart:math';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:future_app/core/models/download_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DownloadService {
  static final DownloadService _instance = DownloadService._internal();
  factory DownloadService() => _instance;
  DownloadService._internal();

  static Database? _database;
  static const String _tableName = 'downloaded_videos';

  // Initialize the download service
  Future<void> initialize() async {
    await _initializeDatabase();
    await _initializeDownloader();

    // Clean up any failed downloads on startup
    await cleanupFailedDownloads();
  }

  // Initialize flutter_downloader
  Future<void> _initializeDownloader() async {
    try {
      print('Setting up download service...');

      // Wait a bit to ensure flutter_downloader is fully initialized
      await Future.delayed(const Duration(milliseconds: 1000));

      // Register callback for download status updates (flutter_downloader already initialized in main.dart)
      FlutterDownloader.registerCallback(downloadCallback);

      print('Download service callback registered successfully');

      // Test the downloader by loading existing tasks
      final tasks = await FlutterDownloader.loadTasks();
      print('Found ${tasks?.length ?? 0} existing download tasks');
    } catch (e) {
      print('Error setting up download service: $e');
      // Don't retry initialization, just register callback
      try {
        FlutterDownloader.registerCallback(downloadCallback);
        print('Download service callback registered successfully on retry');
      } catch (e2) {
        print('Failed to register download callback: $e2');
        // Don't throw exception, just log the error
      }
    }
  }

  // Initialize local database for downloaded videos
  Future<void> _initializeDatabase() async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'downloaded_videos.db');

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE $_tableName(
            id TEXT PRIMARY KEY,
            lesson_id TEXT,
            course_id TEXT,
            title TEXT,
            description TEXT,
            video_url TEXT,
            local_path TEXT,
            file_size INTEGER,
            file_size_mb REAL,
            file_type TEXT,
            duration INTEGER,
            duration_text TEXT,
            video_source TEXT,
            downloaded_at TEXT,
            thumbnail_path TEXT
          )
          ''',
        );
      },
    );
  }

  // Request storage permission
  Future<bool> requestPermission() async {
    try {
      if (Platform.isAndroid) {
        // Check Android version for appropriate permissions
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        print('Android SDK version: ${androidInfo.version.sdkInt}');

        if (androidInfo.version.sdkInt >= 33) {
          // Android 13+ - Request media permissions
          print('Requesting Android 13+ media permissions');
          final videoStatus = await Permission.videos.request();
          final audioStatus = await Permission.audio.request();
          final photoStatus = await Permission.photos.request();

          print('Video permission: $videoStatus');
          print('Audio permission: $audioStatus');
          print('Photo permission: $photoStatus');

          final granted = videoStatus == PermissionStatus.granted ||
              audioStatus == PermissionStatus.granted ||
              photoStatus == PermissionStatus.granted;

          print('Media permissions granted: $granted');

          // Also try storage permission as fallback
          if (!granted) {
            print('Trying storage permission as fallback');
            final storageStatus = await Permission.storage.request();
            print('Storage permission: $storageStatus');
            return storageStatus == PermissionStatus.granted;
          }

          return granted;
        } else if (androidInfo.version.sdkInt >= 30) {
          // Android 11-12 - Request manage external storage
          print('Requesting manage external storage permission');
          final manageStorageStatus =
              await Permission.manageExternalStorage.request();
          print('Manage external storage: $manageStorageStatus');

          if (manageStorageStatus == PermissionStatus.granted) {
            return true;
          }

          // Fallback to regular storage permission
          print('Falling back to regular storage permission');
          final storageStatus = await Permission.storage.request();
          print('Storage permission: $storageStatus');
          return storageStatus == PermissionStatus.granted;
        } else {
          // Android 10 and below - Request storage permission
          print('Requesting Android 10- storage permission');
          final storageStatus = await Permission.storage.request();
          print('Storage permission: $storageStatus');
          return storageStatus == PermissionStatus.granted;
        }
      }
      print('iOS - no explicit permission needed for app documents');
      return true; // iOS doesn't need explicit permission for app documents
    } catch (e) {
      print('Error requesting permission: $e');
      // Try basic storage permission as last resort
      try {
        final storageStatus = await Permission.storage.request();
        print('Last resort storage permission: $storageStatus');
        return storageStatus == PermissionStatus.granted;
      } catch (e2) {
        print('Last resort permission also failed: $e2');
        return false;
      }
    }
  }

  // Download video
  Future<String?> downloadVideo(DownloadData downloadData) async {
    try {
      print('=== Starting download process ===');
      print('Lesson ID: ${downloadData.lessonId}');
      print('Video URL: ${downloadData.videoUrl}');
      print('File size: ${downloadData.fileSizeMb} MB');
      print('Downloadable: ${downloadData.downloadable}');

      // Validate input
      if (!downloadData.downloadable) {
        throw Exception('Video is not downloadable');
      }

      if (downloadData.videoUrl.isEmpty) {
        throw Exception('Video URL is empty');
      }

      // Request permission
      print('Requesting storage permissions...');
      final hasPermission = await requestPermission();
      if (!hasPermission) {
        print('Storage permission denied');
        throw Exception(
            'Storage permission denied. Please grant storage access to download videos.');
      }
      print('Storage permission granted');

      // Create downloads directory
      print('Setting up download directory...');
      final directory = await _getDownloadsDirectory();
      final fileName = _generateFileName(downloadData);
      final filePath = join(directory.path, fileName);

      print('Download directory: ${directory.path}');
      print('File name: $fileName');
      print('Full path: $filePath');

      // Test if directory is writable
      try {
        final testFile = File(join(directory.path, 'test_write.tmp'));
        await testFile.writeAsString('test');
        await testFile.delete();
        print('Directory is writable');
      } catch (e) {
        print('Directory is not writable: $e');
        throw Exception('Cannot write to download directory: $e');
      }

      // Ensure flutter_downloader is initialized before using it
      try {
        final tasks = await FlutterDownloader.loadTasks();
        print(
            'Flutter downloader is ready, found ${tasks?.length ?? 0} existing tasks');
      } catch (e) {
        print('Flutter downloader not ready, waiting...');
        await Future.delayed(const Duration(seconds: 2));
      }

      // Start download with proper headers
      print('Starting download with flutter_downloader...');
      final taskId = await FlutterDownloader.enqueue(
        url: downloadData.videoUrl,
        savedDir: directory.path,
        fileName: fileName,
        showNotification: true,
        openFileFromNotification: false,
        requiresStorageNotLow: false,
        saveInPublicStorage: true,
        headers: {
          'User-Agent':
              'Mozilla/5.0 (Linux; Android 10; SM-G973F) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.120 Mobile Safari/537.36',
          'Accept': '*/*',
          'Accept-Encoding': 'identity',
          'Connection': 'keep-alive',
          'Referer': 'https://future-team-law.com/',
        },
      );

      print('Download task ID: $taskId');

      if (taskId != null) {
        // Save download info to database immediately
        final downloadedVideo = DownloadedVideoModel(
          id: taskId,
          lessonId: downloadData.lessonId,
          courseId: downloadData.courseId,
          title: downloadData.title,
          description: downloadData.description,
          videoUrl: downloadData.videoUrl,
          localPath: filePath,
          fileSize: downloadData.fileSize,
          fileSizeMb: downloadData.fileSizeMb,
          fileType: downloadData.fileType,
          duration: downloadData.duration,
          durationText: downloadData.durationText,
          videoSource: downloadData.videoSource,
          downloadedAt: DateTime.now(),
          thumbnailPath: '', // TODO: Generate thumbnail
        );

        await _saveDownloadedVideo(downloadedVideo);
        print('Download info saved to database');
        print('=== Download started successfully ===');
        return taskId;
      } else {
        print('Failed to create download task - taskId is null');
        throw Exception(
            'Failed to create download task. Please check your internet connection and try again.');
      }
    } catch (e) {
      print('=== Download error ===');
      print('Error: $e');
      print('Error type: ${e.runtimeType}');
      if (e is Exception) {
        print('Exception message: ${e.toString()}');
      }
      throw Exception('Download failed: ${e.toString()}');
    }
  }

  // Generate unique filename for video
  String _generateFileName(DownloadData downloadData) {
    // Clean title for filename
    final cleanTitle = downloadData.title
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(RegExp(r'\s+'), '_')
        .toLowerCase();

    return '${downloadData.lessonId}_${cleanTitle}_${DateTime.now().millisecondsSinceEpoch}.mp4';
  }

  // Get downloads directory (private to the app)
  Future<Directory> _getDownloadsDirectory() async {
    try {
      // Try to get external storage directory first (more accessible)
      Directory? directory;

      if (Platform.isAndroid) {
        // For Android, try external storage first
        try {
          directory = await getExternalStorageDirectory();
          if (directory != null) {
            final downloadsDir =
                Directory(join(directory.path, 'Download', 'FutureApp'));
            if (!await downloadsDir.exists()) {
              await downloadsDir.create(recursive: true);
            }
            return downloadsDir;
          }
        } catch (e) {
          print(
              'External storage not available, falling back to app documents: $e');
        }
      }

      // Fallback to application documents directory
      directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(join(directory.path, 'downloaded_videos'));

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      return downloadsDir;
    } catch (e) {
      print('Error getting downloads directory: $e');
      // Ultimate fallback
      final directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(join(directory.path, 'downloaded_videos'));

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      return downloadsDir;
    }
  }

  // Save downloaded video info to database
  Future<void> _saveDownloadedVideo(DownloadedVideoModel video) async {
    await _database?.insert(
      _tableName,
      {
        'id': video.id,
        'lesson_id': video.lessonId,
        'course_id': video.courseId,
        'title': video.title,
        'description': video.description,
        'video_url': video.videoUrl,
        'local_path': video.localPath,
        'file_size': video.fileSize,
        'file_size_mb': video.fileSizeMb,
        'file_type': video.fileType,
        'duration': video.duration,
        'duration_text': video.durationText,
        'video_source': video.videoSource,
        'downloaded_at': video.downloadedAt.toIso8601String(),
        'thumbnail_path': video.thumbnailPath,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all downloaded videos (works offline)
  Future<List<DownloadedVideoModel>> getDownloadedVideos() async {
    try {
      print('Querying database for downloaded videos...');

      if (_database == null) {
        print('Database is null, initializing...');
        await _initializeDatabase();
      }

      final List<Map<String, dynamic>> maps =
          await _database?.query(_tableName) ?? [];

      print('Found ${maps.length} records in database');

      final List<DownloadedVideoModel> videos = [];

      for (final map in maps) {
        try {
          final video = DownloadedVideoModel(
            id: map['id'],
            lessonId: map['lesson_id'],
            courseId: map['course_id'],
            title: map['title'],
            description: map['description'],
            videoUrl: map['video_url'],
            localPath: map['local_path'],
            fileSize: map['file_size'],
            fileSizeMb: map['file_size_mb'],
            fileType: map['file_type'],
            duration: map['duration'],
            durationText: map['duration_text'],
            videoSource: map['video_source'],
            downloadedAt: DateTime.parse(map['downloaded_at']),
            thumbnailPath: map['thumbnail_path'],
          );

          // Only show videos that actually exist on device
          final file = File(video.localPath);
          if (await file.exists()) {
            videos.add(video);
            print('Added existing video: ${video.title}');
          } else {
            print('File not found, removing from database: ${video.localPath}');
            // Remove from database if file doesn't exist
            await _database
                ?.delete(_tableName, where: 'id = ?', whereArgs: [video.id]);
          }
        } catch (e) {
          print('Error processing video record: $e');
        }
      }

      // Sort by download date (newest first)
      videos.sort((a, b) => b.downloadedAt.compareTo(a.downloadedAt));

      print('Returning ${videos.length} videos');
      return videos;
    } catch (e) {
      print('Error getting downloaded videos: $e');
      return [];
    }
  }

  // Remove all sample videos from database
  Future<void> removeSampleVideos() async {
    try {
      print('Removing sample videos from database...');

      if (_database == null) {
        await _initializeDatabase();
      }

      // Delete all videos with sample IDs
      final result = await _database?.delete(
        _tableName,
        where: 'id LIKE ?',
        whereArgs: ['sample_%'],
      );

      print('Removed $result sample videos from database');
    } catch (e) {
      print('Error removing sample videos: $e');
    }
  }

  // Test download with specific video data from API response
  Future<String?> downloadTestVideo() async {
    const testDownloadData = DownloadData(
      lessonId: '42',
      courseId: '38',
      title: 'فيديو تجريبي للتحميل',
      description: 'هذا فيديو تجريبي لاختبار نظام التحميل',
      videoUrl:
          'https://future-team-law.com/wp-content/uploads/2025/10/VID-20240822-WA0001-1.mp4',
      fileSize: 23684943,
      fileSizeMb: 22.59,
      fileType: 'video/mp4',
      duration: 126,
      durationText: '2 دقيقة',
      downloadable: true,
      videoSource: 'server',
      downloadNote: 'هذا الفيديو متاح للتحميل والمشاهدة أوفلاين.',
    );

    return await downloadVideo(testDownloadData);
  }

  // Download video from API response data
  Future<String?> downloadVideoFromApiResponse(
      DownloadData downloadData) async {
    print(
        'Starting download from API response for lesson: ${downloadData.lessonId}');
    print('Video URL from API: ${downloadData.videoUrl}');
    print('File size: ${downloadData.fileSizeMb} MB');
    print('Downloadable: ${downloadData.downloadable}');
    print('Video source: ${downloadData.videoSource}');

    // Validate that the video is downloadable
    if (!downloadData.downloadable) {
      throw Exception('هذا الفيديو غير متاح للتحميل');
    }

    // Validate that we have a valid video URL
    if (downloadData.videoUrl.isEmpty) {
      throw Exception('رابط الفيديو غير صحيح');
    }

    // Check if video is already downloaded
    final isDownloaded = await isVideoDownloaded(downloadData.lessonId);
    if (isDownloaded) {
      throw Exception('تم تحميل هذا الفيديو مسبقاً');
    }

    return await downloadVideo(downloadData);
  }

  // Direct download using the specific video URL from your API response
  Future<String?> downloadSpecificVideo() async {
    print('Starting download for the specific video from API response');

    const specificVideoData = DownloadData(
      lessonId: '42',
      courseId: '38',
      title: 'test123',
      description: '<p>fdaf</p>',
      videoUrl:
          'https://future-team-law.com/wp-content/uploads/2025/10/VID-20240822-WA0001-1.mp4',
      fileSize: 23684943,
      fileSizeMb: 22.59,
      fileType: 'video/mp4',
      duration: 126,
      durationText: '2 دقيقة',
      downloadable: true,
      videoSource: 'server',
      downloadNote: 'هذا الفيديو متاح للتحميل والمشاهدة أوفلاين.',
    );

    print('Using video URL: ${specificVideoData.videoUrl}');
    print('File size: ${specificVideoData.fileSizeMb} MB');

    return await downloadVideoFromApiResponse(specificVideoData);
  }

  // Get download progress
  Future<DownloadTask?> getDownloadTask(String taskId) async {
    final tasks = await FlutterDownloader.loadTasks();
    return tasks?.firstWhere((task) => task.taskId == taskId);
  }

  // Update download status when completed
  Future<void> updateDownloadStatus(String taskId, int status) async {
    print('Updating download status for task $taskId: $status');

    try {
      if (status == DownloadTaskStatus.complete.index) {
        print('Download completed for task: $taskId');
        // Download completed successfully
        final task = await getDownloadTask(taskId);
        if (task != null && task.status == DownloadTaskStatus.complete) {
          final actualPath = '${task.savedDir}/${task.filename ?? ''}';
          print('Updating file path to: $actualPath');

          // Update the local path in database with actual downloaded file path
          await _database?.update(
            _tableName,
            {'local_path': actualPath},
            where: 'id = ?',
            whereArgs: [taskId],
          );
          print('Database updated successfully');
        }
      } else if (status == DownloadTaskStatus.failed.index) {
        print('Download failed for task: $taskId');
        // Download failed, remove from database
        await _database
            ?.delete(_tableName, where: 'id = ?', whereArgs: [taskId]);
        print('Removed failed download from database');
      } else if (status == DownloadTaskStatus.canceled.index) {
        print('Download canceled for task: $taskId');
        // Download canceled, remove from database
        await _database
            ?.delete(_tableName, where: 'id = ?', whereArgs: [taskId]);
        print('Removed canceled download from database');
      }
    } catch (e) {
      print('Error updating download status: $e');
    }
  }

  // Delete downloaded video
  Future<void> deleteDownloadedVideo(String taskId) async {
    try {
      // Remove from flutter_downloader
      await FlutterDownloader.remove(taskId: taskId, shouldDeleteContent: true);

      // Remove from database
      await _database?.delete(_tableName, where: 'id = ?', whereArgs: [taskId]);
    } catch (e) {
      throw Exception('Failed to delete video: $e');
    }
  }

  // Check if video is already downloaded
  Future<bool> isVideoDownloaded(String lessonId) async {
    final result = await _database?.query(
      _tableName,
      where: 'lesson_id = ?',
      whereArgs: [lessonId],
      limit: 1,
    );

    return result?.isNotEmpty ?? false;
  }

  // Check current permission status
  Future<bool> hasStoragePermission() async {
    if (Platform.isAndroid) {
      final androidInfo = await DeviceInfoPlugin().androidInfo;

      if (androidInfo.version.sdkInt >= 33) {
        // Android 13+ - Check media permissions
        final videoStatus = await Permission.videos.status;
        final audioStatus = await Permission.audio.status;
        final photoStatus = await Permission.photos.status;

        return videoStatus == PermissionStatus.granted ||
            audioStatus == PermissionStatus.granted ||
            photoStatus == PermissionStatus.granted;
      } else if (androidInfo.version.sdkInt >= 30) {
        // Android 11-12 - Check manage external storage
        final manageStorageStatus =
            await Permission.manageExternalStorage.status;
        if (manageStorageStatus == PermissionStatus.granted) {
          return true;
        }

        // Fallback to regular storage permission
        final storageStatus = await Permission.storage.status;
        return storageStatus == PermissionStatus.granted;
      } else {
        // Android 10 and below - Check storage permission
        final storageStatus = await Permission.storage.status;
        return storageStatus == PermissionStatus.granted;
      }
    }
    return true; // iOS doesn't need explicit permission for app documents
  }

  // Get local file path for downloaded video
  Future<String?> getLocalVideoPath(String lessonId) async {
    final result = await _database?.query(
      _tableName,
      columns: ['local_path'],
      where: 'lesson_id = ?',
      whereArgs: [lessonId],
      limit: 1,
    );

    if (result?.isNotEmpty ?? false) {
      final localPath = result!.first['local_path'] as String;
      final file = File(localPath);
      if (await file.exists()) {
        return localPath;
      }
    }
    return null;
  }

  // Check and clean up failed downloads
  Future<void> cleanupFailedDownloads() async {
    try {
      print('Checking for failed downloads...');

      // Wait a bit for flutter_downloader to be ready
      await Future.delayed(const Duration(milliseconds: 1000));

      final tasks = await FlutterDownloader.loadTasks();

      if (tasks != null) {
        print('Found ${tasks.length} download tasks');
        for (final task in tasks) {
          print(
              'Task ${task.taskId}: status=${task.status}, progress=${task.progress}');

          if (task.status == DownloadTaskStatus.failed) {
            print('Found failed download: ${task.taskId}');
            // Remove from database
            await _database
                ?.delete(_tableName, where: 'id = ?', whereArgs: [task.taskId]);
            print('Removed failed download from database: ${task.taskId}');
          } else if (task.status == DownloadTaskStatus.complete) {
            print('Found completed download: ${task.taskId}');
            // Update file path in database
            final actualPath = '${task.savedDir}/${task.filename ?? ''}';
            await _database?.update(
              _tableName,
              {'local_path': actualPath},
              where: 'id = ?',
              whereArgs: [task.taskId],
            );
            print('Updated completed download path: $actualPath');
          }
        }
      }
    } catch (e) {
      print('Error cleaning up downloads: $e');
    }
  }

  // Format file size
  String formatFileSize(int bytes) {
    if (bytes <= 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    final i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}';
  }

  // Download callback for status updates
  static void downloadCallback(String id, int status, int progress) {
    print('Download callback - ID: $id, Status: $status, Progress: $progress%');

    final downloadService = DownloadService();
    downloadService.updateDownloadStatus(id, status);
  }
}

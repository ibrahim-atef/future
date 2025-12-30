import 'dart:io';
import 'dart:math';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:future_app/core/models/download_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:future_app/core/services/download_manager.dart';

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
            course_title TEXT,
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
        final androidInfo = await DeviceInfoPlugin().androidInfo;
        final sdkInt = androidInfo.version.sdkInt;
        print('Android SDK version: $sdkInt');

        if (sdkInt >= 33) {
          print('Checking Android 13+ media permissions status');
          final videoStatus = await Permission.videos.status;
          final audioStatus = await Permission.audio.status;
          final photoStatus = await Permission.photos.status;

          print('Video permission status: $videoStatus');
          print('Audio permission status: $audioStatus');
          print('Photo permission status: $photoStatus');

          if (videoStatus == PermissionStatus.granted ||
              audioStatus == PermissionStatus.granted ||
              photoStatus == PermissionStatus.granted) {
            print('Media permissions already granted');
            return true;
          }

          print('Requesting Android 13+ media permissions');
          final videoStatusAfter = await Permission.videos.request();
          final audioStatusAfter = await Permission.audio.request();
          final photoStatusAfter = await Permission.photos.request();

          print('Video permission after request: $videoStatusAfter');
          print('Audio permission after request: $audioStatusAfter');
          print('Photo permission after request: $photoStatusAfter');

          final granted = videoStatusAfter == PermissionStatus.granted ||
              audioStatusAfter == PermissionStatus.granted ||
              photoStatusAfter == PermissionStatus.granted;

          print('Media permissions granted: $granted');
          return granted;
        } else if (sdkInt >= 30) {
          print('Checking manage external storage permission status');
          final manageStorageStatus =
              await Permission.manageExternalStorage.status;
          print('Manage external storage status: $manageStorageStatus');

          if (manageStorageStatus == PermissionStatus.granted) {
            print('Manage external storage already granted');
            return true;
          }

          final storageStatus = await Permission.storage.status;
          if (storageStatus == PermissionStatus.granted) {
            print('Storage permission already granted');
            return true;
          }

          print('Requesting manage external storage permission');
          final manageStorageStatusAfter =
              await Permission.manageExternalStorage.request();
          print(
              'Manage external storage after request: $manageStorageStatusAfter');

          if (manageStorageStatusAfter == PermissionStatus.granted) {
            return true;
          }

          print('Requesting regular storage permission');
          final storageStatusAfter = await Permission.storage.request();
          print('Storage permission after request: $storageStatusAfter');
          return storageStatusAfter == PermissionStatus.granted;
        } else {
          print('Checking Android 10- storage permission status');
          final storageStatus = await Permission.storage.status;
          print('Storage permission status: $storageStatus');

          if (storageStatus == PermissionStatus.granted) {
            print('Storage permission already granted');
            return true;
          }

          print('Requesting Android 10- storage permission');
          final storageStatusAfter = await Permission.storage.request();
          print('Storage permission after request: $storageStatusAfter');
          return storageStatusAfter == PermissionStatus.granted;
        }
      }
      print('iOS - no explicit permission needed for app documents');
      return true;
    } catch (e) {
      print('Error requesting permission: $e');
      return false;
    }
  }

  // Download video
  Future<String?> downloadVideo(
    DownloadData downloadData, {
    String? courseTitle,
  }) async {
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

      // Check permission first (without requesting)
      print('Checking storage permissions...');
      var hasPermission = await hasStoragePermission();
      if (!hasPermission) {
        // Only request if not already granted
        print('Storage permission not granted, requesting...');
        final granted = await requestPermission();
        if (!granted) {
          print('Storage permission denied, but will try to use app directory');
        } else {
          print('Storage permission granted after request');
          hasPermission = true;
        }
      } else {
        print('Storage permission already granted');
      }

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

      // Check if we're using app's private directory (doesn't need public storage)
      final appDocDir = await getApplicationDocumentsDirectory();
      final isPrivateDirectory = directory.path.startsWith(appDocDir.path);
      final shouldSaveInPublicStorage = hasPermission && !isPrivateDirectory;

      print('Using private directory: $isPrivateDirectory');
      print('Save in public storage: $shouldSaveInPublicStorage');

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
        saveInPublicStorage: shouldSaveInPublicStorage,
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
          courseTitle:
              courseTitle ?? 'كورس ${downloadData.courseId}', // عنوان الكورس
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
      Directory? directory;

      if (Platform.isAndroid) {
        // Check if we have permissions first
        final hasPermission = await hasStoragePermission();

        if (hasPermission) {
          // Try to get external storage directory (more accessible)
          try {
            directory = await getExternalStorageDirectory();
            if (directory != null) {
              // Try to create a subdirectory in Download folder
              final downloadsDir =
                  Directory(join(directory.path, 'Download', 'FutureApp'));
              try {
                if (!await downloadsDir.exists()) {
                  await downloadsDir.create(recursive: true);
                }
                // Test write access
                final testFile =
                    File(join(downloadsDir.path, 'test_write.tmp'));
                await testFile.writeAsString('test');
                await testFile.delete();
                print('Using external storage directory: ${downloadsDir.path}');
                return downloadsDir;
              } catch (e) {
                print('Cannot write to external Download folder: $e');
                // Fall through to use app's own directory
              }
            }
          } catch (e) {
            print(
                'External storage not available, falling back to app documents: $e');
          }
        }

        // Use app's own external directory (no permissions needed on Android 13+)
        // or app documents directory
        try {
          directory = await getExternalStorageDirectory();
          if (directory != null) {
            // Use app's own directory under external storage
            final downloadsDir =
                Directory(join(directory.path, 'downloaded_videos'));
            if (!await downloadsDir.exists()) {
              await downloadsDir.create(recursive: true);
            }
            print('Using app external directory: ${downloadsDir.path}');
            return downloadsDir;
          }
        } catch (e) {
          print('Cannot access external storage directory: $e');
        }
      }

      // Fallback to application documents directory (always works)
      directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(join(directory.path, 'downloaded_videos'));

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      print('Using app documents directory: ${downloadsDir.path}');
      return downloadsDir;
    } catch (e) {
      print('Error getting downloads directory: $e');
      // Ultimate fallback
      final directory = await getApplicationDocumentsDirectory();
      final downloadsDir = Directory(join(directory.path, 'downloaded_videos'));

      if (!await downloadsDir.exists()) {
        await downloadsDir.create(recursive: true);
      }

      print('Using ultimate fallback directory: ${downloadsDir.path}');
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
        'course_title': video.courseTitle,
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
            courseTitle: map['course_title'] ?? 'كورس ${map['course_id']}',
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
    DownloadData downloadData, {
    String? courseTitle,
  }) async {
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

    return await downloadVideo(
      downloadData,
      courseTitle: courseTitle,
    );
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
        // Android 13+ - Check media permissions first
        final videoStatus = await Permission.videos.status;
        final audioStatus = await Permission.audio.status;
        final photoStatus = await Permission.photos.status;

        final hasMediaPermission = videoStatus == PermissionStatus.granted ||
            audioStatus == PermissionStatus.granted ||
            photoStatus == PermissionStatus.granted;

        print('Android 13+: Media permissions granted: $hasMediaPermission');
        return hasMediaPermission;
      } else if (androidInfo.version.sdkInt >= 30) {
        // Android 11-12 - Check manage external storage
        final manageStorageStatus =
            await Permission.manageExternalStorage.status;
        if (manageStorageStatus == PermissionStatus.granted) {
          print('Android 11-12: Manage external storage granted');
          return true;
        }

        final storageStatus = await Permission.storage.status;
        final hasStoragePermission = storageStatus == PermissionStatus.granted;
        print(
            'Android 11-12: Storage permission granted: $hasStoragePermission');
        return hasStoragePermission;
      } else {
        // Android 10 and below - Check storage permission
        final storageStatus = await Permission.storage.status;
        final granted = storageStatus == PermissionStatus.granted;
        print('Android 10-: Storage permission granted: $granted');
        return granted;
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

  /// تحميل فيديو باستخدام DownloadManager (من Anmka-Creation)
  Future<String?> downloadVideoWithManager({
    required String videoUrl,
    required String lessonId,
    required String courseId,
    required String title,
    String? courseTitle,
    String? description,
    double? fileSizeMb,
    String? durationText,
    String? videoSource,
    Function(int progress)? onProgress,
  }) async {
    try {
      print('🎬 Starting video download with DownloadManager');
      print('Video URL: $videoUrl');
      print('Lesson ID: $lessonId');

      // إنشاء اسم ملف فريد
      String fileName =
          'video_${lessonId}_${DateTime.now().millisecondsSinceEpoch}.mp4';

      // تحميل الفيديو باستخدام DownloadManager
      String? localPath = await DownloadManager.download(
        videoUrl,
        name: fileName,
        onDownload: (progress) {
          print('Download progress: $progress%');
          // استدعاء callback التقدم إذا كان موجوداً
          if (onProgress != null) {
            onProgress(progress);
          }
        },
        isOpen: false,
      );

      if (localPath != null) {
        print('✅ Video downloaded successfully to: $localPath');

        // حفظ معلومات الفيديو في قاعدة البيانات
        String videoId = DateTime.now().millisecondsSinceEpoch.toString();

        await _database?.insert(
          _tableName,
          {
            'id': videoId,
            'lesson_id': lessonId,
            'course_id': courseId,
            'course_title':
                courseTitle ?? 'كورس $courseId', // تخزين عنوان الكورس الحقيقي
            'title': title,
            'description': description ?? '',
            'video_url': videoUrl,
            'local_path': localPath,
            'file_size': 0, // سيتم حسابه لاحقاً
            'file_size_mb': fileSizeMb ?? 0.0,
            'file_type': 'video/mp4',
            'duration': 0,
            'duration_text': durationText ?? '',
            'video_source': videoSource ?? 'server',
            'downloaded_at': DateTime.now().toIso8601String(),
            'thumbnail_path': '',
          },
        );

        print('✅ Video info saved to database');
        return videoId;
      } else {
        print('❌ Video download failed');
        return null;
      }
    } catch (e) {
      print('❌ Error downloading video with DownloadManager: $e');
      return null;
    }
  }

  /// تحميل فيديو من API response باستخدام DownloadManager
  Future<String?> downloadVideoFromApiResponseWithManager(
    DownloadData downloadData, {
    String? courseTitle,
    Function(int progress)? onProgress,
  }) async {
    return await downloadVideoWithManager(
      videoUrl: downloadData.videoUrl,
      lessonId: downloadData.lessonId,
      courseId: downloadData.courseId,
      title: downloadData.title,
      courseTitle: courseTitle,
      description: downloadData.description,
      fileSizeMb: downloadData.fileSizeMb,
      durationText: downloadData.durationText,
      videoSource: downloadData.videoSource,
      onProgress: onProgress,
    );
  }

  /// التحقق من وجود ملف محمل مسبقاً باستخدام DownloadManager
  Future<String?> checkLocalVideoFile(String lessonId) async {
    // البحث في قاعدة البيانات أولاً
    final result = await _database?.query(
      _tableName,
      where: 'lesson_id = ?',
      whereArgs: [lessonId],
      limit: 1,
    );

    if (result?.isNotEmpty ?? false) {
      final localPath = result!.first['local_path'] as String;

      // التحقق من وجود الملف فعلياً
      final file = File(localPath);
      if (await file.exists()) {
        print('✅ Local video file exists: $localPath');
        return localPath;
      } else {
        print('🚫 Local video file not found, cleaning database entry');
        // حذف السجل من قاعدة البيانات إذا كان الملف غير موجود
        await _database?.delete(
          _tableName,
          where: 'lesson_id = ?',
          whereArgs: [lessonId],
        );
      }
    }

    return null;
  }

  /// الحصول على جميع الفيديوهات المحملة مع التحقق من وجودها
  Future<List<DownloadedVideoModel>> getDownloadedVideosWithManager() async {
    try {
      print('Getting downloaded videos from database...');

      final results = await _database?.query(_tableName);

      if (results == null || results.isEmpty) {
        print('No downloaded videos found in database');
        return [];
      }

      print('Found ${results.length} videos in database');

      List<DownloadedVideoModel> videos = [];

      for (final row in results) {
        final localPath = row['local_path'] as String;
        final file = File(localPath);

        // التحقق من وجود الملف
        if (await file.exists()) {
          print('✅ Video file exists: $localPath');

          // حساب حجم الملف الفعلي
          int fileSize = await file.length();
          double fileSizeMb = fileSize / (1024 * 1024);

          videos.add(DownloadedVideoModel(
            id: row['id'] as String,
            lessonId: row['lesson_id'] as String,
            courseId: row['course_id'] as String,
            courseTitle:
                row['course_title'] as String? ?? 'كورس ${row['course_id']}',
            title: row['title'] as String,
            description: row['description'] as String,
            videoUrl: row['video_url'] as String,
            localPath: localPath,
            fileSize: fileSize,
            fileSizeMb: fileSizeMb,
            fileType: row['file_type'] as String,
            duration: row['duration'] as int,
            durationText: row['duration_text'] as String,
            videoSource: row['video_source'] as String,
            downloadedAt: DateTime.parse(row['downloaded_at'] as String),
            thumbnailPath: row['thumbnail_path'] as String? ?? '',
          ));
        } else {
          print('🚫 Video file not found, removing from database: $localPath');
          // حذف السجل إذا كان الملف غير موجود
          await _database?.delete(
            _tableName,
            where: 'id = ?',
            whereArgs: [row['id']],
          );
        }
      }

      print('Returning ${videos.length} valid videos');
      return videos;
    } catch (e) {
      print('Error getting downloaded videos: $e');
      return [];
    }
  }
}

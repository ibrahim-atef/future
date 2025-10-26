import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/downloads/data/repository/download_repository.dart';
import 'package:future_app/features/downloads/data/service/download_service.dart';
import 'package:future_app/features/downloads/logic/cubit/download_state.dart';
import 'package:future_app/core/models/download_model.dart';

class DownloadCubit extends Cubit<DownloadState> {
  final DownloadRepository _downloadRepository;
  final DownloadService _downloadService;

  DownloadCubit(this._downloadRepository, this._downloadService)
      : super(DownloadInitial());

  Future<void> downloadLesson(String lessonId) async {
    emit(DownloadLoading());
    try {
      // Check storage permission first
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        // Request permission
        final granted = await _downloadService.requestPermission();
        if (!granted) {
          emit(DownloadError('يجب منح صلاحيات التخزين لتحميل الفيديوهات'));
          return;
        }
      }

      // Get download info from API
      final response = await _downloadRepository.downloadLesson(lessonId);

      print('Download response received: ${response.success}');
      print('Download data: ${response.data.toJson()}');

      if (!response.data.downloadable) {
        emit(DownloadError('هذا الفيديو غير متاح للتحميل'));
        return;
      }

      // Check if already downloaded
      final isDownloaded = await _downloadService.isVideoDownloaded(lessonId);
      if (isDownloaded) {
        emit(DownloadError('تم تحميل هذا الفيديو مسبقاً'));
        return;
      }

      // Start actual download using API response data
      final taskId =
          await _downloadService.downloadVideoFromApiResponse(response.data);

      if (taskId != null) {
        emit(DownloadSuccess(response));
      } else {
        emit(DownloadError('فشل في بدء التحميل'));
      }
    } catch (e) {
      print('Download error: $e');
      String errorMessage = 'حدث خطأ أثناء التحميل';

      if (e is Exception) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = 'حدث خطأ أثناء التحميل: ${e.toString()}';
      }

      emit(DownloadError(errorMessage));
    }
  }

  Future<void> getDownloadedVideos() async {
    emit(GetDownloadedVideosLoading());
    try {
      print('Getting downloaded videos...');

      // Clean up failed downloads first
      await _downloadService.cleanupFailedDownloads();

      // This works offline - no network calls needed
      final videos = await _downloadService.getDownloadedVideos();
      print('Found ${videos.length} downloaded videos');

      for (final video in videos) {
        print('Video: ${video.title} - ${video.localPath}');
      }

      emit(GetDownloadedVideosSuccess(videos));
    } catch (e) {
      print('Error getting downloaded videos: $e');
      emit(GetDownloadedVideosError(
          'خطأ في تحميل قائمة الفيديوهات المحملة: $e'));
    }
  }

  Future<void> deleteDownloadedVideo(String taskId) async {
    try {
      await _downloadService.deleteDownloadedVideo(taskId);
      // Refresh the list
      await getDownloadedVideos();
    } catch (e) {
      emit(DownloadError('فشل في حذف الفيديو: $e'));
    }
  }

  Future<void> initializeDownloadService() async {
    try {
      await _downloadService.initialize();
      print('Download service initialized successfully');

      // Remove any existing sample videos
      await _downloadService.removeSampleVideos();
      print('Sample videos removed successfully');
    } catch (e) {
      print('Error initializing download service: $e');
      // Continue anyway, the service might still work
    }
  }

  // Test download functionality with the specific video from API response
  Future<void> testDownloadVideo() async {
    emit(DownloadLoading());
    try {
      // Check storage permission first
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        // Request permission
        final granted = await _downloadService.requestPermission();
        if (!granted) {
          emit(DownloadError('يجب منح صلاحيات التخزين لتحميل الفيديوهات'));
          return;
        }
      }

      final taskId = await _downloadService.downloadTestVideo();

      if (taskId != null) {
        // Create a dummy response model for success
        const dummyResponse = DownloadResponseModel(
          success: true,
          message: 'تم بدء التحميل بنجاح',
          data: DownloadData(
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
          ),
        );
        emit(DownloadSuccess(dummyResponse));
        // Refresh the downloads list
        await getDownloadedVideos();
      } else {
        emit(DownloadError('فشل في بدء التحميل'));
      }
    } catch (e) {
      emit(DownloadError(e.toString()));
    }
  }

  // Download the specific video using the exact URL from API response
  Future<void> downloadSpecificVideo() async {
    emit(DownloadLoading());
    try {
      // Check storage permission first
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        // Request permission
        final granted = await _downloadService.requestPermission();
        if (!granted) {
          emit(DownloadError('يجب منح صلاحيات التخزين لتحميل الفيديوهات'));
          return;
        }
      }

      final taskId = await _downloadService.downloadSpecificVideo();

      if (taskId != null) {
        // Create a dummy response model for success
        const dummyResponse = DownloadResponseModel(
          success: true,
          message: 'تم بدء تحميل الفيديو بنجاح',
          data: DownloadData(
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
          ),
        );
        emit(DownloadSuccess(dummyResponse));
        // Refresh the downloads list
        await getDownloadedVideos();
      } else {
        emit(DownloadError('فشل في بدء التحميل'));
      }
    } catch (e) {
      emit(DownloadError(e.toString()));
    }
  }

  // Check and request storage permissions
  Future<bool> checkStoragePermissions() async {
    try {
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        final granted = await _downloadService.requestPermission();
        return granted;
      }
      return true;
    } catch (e) {
      print('Error checking permissions: $e');
      return false;
    }
  }

  /// تحميل درس باستخدام DownloadManager (من Anmka-Creation)
  Future<void> downloadLessonWithManager(String lessonId) async {
    emit(DownloadLoading());
    try {
      // التحقق من الصلاحيات أولاً
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        final granted = await _downloadService.requestPermission();
        if (!granted) {
          emit(DownloadError('يجب منح صلاحيات التخزين لتحميل الفيديوهات'));
          return;
        }
      }

      // الحصول على معلومات التحميل من API
      final response = await _downloadRepository.downloadLesson(lessonId);

      print('Download response received: ${response.success}');
      print('Download data: ${response.data.toJson()}');

      if (!response.data.downloadable) {
        emit(DownloadError('هذا الفيديو غير متاح للتحميل'));
        return;
      }

      // التحقق من أن الفيديو لم يتم تحميله مسبقاً
      final localPath = await _downloadService.checkLocalVideoFile(lessonId);
      if (localPath != null) {
        emit(DownloadError('تم تحميل هذا الفيديو مسبقاً'));
        return;
      }

      // بدء التحميل باستخدام DownloadManager
      final videoId = await _downloadService
          .downloadVideoFromApiResponseWithManager(response.data);

      if (videoId != null) {
        emit(DownloadSuccess(response));
        // تحديث قائمة التحميلات
        await getDownloadedVideosWithManager();
      } else {
        emit(DownloadError('فشل في تحميل الفيديو'));
      }
    } catch (e) {
      print('Download error: $e');
      String errorMessage = 'حدث خطأ أثناء التحميل';

      if (e is Exception) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = 'حدث خطأ أثناء التحميل: ${e.toString()}';
      }

      emit(DownloadError(errorMessage));
    }
  }

  /// الحصول على الفيديوهات المحملة باستخدام DownloadManager
  Future<void> getDownloadedVideosWithManager() async {
    emit(GetDownloadedVideosLoading());
    try {
      print('Getting downloaded videos with DownloadManager...');

      // يعمل بدون اتصال بالإنترنت
      final videos = await _downloadService.getDownloadedVideosWithManager();
      print('Found ${videos.length} downloaded videos');

      for (final video in videos) {
        print('Video: ${video.title} - ${video.localPath}');
      }

      emit(GetDownloadedVideosSuccess(videos));
    } catch (e) {
      print('Error getting downloaded videos: $e');
      emit(GetDownloadedVideosError(
          'خطأ في تحميل قائمة الفيديوهات المحملة: $e'));
    }
  }

  /// تحميل فيديو تجريبي باستخدام DownloadManager
  Future<void> downloadSpecificVideoWithManager() async {
    emit(DownloadLoading());
    try {
      // التحقق من الصلاحيات
      final hasPermission = await _downloadService.hasStoragePermission();
      if (!hasPermission) {
        final granted = await _downloadService.requestPermission();
        if (!granted) {
          emit(DownloadError('يجب منح صلاحيات التخزين لتحميل الفيديوهات'));
          return;
        }
      }

      // تحميل الفيديو التجريبي
      final videoId = await _downloadService.downloadVideoWithManager(
        videoUrl:
            'https://future-team-law.com/wp-content/uploads/2025/10/VID-20240822-WA0001-1.mp4',
        lessonId: '42',
        courseId: '38',
        title: 'test123',
        description: 'فيديو تجريبي',
        fileSizeMb: 22.59,
        durationText: '2 دقيقة',
        videoSource: 'server',
      );

      if (videoId != null) {
        const dummyResponse = DownloadResponseModel(
          success: true,
          message: 'تم تحميل الفيديو بنجاح',
          data: DownloadData(
            lessonId: '42',
            courseId: '38',
            title: 'test123',
            description: '<p>فيديو تجريبي</p>',
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
          ),
        );
        emit(DownloadSuccess(dummyResponse));
        // تحديث قائمة التحميلات
        await getDownloadedVideosWithManager();
      } else {
        emit(DownloadError('فشل في تحميل الفيديو'));
      }
    } catch (e) {
      String errorMessage = 'حدث خطأ أثناء التحميل';

      if (e is Exception) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = 'حدث خطأ أثناء التحميل: ${e.toString()}';
      }

      emit(DownloadError(errorMessage));
    }
  }
}

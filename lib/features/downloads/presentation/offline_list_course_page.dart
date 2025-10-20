import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/courses/presentation/widgets/full_screen_video_player.dart';
import 'package:future_app/features/downloads/logic/cubit/download_cubit.dart';
import 'package:future_app/features/downloads/logic/cubit/download_state.dart';
import 'package:future_app/core/models/download_model.dart';
import 'package:video_player/video_player.dart';

class OfflineListCoursePage extends StatefulWidget {
  static const String pageName = '/offline-list-course';
  const OfflineListCoursePage({super.key, required this.isBackButton});
  final bool isBackButton;
  @override
  State<OfflineListCoursePage> createState() => _OfflineListCoursePageState();
}

class _OfflineListCoursePageState extends State<OfflineListCoursePage>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize download service and load downloaded videos
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('Initializing download service and loading videos...');
      await context.read<DownloadCubit>().initializeDownloadService();
      await context.read<DownloadCubit>().getDownloadedVideosWithManager();
      print('Download service initialization completed');
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      // Refresh downloads when app comes back to foreground
      context.read<DownloadCubit>().getDownloadedVideosWithManager();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: const Text(
          'الكورسات المحملة',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: widget.isBackButton
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
                onPressed: () => Navigator.pop(context),
              )
            : null,
        actions: [
          // IconButton(
          //   icon: const Icon(Icons.download, color: Color(0xFFd4af37)),
          //   tooltip: 'تحميل فيديو تجريبي',
          //   onPressed: () {
          //     _showDownloadDialog(context);
          //   },
          // ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFd4af37)),
            onPressed: () async {
              print('Manual refresh triggered');
              await context
                  .read<DownloadCubit>()
                  .getDownloadedVideosWithManager();
            },
          ),
        ],
      ),
      body: BlocConsumer<DownloadCubit, DownloadState>(
        listener: (context, state) {
          if (state is DownloadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('تم بدء التحميل بنجاح'),
                backgroundColor: const Color(0xFFd4af37),
                action: SnackBarAction(
                  label: 'عرض التحميلات',
                  textColor: Colors.white,
                  onPressed: () {
                    context
                        .read<DownloadCubit>()
                        .getDownloadedVideosWithManager();
                  },
                ),
              ),
            );
          } else if (state is DownloadError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetDownloadedVideosLoading) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
              ),
            );
          }

          if (state is GetDownloadedVideosError) {
            return _buildErrorState(state.message);
          }

          if (state is GetDownloadedVideosSuccess) {
            if (state.videos.isEmpty) {
              return _buildEmptyState();
            }

            // Display videos individually instead of grouping by course
            return _buildVideosList(state.videos);
          }

          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.offline_bolt,
              color: Color(0xFFd4af37),
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'الكورسات المحملة محلياً',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'لا توجد كورسات محملة حالياً',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'يمكنك تحميل الكورسات ومحتواها للوصول إليها بدون إنترنت',
              style: TextStyle(
                color: Colors.white60,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF2a2a2a),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: const Color(0xFFd4af37).withOpacity(0.3),
                ),
              ),
              child: const Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.download,
                        color: Color(0xFFd4af37),
                        size: 16,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'للتحميل:',
                        style: TextStyle(
                          color: Color(0xFFd4af37),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  Text(
                    '1. اذهب إلى الكورسات\n2. اختر الكورس المطلوب\n3. اضغط على أيقونة التحميل',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, '/courses');
              },
              icon: const Icon(Icons.school, color: Colors.black),
              label: const Text(
                'تصفح الكورسات',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 80,
            ),
            const SizedBox(height: 24),
            const Text(
              'خطأ في تحميل البيانات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<DownloadCubit>().getDownloadedVideosWithManager();
              },
              icon: const Icon(Icons.refresh, color: Colors.black),
              label: const Text(
                'إعادة المحاولة',
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideosList(List<DownloadedVideoModel> videos) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          // Header with offline indicator
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFd4af37).withOpacity(0.3),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.offline_bolt,
                  color: Color(0xFFd4af37),
                  size: 24,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'الفيديوهات المحملة محلياً - تعمل بدون إنترنت',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${videos.length}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Videos list
          ...videos.map((video) => _buildVideoItem(video)),
        ],
      ),
    );
  }

  Widget _buildVideoItem(DownloadedVideoModel video) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFd4af37).withOpacity(0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            // Navigate directly to full screen video player
            await _openFullScreenVideoPlayer(context, video);
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.play_circle_filled,
                    color: Color(0xFFd4af37),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            video.durationText,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.storage,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${video.fileSizeMb.toStringAsFixed(1)} MB',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(
                            Icons.school,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            video.courseTitle,
                            style: const TextStyle(
                              color: Color(0xFFd4af37),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Icon(
                            Icons.offline_bolt,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'أوفلاين',
                            style: TextStyle(
                              color: Color(0xFFd4af37),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.play_arrow,
                  color: Color(0xFFd4af37),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _openFullScreenVideoPlayer(
      BuildContext context, DownloadedVideoModel video) async {
    // إنشاء VideoPlayerController للفيديو المحلي
    final controller = VideoPlayerController.file(File(video.localPath));

    try {
      // تهيئة الفيديو
      await controller.initialize();

      // فتح شاشة كاملة
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FullScreenVideoPlayerWidget(
            controller,
            name: video.title,
          ),
        ),
      );

      // إعادة تعيين الاتجاه للعمودي عند العودة
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    } catch (error) {
      print('Error opening full screen video: $error');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في فتح الفيديو: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      // تنظيف الـ controller
      controller.dispose();
    }
  }

  void _showDownloadDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'تحميل فيديو تجريبي',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'هل تريد تحميل الفيديو التجريبي "test123"؟',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFd4af37).withOpacity(0.3),
                  ),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.video_settings,
                          color: Color(0xFFd4af37),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'الجودة المنخفضة',
                          style: TextStyle(
                            color: Color(0xFFd4af37),
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'حجم الملف: ~9 MB (بدلاً من 22.59 MB)',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'المدة: 2 دقيقة',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ملاحظة: تم تقليل حجم الملف بنسبة 60% لتوفير المساحة',
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'إلغاء',
                style: TextStyle(
                  color: Colors.white70,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                // استخدام DownloadManager للتحميل
                context
                    .read<DownloadCubit>()
                    .downloadSpecificVideoWithManager();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
              ),
              child: const Text('تحميل بحجم صغير'),
            ),
          ],
        );
      },
    );
  }
}

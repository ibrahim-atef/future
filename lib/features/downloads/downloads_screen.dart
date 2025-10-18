import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/downloads/logic/cubit/download_cubit.dart';
import 'package:future_app/features/downloads/logic/cubit/download_state.dart';
import 'package:future_app/core/models/download_model.dart';
import 'package:future_app/features/downloads/presentation/downloaded_video_player.dart';
import 'package:permission_handler/permission_handler.dart';

class DownloadsScreen extends StatefulWidget {
  const DownloadsScreen({super.key});

  @override
  State<DownloadsScreen> createState() => _DownloadsScreenState();
}

class _DownloadsScreenState extends State<DownloadsScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Initialize download service and load downloaded videos
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('Initializing download service and loading videos...');
      await context.read<DownloadCubit>().initializeDownloadService();
      await context.read<DownloadCubit>().getDownloadedVideos();
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
      context.read<DownloadCubit>().getDownloadedVideos();
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
          'التحميلات',
          style: TextStyle(
            color: Color(0xFFd4af37),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_all, color: Color(0xFFd4af37)),
            onPressed: () async {
              print('Removing sample videos...');
              await context.read<DownloadCubit>().initializeDownloadService();
              await context.read<DownloadCubit>().getDownloadedVideos();
            },
          ),
          IconButton(
            icon: const Icon(Icons.security, color: Color(0xFFd4af37)),
            onPressed: () {
              _checkPermissions(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.download, color: Color(0xFFd4af37)),
            onPressed: () {
              _showDownloadDialog(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Color(0xFFd4af37)),
            onPressed: () async {
              print('Manual refresh triggered');
              await context.read<DownloadCubit>().getDownloadedVideos();
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
                    context.read<DownloadCubit>().getDownloadedVideos();
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
          } else if (state is DownloadLoading) {
            // Show loading indicator for download
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Row(
                  children: [
                    SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
                        strokeWidth: 2,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text('جاري التحميل...'),
                  ],
                ),
                duration: Duration(seconds: 2),
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
                      'التحميلات المحلية',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'لا يمكن تحميل قائمة الفيديوهات المحملة',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton.icon(
                      onPressed: () {
                        context.read<DownloadCubit>().getDownloadedVideos();
                      },
                      icon: const Icon(Icons.refresh, color: Colors.black),
                      label: const Text(
                        'إعادة المحاولة',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFd4af37),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF2a2a2a),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFFd4af37).withOpacity(0.3),
                        ),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Color(0xFFd4af37),
                            size: 20,
                          ),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'تأكد من أن التطبيق لديه صلاحيات الوصول للتخزين المحلي',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is GetDownloadedVideosSuccess) {
            if (state.videos.isEmpty) {
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
                        'التحميلات المحلية',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      const Text(
                        'لا توجد فيديوهات محملة حالياً',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'يمكنك تحميل الفيديوهات من المحاضرات ومشاهدتها بدون إنترنت',
                        style: TextStyle(
                          color: Colors.white60,
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          // Navigate to courses screen
                          Navigator.pushNamed(context, '/courses');
                        },
                        icon:
                            const Icon(Icons.play_circle, color: Colors.black),
                        label: const Text(
                          'تصفح الكورسات',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFd4af37),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          _showDownloadDialog(context);
                        },
                        icon: const Icon(Icons.download,
                            color: Color(0xFFd4af37)),
                        label: const Text(
                          'تحميل تجريبي',
                          style: TextStyle(
                              color: Color(0xFFd4af37),
                              fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2a2a2a),
                          foregroundColor: const Color(0xFFd4af37),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Color(0xFFd4af37)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: const Color(0xFFd4af37).withOpacity(0.3),
                          ),
                        ),
                        child: const Row(
                          children: [
                            Icon(
                              Icons.info_outline,
                              color: Color(0xFFd4af37),
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'هذه الصفحة تعمل بدون إنترنت وتعرض الفيديوهات المحملة على الجهاز فقط',
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }

            return Column(
              children: [
                // Header with offline indicator
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(12),
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
                          'فيديوهات محملة محلياً - تعمل بدون إنترنت',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFd4af37),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${state.videos.length}',
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
                Expanded(
                  child: _buildDownloadedVideosList(state.videos),
                ),
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Trigger test download
          _showDownloadDialog(context);
        },
        backgroundColor: const Color(0xFFd4af37),
        child: const Icon(Icons.download, color: Colors.black),
      ),
    );
  }
}

Widget _buildDownloadedVideosList(List<DownloadedVideoModel> videos) {
  return ListView.builder(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    itemCount: videos.length,
    itemBuilder: (context, index) {
      final video = videos[index];
      return Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: const Color(0xFF2a2a2a),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => _playDownloadedVideo(context, video),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Video thumbnail/icon
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFFd4af37).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFd4af37).withOpacity(0.5),
                      ),
                    ),
                    child: Icon(
                      video.videoSource == 'youtube'
                          ? Icons.play_circle
                          : Icons.offline_bolt,
                      color: const Color(0xFFd4af37),
                      size: 18,
                    ),
                  ),
                  const SizedBox(width: 16),

                  // Video info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
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

                        // Duration and size
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              color: Color(0xFFd4af37),
                              size: 16,
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
                              size: 16,
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

                        // Download date and offline indicator
                        Row(
                          children: [
                            const Icon(
                              Icons.offline_bolt,
                              color: Color(0xFFd4af37),
                              size: 14,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              'محمل محلياً - ${_formatDate(video.downloadedAt)}',
                              style: const TextStyle(
                                color: Color(0xFFd4af37),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  // Play button and menu
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFd4af37),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: IconButton(
                          onPressed: () => _playDownloadedVideo(context, video),
                          icon: const Icon(
                            Icons.play_arrow,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      PopupMenuButton<String>(
                        icon: const Icon(
                          Icons.more_vert,
                          color: Color(0xFFd4af37),
                          size: 20,
                        ),
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'play',
                            child: Row(
                              children: [
                                Icon(Icons.play_arrow,
                                    color: Color(0xFFd4af37), size: 18),
                                SizedBox(width: 8),
                                Text('تشغيل'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 18),
                                SizedBox(width: 8),
                                Text('حذف'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'play') {
                            _playDownloadedVideo(context, video);
                          } else if (value == 'delete') {
                            _showDeleteDialog(context, video);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );
}

void _playDownloadedVideo(BuildContext context, DownloadedVideoModel video) {
  // Navigate to video player with local file
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => DownloadedVideoPlayer(
        videoPath: video.localPath,
        videoTitle: video.title,
      ),
    ),
  );
}

void _showDeleteDialog(BuildContext context, DownloadedVideoModel video) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: const Color(0xFF2a2a2a),
        title: const Text(
          'حذف الفيديو',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'هل أنت متأكد من حذف "${video.title}"؟',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 16,
          ),
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
              context.read<DownloadCubit>().deleteDownloadedVideo(video.id);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('حذف'),
          ),
        ],
      );
    },
  );
}

String _formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inDays > 0) {
    return '${difference.inDays} يوم مضى';
  } else if (difference.inHours > 0) {
    return '${difference.inHours} ساعة مضت';
  } else if (difference.inMinutes > 0) {
    return '${difference.inMinutes} دقيقة مضت';
  } else {
    return 'الآن';
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
              context.read<DownloadCubit>().downloadSpecificVideo();
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

void _checkPermissions(BuildContext context) async {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return const AlertDialog(
        backgroundColor: Color(0xFF2a2a2a),
        content: Row(
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
            ),
            SizedBox(width: 16),
            Text(
              'جاري التحقق من الصلاحيات...',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    },
  );

  try {
    final hasPermission =
        await context.read<DownloadCubit>().checkStoragePermissions();
    Navigator.pop(context); // Close loading dialog

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: Row(
            children: [
              Icon(
                hasPermission ? Icons.check_circle : Icons.error,
                color: hasPermission ? Colors.green : Colors.red,
                size: 28,
              ),
              const SizedBox(width: 12),
              Text(
                hasPermission ? 'الصلاحيات متاحة' : 'مشكلة في الصلاحيات',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            hasPermission
                ? 'تم منح جميع الصلاحيات المطلوبة للتحميل.\nيمكنك الآن تحميل الفيديوهات.'
                : 'يجب منح صلاحيات التخزين لتحميل الفيديوهات.\nيرجى الذهاب لإعدادات التطبيق ومنح الصلاحيات.',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
          actions: [
            if (!hasPermission)
              TextButton(
                onPressed: () async {
                  Navigator.pop(context);
                  await openAppSettings();
                },
                child: const Text(
                  'فتح الإعدادات',
                  style: TextStyle(
                    color: Color(0xFFd4af37),
                  ),
                ),
              ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    hasPermission ? const Color(0xFFd4af37) : Colors.red,
                foregroundColor: Colors.black,
              ),
              child: Text(hasPermission ? 'موافق' : 'إغلاق'),
            ),
          ],
        );
      },
    );
  } catch (e) {
    Navigator.pop(context); // Close loading dialog
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('خطأ في التحقق من الصلاحيات: $e'),
        backgroundColor: Colors.red,
      ),
    );
  }
}



/*
 downloader course flow : 
 download api :  GET /wp-json/tutor-api/v1/lessons/{lesson_id}/download
download response model : 
{
  "success": true,
  "message": "تم جلب بيانات الفيديو بنجاح.",
  "data": {
    "lesson_id": "42",
    "course_id": "38",
    "title": "test123",
    "description": "<p>fdaf</p>",
    "video_url": "https://future-team-law.com/wp-content/uploads/2025/10/VID-20240822-WA0001-1.mp4",
    "file_size": 23684943,
    "file_size_mb": 22.59,
    "file_type": "video/mp4",
    "duration": 126,
    "duration_text": "2 دقيقة",
    "downloadable": true,
    "video_source": "server",
    "download_note": "هذا الفيديو متاح للتحميل والمشاهدة أوفلاين."
  }
}
..........

لما يتم التحميل حمل الفيديو علي الجهاز واعرضو في صفحه 
path : lib\features\downloads\downloads_screen.dart
اتاكد ان الفيديو ميتسجلش في ملفات الفون بحيث ميوصلش للفديويهات غير من الابلكيشن 

*/
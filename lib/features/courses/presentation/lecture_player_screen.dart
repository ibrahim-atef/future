import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/features/courses/logic/cubit/courses_cubit.dart';
import 'package:future_app/features/courses/logic/cubit/courses_state.dart';
import 'package:future_app/features/courses/presentation/quiz_screen.dart';
import 'package:future_app/features/courses/presentation/widgets/course_video_player.dart';
import 'package:future_app/features/courses/presentation/widgets/pod_video_player.dart';
import 'package:future_app/features/courses/presentation/widgets/pdf_viewer_widget.dart';
import 'package:future_app/features/courses/presentation/assignment_screen.dart';
import 'package:future_app/features/downloads/logic/cubit/download_cubit.dart';
import 'package:future_app/features/downloads/logic/cubit/download_state.dart';
import 'package:url_launcher/url_launcher.dart';

class LecturePlayerScreen extends StatefulWidget {
  final String courseId;
  final String courseTitle;
  final String? videoUrl;
  final String? videoType; // 'youtube' or 'server'

  const LecturePlayerScreen({
    super.key,
    required this.courseId,
    required this.courseTitle,
    this.videoUrl,
    this.videoType,
  });

  @override
  State<LecturePlayerScreen> createState() => _LecturePlayerScreenState();
}

class _LecturePlayerScreenState extends State<LecturePlayerScreen> {
  bool _isLoading = true;
  String? _currentVideoUrl;
  String? _currentVideoType;
  String? _currentLectureId;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    // Initialize with widget data if available
    if (widget.videoType != null && widget.videoUrl != null) {
      _currentVideoUrl = widget.videoUrl;
      _currentVideoType = widget.videoType;
      _loadVideo(widget.videoUrl!, widget.videoType!);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _loadVideo(String videoUrl, String videoType, {String? lectureId}) {
    print(
        '🎥 Loading video: url=$videoUrl, type=$videoType, lectureId=$lectureId');
    setState(() {
      _isLoading = false; // New widgets handle their own loading
      _currentVideoUrl = videoUrl;
      _currentVideoType = videoType;
      _currentLectureId = lectureId;
    });
    print(
        '🎥 Video loaded: _currentVideoUrl=$_currentVideoUrl, _currentVideoType=$_currentVideoType');
  }

  /// Extract YouTube video ID from various URL formats
  /// Supports: youtube.com/watch?v=, youtube.com/embed/, youtu.be/, etc.
  String? _extractYouTubeVideoId(String url) {
    if (url.isEmpty) return null;

    // Remove any leading/trailing whitespace
    url = url.trim();

    // Handle youtu.be short URLs (e.g., https://youtu.be/KHsWKJZlxGE?si=...)
    final youtuBeRegExp = RegExp(
      r'youtu\.be\/([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    var match = youtuBeRegExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }

    // Handle youtube.com/watch?v= format
    final watchRegExp = RegExp(
      r'(?:youtube\.com\/watch\?v=|youtube\.com\/v\/|youtube\.com\/embed\/)([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    match = watchRegExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }

    // Fallback: try to extract any 11-character alphanumeric string after youtu.be or youtube.com
    final fallbackRegExp = RegExp(
      r'(?:youtube\.com\/|youtu\.be\/).*?([a-zA-Z0-9_-]{11})',
      caseSensitive: false,
    );
    match = fallbackRegExp.firstMatch(url);
    if (match != null && match.groupCount >= 1) {
      return match.group(1);
    }

    return null;
  }

  /// Clean YouTube URL by extracting video ID and returning a standard format
  String? _cleanYouTubeUrl(String url) {
    final videoId = _extractYouTubeVideoId(url);
    if (videoId != null) {
      return 'https://www.youtube.com/watch?v=$videoId';
    }
    return url;
  }

  String _getYouTubeEmbedUrl(String videoId) {
    return 'https://www.youtube.com/embed/$videoId?autoplay=0&controls=1&showinfo=1&rel=0&modestbranding=1&enablejsapi=1';
  }

  bool _isValidYouTubeUrl(String url) {
    return _extractYouTubeVideoId(url) != null;
  }

  Future<void> _openYouTubeVideo() async {
    if (_currentVideoUrl == null) return;

    // Clean the URL before opening
    final cleanedUrl = _cleanYouTubeUrl(_currentVideoUrl!);
    final urlToOpen = cleanedUrl ?? _currentVideoUrl!;

    try {
      final Uri url = Uri.parse(urlToOpen);
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('لا يمكن فتح الفيديو'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('خطأ في فتح الفيديو: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  // Helper function to format duration
  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  // Helper function to extract PDF URL from HTML href attribute
  String? _extractPdfUrlFromHtml(String? htmlContent) {
    if (htmlContent == null || htmlContent.isEmpty) {
      return null;
    }

    // Try to extract href from <a> tag
    // Pattern matches: href="..." or href='...'
    final RegExp hrefRegExpWithDoubleQuote = RegExp(
      r'href="([^"]+)"',
      caseSensitive: false,
    );

    final RegExp hrefRegExpWithSingleQuote = RegExp(
      r"href='([^']+)'",
      caseSensitive: false,
    );

    // Try double quotes first
    var match = hrefRegExpWithDoubleQuote.firstMatch(htmlContent);
    if (match != null && match.groupCount >= 1) {
      final url = match.group(1);
      if (url != null && url.isNotEmpty) {
        return url;
      }
    }

    // Try single quotes
    match = hrefRegExpWithSingleQuote.firstMatch(htmlContent);
    if (match != null && match.groupCount >= 1) {
      final url = match.group(1);
      if (url != null && url.isNotEmpty) {
        return url;
      }
    }

    return null;
  }

  // Enter fullscreen mode
  void _enterFullScreen() {
    if (_currentVideoType == 'youtube' && _currentVideoUrl != null) {
      // For YouTube videos, the fullscreen is handled by PodVideoPlayerDev internally
      return;
    } else if (_currentVideoType == 'server' || _currentVideoType == 'video') {
      // For server videos, use the CourseVideoPlayer's built-in fullscreen functionality
      // The fullscreen is handled internally by CourseVideoPlayer
      return;
    }
  }

  // Exit fullscreen mode
  void _exitFullScreen() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  // Build download button
  Widget _buildDownloadButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFd4af37),
            const Color(0xFFd4af37).withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _handleDownload,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.download,
                  color: Colors.black,
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  _getDownloadButtonText(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getDownloadButtonText() {
    if (_currentVideoType == 'youtube') {
      return 'حمل الفيديو من يوتيوب';
    } else {
      return 'حمل المحاضرة أوفلاين';
    }
  }

  void _handleDownload() {
    if (_currentVideoType == 'youtube') {
      _downloadYouTubeVideo();
    } else {
      _downloadServerVideo();
    }
  }

  void _downloadYouTubeVideo() {
    // For YouTube videos, we can only open the URL
    if (_currentVideoUrl != null) {
      _openYouTubeVideo();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('سيتم فتح الفيديو في يوتيوب للتحميل'),
          backgroundColor: Color(0xFFd4af37),
        ),
      );
    }
  }

  void _downloadPDF_DELETED() {
    if (_currentVideoUrl == null) return;

    // Show download dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'حفظ الملف',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'هل تريد حفظ هذا الملف على الجهاز؟',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFd4af37).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFFd4af37),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'سيتم حفظ الملف في مجلد التحميلات',
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
                _startPDFDownload();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'حفظ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _startPDFDownload() {
    if (_currentVideoUrl == null) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Color(0xFF2a2a2a),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
              ),
              SizedBox(height: 16),
              Text(
                'جاري حفظ الملف...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'قد تستغرق العملية بضع دقائق',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        );
      },
    );

    // Start PDF download
    _downloadPDFFile();
  }

  Future<void> _downloadPDFFile() async {
    try {
      // This will be handled by the PDFViewerWidget
      // The PDFViewerWidget already has download functionality
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.white,
                size: 20,
              ),
              SizedBox(width: 8),
              Text('تم بدء تحميل الملف بنجاح'),
            ],
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 3),
        ),
      );
    } catch (e) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.error,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(child: Text('خطأ في تحميل الملف: ${e.toString()}')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _downloadServerVideo() {
    if (_currentVideoUrl == null) return;

    // Show download dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'تحميل الفيديو',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'هل تريد تحميل هذا الفيديو للاستخدام أوفلاين؟',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF1a1a1a),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: const Color(0xFFd4af37).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Color(0xFFd4af37),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'سيتم حفظ الفيديو في مجلد التحميلات',
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
                _startDownload();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'تحميل',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _startDownload() {
    if (_currentVideoUrl == null) return;

    // Show loading dialog with BlocProvider
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return BlocProvider(
          create: (context) => getIt<DownloadCubit>(),
          child: BlocConsumer<DownloadCubit, DownloadState>(
            listener: (context, state) {
              if (state is DownloadSuccess) {
                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text('تم بدء تحميل الفيديو بنجاح'),
                      ],
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 3),
                  ),
                );
                // Refresh the downloads list
                context.read<DownloadCubit>().getDownloadedVideosWithManager();
              } else if (state is DownloadError) {
                Navigator.pop(context); // Close loading dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        const Icon(
                          Icons.error,
                          color: Colors.white,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(child: Text(state.message)),
                      ],
                    ),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 3),
                  ),
                );
              }
            },
            builder: (context, state) {
              // Start the actual download when the cubit is created
              if (state is DownloadInitial && _currentLectureId != null) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  context
                      .read<DownloadCubit>()
                      .downloadLessonWithManager(_currentLectureId!);
                });
              }

              // Show progress if download is in progress
              if (state is DownloadInProgress) {
                return AlertDialog(
                  backgroundColor: const Color(0xFF2a2a2a),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: state.progress / 100.0,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  Color(0xFFd4af37)),
                              backgroundColor: Colors.white.withOpacity(0.1),
                              strokeWidth: 8,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              '${state.progress}%',
                              style: const TextStyle(
                                color: Color(0xFFd4af37),
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        state.message ?? 'جاري التحميل... ${state.progress}%',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'قد تستغرق العملية بضع دقائق',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }

              // Default loading state
              return const AlertDialog(
                backgroundColor: Color(0xFF2a2a2a),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'جاري تحضير التحميل...',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'قد تستغرق العملية بضع دقائق',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );

    // If no lecture ID is available, show error
    if (_currentLectureId == null) {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('خطأ: لا يمكن تحديد معرف المحاضرة'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<CoursesCubit>()..getCourseContent(widget.courseId),
      child: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFF1a1a1a),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () {
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => BlocProvider(
            //           create: (context) => getIt<ChatCubit>(),
            //           child: CourseChatScreen(
            //             courseId: widget.courseId,
            //             courseTitle: widget.courseTitle,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   backgroundColor: const Color(0xFFd4af37),
            //   child: const Icon(
            //     Icons.chat,
            //     color: Colors.black,
            //   ),
            // ),
            appBar: AppBar(
              backgroundColor: const Color(0xFF1a1a1a),
              elevation: 0,
              title: Text(
                _currentVideoUrl != null
                    ? '${widget.courseTitle} - تشغيل'
                    : widget.courseTitle,
                style: const TextStyle(
                  color: Color(0xFFd4af37),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  // Video Player Section
                  Container(
                    width: double.infinity,
                    color: Colors.black,
                    child: _buildVideoPlayer(),
                  ),

                  // Course Info
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.courseTitle,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'محتوى تعليمي متقدم',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Content Type Info
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: const Color(0xFFd4af37).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _currentVideoType == 'youtube'
                                    ? Icons.play_circle
                                    : _currentVideoType == 'pdf' ||
                                            _currentVideoType == 'assignment'
                                        ? Icons.picture_as_pdf
                                        : Icons.video_library,
                                color: const Color(0xFFd4af37),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                _currentVideoType == 'youtube'
                                    ? 'فيديو من يوتيوب'
                                    : _currentVideoType == 'pdf' ||
                                            _currentVideoType == 'assignment'
                                        ? 'ملف PDF'
                                        : 'فيديو من الخادم',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Lecture List
                        const Text(
                          'قائمة المحاضرات',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),

                        _buildLectureList(state),
                        const SizedBox(height: 12),

                        // Download button - only show when content is loaded and lecture ID is available
                        if (_currentVideoUrl != null &&
                            _currentVideoType != null &&
                            _currentLectureId != null)
                          _currentVideoType == 'youtube'
                              ? const SizedBox.shrink()
                              : _buildDownloadButton(),

                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildVideoPlayer() {
    print(
        '🎬 Building video player: _isLoading=$_isLoading, _currentVideoType=$_currentVideoType, _currentVideoUrl=$_currentVideoUrl');

    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
        ),
      );
    }

    if (_currentVideoType == 'youtube' && _currentVideoUrl != null) {
      // Clean YouTube URL to handle youtu.be and other formats
      final cleanedUrl = _cleanYouTubeUrl(_currentVideoUrl!);
      final videoId = _extractYouTubeVideoId(_currentVideoUrl!);
      print(
          '📺 YouTube video: originalUrl=$_currentVideoUrl, cleanedUrl=$cleanedUrl, videoId=$videoId');

      if (videoId == null) {
        print('❌ Failed to extract YouTube video ID from: $_currentVideoUrl');
        return Container(
          height: 250,
          color: Colors.black,
          child: const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 48),
                SizedBox(height: 16),
                Text(
                  'خطأ في رابط يوتيوب',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ],
            ),
          ),
        );
      }

      // Use PodVideoPlayerDev for YouTube videos
      return PodVideoPlayerDev(
        cleanedUrl ?? _currentVideoUrl!,
        'youtube',
        name: widget.courseTitle,
        key: ValueKey(
            cleanedUrl ?? _currentVideoUrl), // Add unique key to force rebuild
      );
    } else if ((_currentVideoType == 'server' ||
            _currentVideoType == 'video') &&
        _currentVideoUrl != null) {
      // Use CourseVideoPlayer for server videos
      return CourseVideoPlayer(
        _currentVideoUrl!,
        '', // imageCover - empty for now
        name: UserConstant.userName ?? "",
        isLoadNetwork: true,
        key: ValueKey(_currentVideoUrl), // Add unique key to force rebuild
      );
    } else {
      return _buildNoVideoWidget();
    }
  }

  Widget _buildErrorWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        border: Border.all(
          color: Colors.red.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red,
          ),
          SizedBox(height: 16),
          Text(
            'خطأ في تحميل الفيديو',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'تأكد من اتصال الإنترنت',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoVideoWidget() {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFd4af37).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.video_library_outlined,
              color: Color(0xFFd4af37),
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'اختر محاضرة لعرض الفيديو',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'اضغط على أي محاضرة من القائمة أدناه',
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLectureList(CoursesState state) {
    if (state is GetCourseContentLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
        ),
      );
    }

    if (state is GetCourseContentError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            const SizedBox(height: 16),
            const Text(
              'خطأ في تحميل المحاضرات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              state.apiErrorModel.message,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (state is GetCourseContentSuccess) {
      final lectures = state.data.data.lectures;

      if (lectures.isEmpty) {
        return const Center(
          child: Text(
            'لا توجد محاضرات متاحة',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        );
      }

      // Group lectures by module
      final Map<String, List<dynamic>> groupedLectures = {};
      for (var lecture in lectures) {
        final module =
            lecture.module.isNotEmpty == true ? lecture.module : 'بدون وحدة';
        if (!groupedLectures.containsKey(module)) {
          groupedLectures[module] = [];
        }
        groupedLectures[module]!.add(lecture);
      }

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: groupedLectures.length,
        itemBuilder: (context, moduleIndex) {
          final moduleKey = groupedLectures.keys.elementAt(moduleIndex);
          final moduleLectures = groupedLectures[moduleKey]!;

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: const Color(0xFFd4af37).withOpacity(0.3),
                width: 1,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Module Header
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37).withOpacity(0.1),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.folder_open,
                        color: Color(0xFFd4af37),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          moduleKey,
                          style: const TextStyle(
                            color: Color(0xFFd4af37),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        '${moduleLectures.length} محاضرة',
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                // Lectures in this module
                ...moduleLectures.map((lecture) {
                  return Container(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF1a1a1a),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFFd4af37).withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: ListTile(
                      leading: Icon(
                        lecture.type == 'youtube'
                            ? Icons.play_circle
                            : lecture.type == 'quiz'
                                ? Icons.quiz
                                : lecture.type == 'pdf'
                                    ? Icons.picture_as_pdf
                                    : lecture.type == 'assignment'
                                        ? Icons.assignment
                                        : Icons.video_library,
                        color: const Color(0xFFd4af37),
                      ),
                      title: Text(
                        lecture.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   lecture.durationTextFromApi?.isNotEmpty == true
                          //       ? lecture.durationTextFromApi!
                          //       : lecture.durationText,
                          //   style: const TextStyle(
                          //     color: Colors.white70,
                          //     fontSize: 12,
                          //   ),
                          // ),
                          if (lecture.week?.isNotEmpty == true)
                            Text(
                              lecture.week!,
                              style: const TextStyle(
                                color: Color(0xFFd4af37),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.play_arrow,
                        color: Color(0xFFd4af37),
                      ),
                      onTap: () {
                        // Handle lecture tap - Load content
                        if (lecture.type == 'quiz') {
                          // Navigate to quiz screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QuizScreen(
                                quizId: lecture.id,
                                quizTitle: lecture.title,
                                quizCreatedAt: lecture.createdAt,
                              ),
                            ),
                          );
                        } else if (lecture.type == 'assignment' &&
                            (lecture.pdfUrl?.isNotEmpty == true ||
                                lecture.description?.isNotEmpty != "")) {
                          // Handle PDF lecture - Extract PDF URL and open PDF viewer
                          String pdfUrl = '';

                          // First try to use pdfUrl if available
                          if (lecture.pdfUrl?.isNotEmpty == true) {
                            pdfUrl = lecture.pdfUrl!;
                          } else if (lecture.description?.isNotEmpty == true) {
                            // Try to extract PDF URL from HTML href attribute
                            final extractedUrl =
                                _extractPdfUrlFromHtml(lecture.description);
                            if (extractedUrl != null &&
                                extractedUrl.isNotEmpty) {
                              pdfUrl = extractedUrl;
                            } else {
                              // Fallback to description if no href found
                              pdfUrl = lecture.description!;
                            }
                          }

                          if (pdfUrl.isNotEmpty) {
                            // Open PDF viewer for regular PDFs (display only)
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PDFViewerWidget(
                                  pdfUrl: pdfUrl,
                                  title: lecture.title,
                                  isDownloadable: lecture.isDownloadable,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لا يوجد رابط للملف'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else if (lecture.type == 'assignment') {
                          // Handle Assignment - Open assignment screen for submission
                          // AssignmentScreen will handle PDF display if available
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AssignmentScreen(
                                assignmentId: lecture.id,
                                assignmentTitle: lecture.title,
                                pdfUrl: lecture.pdfUrl,
                                description: lecture.description,
                              ),
                            ),
                          );
                        } else if (lecture.videoUrl?.isNotEmpty == true) {
                          // Validate URL before loading
                          final videoUrl = lecture.videoUrl!;

                          // Check if URL is valid
                          try {
                            final uri = Uri.parse(videoUrl);
                            if (!uri.hasScheme ||
                                (!uri.scheme.startsWith('http'))) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('رابط الفيديو غير صحيح'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('رابط الفيديو غير صحيح'),
                                backgroundColor: Colors.red,
                              ),
                            );
                            return;
                          }

                          // Determine video type based on lecture data
                          String videoType = 'video';
                          if (lecture.videoSource == 'youtube') {
                            videoType = 'youtube';
                            print('📺 Detected YouTube video: $videoUrl');
                            // Validate YouTube URL
                            final videoId = _extractYouTubeVideoId(videoUrl);
                            if (videoId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('رابط يوتيوب غير صحيح'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }
                            print('✅ YouTube video ID extracted: $videoId');
                          } else if (lecture.videoSource == 'html5') {
                            videoType = 'server';
                          } else if (lecture.videoSource == 'external_url') {
                            // Handle external video URLs (like mediadelivery.net)
                            videoType = 'server';
                          }

                          // Load the video with lecture ID
                          _loadVideo(videoUrl, videoType,
                              lectureId: lecture.id);

                          // // Show success message
                          // ScaffoldMessenger.of(context).showSnackBar(
                          //   SnackBar(
                          //     content: Text('تم تحميل: ${lecture.title}'),
                          //     backgroundColor: const Color(0xFFd4af37),
                          //   ),
                          // );
                        } else {
                          // No content available
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('لا يوجد محتوى متاح لهذه المحاضرة'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      },
                    ),
                  );
                }),
              ],
            ),
          );
        },
      );
    }

    // Default case - return empty container
    return const SizedBox.shrink();
  }
}

/*

 content course flow : 

1- add api constant (getCourseContent) : 
GET courses/{course_id}/content

2- add response model (getCourseContentResponseModel) : 
{
    "success": true,
    "message": "تم جلب محتوى الكورس بنجاح.",
    "data": {
        "lectures": [
            {
                "id": "42",
                "courseId": "40",
                "title": "test123",
                "description": "<p>fdaf</p>",
                "excerpt": "",
                "type": "video",
                "videoUrl": "https://future-team-law.com/wp-content/uploads/2025/10/VID-20240822-WA0001-1.mp4",
                "videoSource": "html5",
                "pdfUrl": "",
                "audioUrl": "",
                "thumbnailUrl": "https://future-team-law.com/wp-content/uploads/2025/10/WhatsApp-Image-2025-10-14-at-11.10.17-AM.jpeg",
                "duration": 0,
                "durationText": "0 ثانية",
                "order": 1,
                "week": "الأسبوع 1",
                "module": "fdsafesafeaf",
                "isFree": false,
                "isDownloadable": false,
                "isVideoDownloadable": true,
                "createdAt": "2025-10-16 15:16:15",
                "updatedAt": "2025-10-16 15:16:15"
            },
            {
                "id": "43",
                "courseId": "40",
                "title": "afcesa",
                "description": "safa",
                "excerpt": "",
                "type": "quiz",
                "videoUrl": "",
                "videoSource": "",
                "pdfUrl": "",
                "audioUrl": "",
                "thumbnailUrl": "",
                "duration": 0,
                "durationText": "0 ثانية",
                "order": 2,
                "week": "الأسبوع 1",
                "module": "fdsafesafeaf",
                "isFree": false,
                "isDownloadable": false,
                "isVideoDownloadable": false,
                "createdAt": "2025-10-16 20:34:09",
                "updatedAt": "2025-10-16 20:34:09"
            },
            {
                "id": "59",
                "courseId": "40",
                "title": "يسشبض",
                "description": "<p>سشبيس</p>",
                "excerpt": "",
                "type": "video",
                "videoUrl": "https://www.youtube.com/watch?v=-FEtRSWAFDQ&list=RD-FEtRSWAFDQ&start_radio=1",
                "videoSource": "youtube",
                "pdfUrl": "",
                "audioUrl": "",
                "thumbnailUrl": "",
                "duration": 0,
                "durationText": "0 ثانية",
                "order": 3,
                "week": "الأسبوع 1",
                "module": "fdsafesafeaf",
                "isFree": false,
                "isDownloadable": false,
                "isVideoDownloadable": false,
                "createdAt": "2025-10-16 20:33:43",
                "updatedAt": "2025-10-16 20:33:43"
            }
        ]
    }
}



3- add getCourseContent method to api service and use getCourseContentResponseModel to get the content of the course


4- add getCourseContent method to course repo and use getCourseContentResponseModel to get the content of the course

5- add getCourseContent method to course cubit and use getCourseContentResponseModel to get the content of the course

6 - create state for the content of the course

7- add repo and cubit to di.dart 


8 - connect cubit to lib/features/courses/presentation/lecture_player_screen.dart


*/

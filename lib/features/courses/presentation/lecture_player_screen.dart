import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/features/courses/logic/cubit/courses_cubit.dart';
import 'package:future_app/features/courses/logic/cubit/courses_state.dart';
import 'package:future_app/widgets/common/custom_button.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

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
  VideoPlayerController? _videoController;
  YoutubePlayerController? _youtubeController;
  bool _isLoading = true;
  bool _isPlaying = false;
  String? _currentVideoUrl;
  String? _currentVideoType;

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

  void _loadVideo(String videoUrl, String videoType) {
    setState(() {
      _isLoading = true;
      _currentVideoUrl = videoUrl;
      _currentVideoType = videoType;
    });

    if (videoType == 'youtube') {
      _initializeYouTubeVideo(videoUrl);
    } else if (videoType == 'server' || videoType == 'video') {
      _initializeServerVideo(videoUrl);
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _extractYouTubeVideoId(String url) {
    final RegExp regExp = RegExp(
      r'(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^"&?\/\s]{11})',
    );
    final match = regExp.firstMatch(url);
    return match?.group(1);
  }

  void _initializeYouTubeVideo(String videoUrl) {
    // Dispose previous YouTube controller
    _youtubeController?.dispose();

    final videoId = _extractYouTubeVideoId(videoUrl);
    if (videoId != null) {
      _youtubeController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          isLive: false,
          forceHD: false,
          enableCaption: true,
          showLiveFullscreenButton: true,
        ),
      );

      setState(() {
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطأ في استخراج معرف فيديو يوتيوب'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _openYouTubeVideo() async {
    if (_currentVideoUrl == null) return;

    final Uri url = Uri.parse(_currentVideoUrl!);
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
  }

  void _initializeServerVideo(String videoUrl) {
    // Dispose previous controller
    _videoController?.dispose();

    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(videoUrl),
    );

    _videoController!.initialize().then((_) {
      setState(() {
        _isLoading = false;
        _isPlaying = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('خطأ في تحميل الفيديو'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _youtubeController?.dispose();
    super.dispose();
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
                    height: 250,
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

                        // Video Type Info
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
                                widget.videoType == 'youtube'
                                    ? Icons.play_circle
                                    : Icons.video_library,
                                color: const Color(0xFFd4af37),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                widget.videoType == 'youtube'
                                    ? 'فيديو من يوتيوب'
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
                        CustomButton(
                          text: 'حمل المحاضرة اوفلاين',
                          onPressed: () {},
                        ),
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
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
        ),
      );
    }

    if (_currentVideoType == 'youtube' && _currentVideoUrl != null) {
      return _youtubeController != null
          ? _buildYouTubePlayerWidget()
          : _buildErrorWidget();
    } else if ((_currentVideoType == 'server' ||
            _currentVideoType == 'video') &&
        _currentVideoUrl != null) {
      return _videoController != null && _videoController!.value.isInitialized
          ? _buildServerVideoPlayer()
          : _buildErrorWidget();
    } else {
      return _buildNoVideoWidget();
    }
  }

  Widget _buildServerVideoPlayer() {
    return Stack(
      children: [
        Center(
          child: AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: VideoPlayer(_videoController!),
          ),
        ),
        Center(
          child: FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_isPlaying) {
                  _videoController!.pause();
                } else {
                  _videoController!.play();
                }
                _isPlaying = !_isPlaying;
              });
            },
            backgroundColor: const Color(0xFFd4af37),
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.black,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: VideoProgressIndicator(
            _videoController!,
            allowScrubbing: true,
            colors: const VideoProgressColors(
              playedColor: Color(0xFFd4af37),
              bufferedColor: Colors.white54,
              backgroundColor: Colors.white24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildYouTubePlayerWidget() {
    return YoutubePlayer(
      controller: _youtubeController!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: const Color(0xFFd4af37),
      progressColors: const ProgressBarColors(
        playedColor: Color(0xFFd4af37),
        handleColor: Color(0xFFd4af37),
        backgroundColor: Colors.white24,
        bufferedColor: Colors.white54,
      ),
      onReady: () {
        // Video is ready to play
      },
      onEnded: (metaData) {
        // Video ended
      },
    );
  }

  Widget _buildYouTubePlayer() {
    return GestureDetector(
      onTap: _openYouTubeVideo,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.play_circle_outline,
              size: 80,
              color: Color(0xFFd4af37),
            ),
            SizedBox(height: 16),
            Text(
              'اضغط لفتح الفيديو في يوتيوب',
              style: TextStyle(
                color: Color(0xFFd4af37),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              'سيتم فتح الفيديو في تطبيق يوتيوب',
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
                          Text(
                            lecture.durationTextFromApi?.isNotEmpty == true
                                ? lecture.durationTextFromApi!
                                : lecture.durationText,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
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
                        // Handle lecture tap - Load video
                        if (lecture.type == 'quiz') {
                          // Handle quiz navigation
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('فتح كويز: ${lecture.title}'),
                              backgroundColor: const Color(0xFFd4af37),
                            ),
                          );
                        } else if (lecture.videoUrl?.isNotEmpty == true) {
                          // Determine video type based on lecture data
                          String videoType = 'video';
                          if (lecture.videoSource == 'youtube') {
                            videoType = 'youtube';
                          } else if (lecture.videoSource == 'html5') {
                            videoType = 'server';
                          }

                          // Load the video
                          _loadVideo(lecture.videoUrl!, videoType);

                          // Show success message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('تم تحميل: ${lecture.title}'),
                              backgroundColor: const Color(0xFFd4af37),
                            ),
                          );
                        } else {
                          // No video available
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('لا يوجد فيديو متاح لهذه المحاضرة'),
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
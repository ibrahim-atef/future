import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LecturePlayerScreen extends StatefulWidget {
  final String courseTitle;
  final String videoUrl;
  final String videoType; // 'youtube' or 'server'

  const LecturePlayerScreen({
    super.key,
    required this.courseTitle,
    required this.videoUrl,
    required this.videoType,
  });

  @override
  State<LecturePlayerScreen> createState() => _LecturePlayerScreenState();
}

class _LecturePlayerScreenState extends State<LecturePlayerScreen> {
  VideoPlayerController? _videoController;
  YoutubePlayerController? _youtubeController;
  bool _isLoading = true;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  void _initializeVideo() {
    if (widget.videoType == 'youtube') {
      // Extract YouTube video ID from URL
      String videoId = YoutubePlayer.convertUrlToId(widget.videoUrl) ?? '';
      if (videoId.isNotEmpty) {
        _youtubeController = YoutubePlayerController(
          initialVideoId: videoId,
          flags: const YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
            isLive: false,
          ),
        );
      }
      setState(() {
        _isLoading = false;
      });
    } else {
      _initializeServerVideo();
    }
  }

  void _initializeServerVideo() {
    _videoController = VideoPlayerController.networkUrl(
      Uri.parse(widget.videoUrl),
    );

    _videoController!.initialize().then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
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
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: Text(
          widget.courseTitle,
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
                  Text(
                    'محتوى تعليمي متقدم',
                    style: const TextStyle(
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
                          widget.videoType == 'youtube' ? Icons.play_circle : Icons.video_library,
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

                  _buildLectureList(),
                ],
              ),
            ),
          ],
        ),
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

    if (widget.videoType == 'youtube') {
      return _buildYouTubePlayer();
    } else {
      return _videoController != null && _videoController!.value.isInitialized
          ? _buildServerVideoPlayer()
          : _buildErrorWidget();
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

  Widget _buildYouTubePlayer() {
    if (_youtubeController == null) {
      return Container(
        height: 200,
        decoration: BoxDecoration(
          color: Colors.black,
          border: Border.all(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        child: const Center(
          child: Text(
            'خطأ في تحميل الفيديو',
            style: TextStyle(
              color: Color(0xFFd4af37),
              fontSize: 16,
            ),
          ),
        ),
      );
    }

    return YoutubePlayer(
      controller: _youtubeController!,
      showVideoProgressIndicator: true,
      progressIndicatorColor: const Color(0xFFd4af37),
      onReady: () {
        // Video is ready to play
      },
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

  Widget _buildLectureList() {
    final lectures = [
      {'title': 'مقدمة في القانون المدني', 'duration': '15:30', 'type': 'youtube'},
      {'title': 'أساسيات العقود', 'duration': '22:45', 'type': 'server'},
      {'title': 'المسؤولية المدنية', 'duration': '18:20', 'type': 'youtube'},
      {'title': 'حقوق الملكية', 'duration': '25:10', 'type': 'server'},
      {'title': 'الالتزامات', 'duration': '20:15', 'type': 'youtube'},
    ];

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: lectures.length,
      itemBuilder: (context, index) {
        final lecture = lectures[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          decoration: BoxDecoration(
            color: const Color(0xFF2a2a2a),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: const Color(0xFFd4af37).withOpacity(0.3),
              width: 1,
            ),
          ),
          child: ListTile(
            leading: Icon(
              lecture['type'] == 'youtube' ? Icons.play_circle : Icons.video_library,
              color: const Color(0xFFd4af37),
            ),
            title: Text(
              lecture['title']!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text(
              lecture['duration']!,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 12,
              ),
            ),
            trailing: Icon(
              Icons.play_arrow,
              color: const Color(0xFFd4af37),
            ),
            onTap: () {
              // Handle lecture tap
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('فتح ${lecture['title']}'),
                  backgroundColor: const Color(0xFFd4af37),
                ),
              );
            },
          ),
        );
      },
    );
  }

}
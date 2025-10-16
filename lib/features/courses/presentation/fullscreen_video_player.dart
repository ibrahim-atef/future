import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class FullscreenVideoPlayer extends StatefulWidget {
  final VideoPlayerController? videoController;
  final YoutubePlayerController? youtubeController;
  final String videoType;
  final String videoTitle;
  final String? videoUrl;

  const FullscreenVideoPlayer({
    super.key,
    this.videoController,
    this.youtubeController,
    required this.videoType,
    required this.videoTitle,
    this.videoUrl,
  });

  @override
  State<FullscreenVideoPlayer> createState() => _FullscreenVideoPlayerState();
}

class _FullscreenVideoPlayerState extends State<FullscreenVideoPlayer> {
  bool _showControls = true;
  bool _isPlaying = false;
  double _volume = 1.0;
  bool _isMuted = false;
  Timer? _hideControlsTimer;

  @override
  void initState() {
    super.initState();
    _enterFullScreen();
    _setupVideoListeners();
    _startHideControlsTimer();
  }

  void _setupVideoListeners() {
    if (widget.videoController != null) {
      widget.videoController!.addListener(_videoListener);
      setState(() {
        _isPlaying = widget.videoController!.value.isPlaying;
      });
    }
    if (widget.youtubeController != null) {
      setState(() {
        _isPlaying = widget.youtubeController!.value.isPlaying;
      });
    }
  }

  void _videoListener() {
    if (widget.videoController != null) {
      setState(() {
        _isPlaying = widget.videoController!.value.isPlaying;
      });
    }
  }

  void _enterFullScreen() async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } catch (e) {
      print('Error entering fullscreen: $e');
      // Fallback: try alternative fullscreen mode
      try {
        await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      } catch (e2) {
        print('Error with fallback fullscreen: $e2');
      }
    }
  }

  void _exitFullScreen() async {
    try {
      await SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      await SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp]);
    } catch (e) {
      print('Error exiting fullscreen: $e');
    }
    Navigator.pop(context);
  }

  void _startHideControlsTimer() {
    _hideControlsTimer?.cancel();
    _hideControlsTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
    });
    if (_showControls) {
      _startHideControlsTimer();
    } else {
      _hideControlsTimer?.cancel();
    }
  }

  @override
  void dispose() {
    _hideControlsTimer?.cancel();
    widget.videoController?.removeListener(_videoListener);
    _exitFullScreen();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) {
        if (didPop) {
          _exitFullScreen();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GestureDetector(
          onTap: _toggleControls,
          child: Stack(
            children: [
              // Video Player
              _buildVideoPlayer(),

              // Controls Overlay (only for regular videos, not YouTube)
              if (_showControls && widget.videoType != 'youtube')
                _buildControlsOverlay(),

              // YouTube custom play/pause button
              if (widget.videoType == 'youtube' && _showControls)
                _buildYouTubePlayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (widget.videoType == 'youtube' && widget.youtubeController != null) {
      return SizedBox.expand(
        child: YoutubePlayer(
          controller: widget.youtubeController!,
          showVideoProgressIndicator: false, // Hide default progress bar
          progressIndicatorColor: const Color(0xFFd4af37),
          progressColors: const ProgressBarColors(
            playedColor: Color(0xFFd4af37),
            handleColor: Color(0xFFd4af37),
            backgroundColor: Colors.white24,
            bufferedColor: Colors.white54,
          ),
          onReady: () {
            setState(() {
              _isPlaying = widget.youtubeController!.value.isPlaying;
            });
          },
          onEnded: (metaData) {
            _exitFullScreen();
          },
          // إضافة أزرار التحكم المخصصة لـ YouTube
          topActions: [
            IconButton(
              onPressed: _exitFullScreen,
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
            ),
            Expanded(
              child: Text(
                widget.videoTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              onPressed: _exitFullScreen,
              icon: const Icon(
                Icons.fullscreen_exit,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
          bottomActions: [
            // Current time
            const CurrentPosition(),
            // Progress bar
            const ProgressBar(
              isExpanded: true,
              colors: ProgressBarColors(
                playedColor: Color(0xFFd4af37),
                handleColor: Color(0xFFd4af37),
                backgroundColor: Colors.white24,
                bufferedColor: Colors.white54,
              ),
            ),
            // Remaining time
            const RemainingDuration(),
            // Playback speed
            const PlaybackSpeedButton(),
            // Settings button
            IconButton(
              onPressed: () {
                _showVideoSettings(context);
              },
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 24,
              ),
            ),
            // Fullscreen button
            const FullScreenButton(),
          ],
        ),
      );
    } else if (widget.videoController != null &&
        widget.videoController!.value.isInitialized) {
      return SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: widget.videoController!.value.size.width,
            height: widget.videoController!.value.size.height,
            child: VideoPlayer(widget.videoController!),
          ),
        ),
      );
    } else if (widget.videoController != null &&
        !widget.videoController!.value.isInitialized) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
            ),
            SizedBox(height: 16),
            Text(
              'جاري تحميل الفيديو...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 48,
            ),
            SizedBox(height: 16),
            Text(
              'خطأ في تحميل الفيديو',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
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
  }

  Widget _buildControlsOverlay() {
    return Container(
      color: Colors.black.withOpacity(0.3),
      child: Column(
        children: [
          // Top controls
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Back button
                IconButton(
                  onPressed: _exitFullScreen,
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                // Title
                Expanded(
                  child: Text(
                    widget.videoTitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // Exit fullscreen button
                IconButton(
                  onPressed: _exitFullScreen,
                  icon: const Icon(
                    Icons.fullscreen_exit,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Center play button
          Center(
            child: FloatingActionButton(
              onPressed: () {
                if (widget.videoType == 'youtube' &&
                    widget.youtubeController != null) {
                  if (_isPlaying) {
                    widget.youtubeController!.pause();
                  } else {
                    widget.youtubeController!.play();
                  }
                } else if (widget.videoController != null) {
                  if (_isPlaying) {
                    widget.videoController!.pause();
                  } else {
                    widget.videoController!.play();
                  }
                }
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              backgroundColor: const Color(0xFFd4af37),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
                size: 32,
              ),
            ),
          ),

          const Spacer(),

          // Bottom controls
          _buildBottomControls(),
        ],
      ),
    );
  }

  Widget _buildBottomControls() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Progress bar
          if (widget.videoType == 'youtube' && widget.youtubeController != null)
            _buildYouTubeProgressBar()
          else if (widget.videoController != null &&
              widget.videoController!.value.isInitialized)
            _buildVideoProgressBar(),

          const SizedBox(height: 12),

          // Bottom row controls
          Row(
            children: [
              // Play/Pause button
              IconButton(
                onPressed: () {
                  if (widget.videoType == 'youtube' &&
                      widget.youtubeController != null) {
                    if (_isPlaying) {
                      widget.youtubeController!.pause();
                    } else {
                      widget.youtubeController!.play();
                    }
                  } else if (widget.videoController != null) {
                    if (_isPlaying) {
                      widget.videoController!.pause();
                    } else {
                      widget.videoController!.play();
                    }
                  }
                  setState(() {
                    _isPlaying = !_isPlaying;
                  });
                },
                icon: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 24,
                ),
              ),

              // Volume control (only for regular videos)
              if (widget.videoType != 'youtube')
                IconButton(
                  onPressed: () {
                    setState(() {
                      _isMuted = !_isMuted;
                      widget.videoController!
                          .setVolume(_isMuted ? 0.0 : _volume);
                    });
                  },
                  icon: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: Colors.white,
                    size: 24,
                  ),
                ),

              // Time display
              Expanded(
                child: Text(
                  _getTimeDisplay(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

              // Speed control (only for regular videos)
              if (widget.videoType != 'youtube')
                PopupMenuButton<double>(
                  icon: const Icon(
                    Icons.speed,
                    color: Colors.white,
                    size: 24,
                  ),
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 0.5,
                      child: Text('0.5x'),
                    ),
                    const PopupMenuItem(
                      value: 0.75,
                      child: Text('0.75x'),
                    ),
                    const PopupMenuItem(
                      value: 1.0,
                      child: Text('1x'),
                    ),
                    const PopupMenuItem(
                      value: 1.25,
                      child: Text('1.25x'),
                    ),
                    const PopupMenuItem(
                      value: 1.5,
                      child: Text('1.5x'),
                    ),
                    const PopupMenuItem(
                      value: 2.0,
                      child: Text('2x'),
                    ),
                  ],
                  onSelected: (speed) {
                    widget.videoController!.setPlaybackSpeed(speed);
                  },
                ),

              // Settings button
              IconButton(
                onPressed: () {
                  _showVideoSettings(context);
                },
                icon: const Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildYouTubeProgressBar() {
    return Container(
      height: 4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(2),
        color: Colors.white24,
      ),
      child: GestureDetector(
        onTapDown: (details) {
          // Handle progress bar tap for YouTube
          // This would need more complex implementation with YouTube API
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: const Color(0xFFd4af37),
          ),
          width: MediaQuery.of(context).size.width * 0.3, // Placeholder
        ),
      ),
    );
  }

  Widget _buildVideoProgressBar() {
    return VideoProgressIndicator(
      widget.videoController!,
      allowScrubbing: true,
      colors: const VideoProgressColors(
        playedColor: Color(0xFFd4af37),
        bufferedColor: Colors.white54,
        backgroundColor: Colors.white24,
      ),
    );
  }

  String _getTimeDisplay() {
    if (widget.videoType == 'youtube' && widget.youtubeController != null) {
      final position = widget.youtubeController!.value.position;
      final duration = widget.youtubeController!.metadata.duration;
      return '${_formatDuration(position)} / ${_formatDuration(duration)}';
    } else if (widget.videoController != null &&
        widget.videoController!.value.isInitialized) {
      return '${_formatDuration(widget.videoController!.value.position)} / ${_formatDuration(widget.videoController!.value.duration)}';
    }
    return '00:00 / 00:00';
  }

  Widget _buildYouTubePlayButton() {
    return Center(
      child: FloatingActionButton(
        onPressed: () {
          if (widget.youtubeController != null) {
            if (_isPlaying) {
              widget.youtubeController!.pause();
            } else {
              widget.youtubeController!.play();
            }
            setState(() {
              _isPlaying = !_isPlaying;
            });
          }
        },
        backgroundColor: const Color(0xFFd4af37),
        child: Icon(
          _isPlaying ? Icons.pause : Icons.play_arrow,
          color: Colors.black,
          size: 32,
        ),
      ),
    );
  }

  void _showVideoSettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF2a2a2a),
          title: const Text(
            'إعدادات الفيديو',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Volume control (only for regular videos)
              if (widget.videoType != 'youtube')
                ListTile(
                  leading: Icon(
                    _isMuted ? Icons.volume_off : Icons.volume_up,
                    color: const Color(0xFFd4af37),
                  ),
                  title: const Text(
                    'مستوى الصوت',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Slider(
                    value: _isMuted ? 0.0 : _volume,
                    min: 0.0,
                    max: 1.0,
                    activeColor: const Color(0xFFd4af37),
                    inactiveColor: Colors.white24,
                    onChanged: (value) {
                      setState(() {
                        _volume = value;
                        _isMuted = value == 0.0;
                        widget.videoController?.setVolume(value);
                      });
                    },
                  ),
                ),

              // YouTube specific settings
              if (widget.videoType == 'youtube')
                const ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: Color(0xFFd4af37),
                  ),
                  title: Text(
                    'فيديو من يوتيوب',
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'يتم التحكم في الصوت من خلال أزرار الجهاز',
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text(
                'إغلاق',
                style: TextStyle(
                  color: Color(0xFFd4af37),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

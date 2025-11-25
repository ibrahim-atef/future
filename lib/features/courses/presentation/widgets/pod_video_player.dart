import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:future_app/features/courses/presentation/widgets/full_screen_video_page.dart';

class PodVideoPlayerDev extends StatefulWidget {
  final String type;
  final String url;
  final String name;

  const PodVideoPlayerDev(
    this.url,
    this.type, {
    super.key,
    required this.name,
  });

  /// Extract YouTube video ID (static helper method)
  static String? _extractVideoIdStatic(String url) {
    if (url.isEmpty) return null;
    
    url = url.trim();
    
    // First try the built-in converter
    String? videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null && videoId.isNotEmpty) {
      return videoId;
    }
    
    // Handle youtu.be short URLs
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
    
    // Fallback
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

  /// Clear saved position for a specific video
  static Future<void> clearSavedPosition(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? videoId = _extractVideoIdStatic(url);
      if (videoId != null) {
        await prefs.remove('video_position_$videoId');
        log('Cleared saved position for video: $videoId');
      }
    } catch (e) {
      log('Error clearing saved position: $e');
    }
  }

  /// Clear all saved video positions
  static Future<void> clearAllSavedPositions() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final keys = prefs.getKeys();
      final videoPositionKeys =
          keys.where((key) => key.startsWith('video_position_'));

      for (final key in videoPositionKeys) {
        await prefs.remove(key);
      }

      log('Cleared all saved video positions');
    } catch (e) {
      log('Error clearing all saved positions: $e');
    }
  }

  /// Get saved position for a specific video
  static Future<Duration?> getSavedPosition(String url) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? videoId = _extractVideoIdStatic(url);
      if (videoId != null) {
        final int? savedSeconds = prefs.getInt('video_position_$videoId');
        if (savedSeconds != null) {
          return Duration(seconds: savedSeconds);
        }
      }
      return null;
    } catch (e) {
      log('Error getting saved position: $e');
      return null;
    }
  }

  @override
  State<PodVideoPlayerDev> createState() => _PodVideoPlayerDevState();
}

class _PodVideoPlayerDevState extends State<PodVideoPlayerDev> {
  bool _isFullScreen = false;
  final double _watermarkPositionX = 0.0;
  final double _watermarkPositionY = 0.0;
  Timer? _timer;
  YoutubePlayerController? _controller;
  YoutubePlayerController? _fullscreenController;
  bool _disposed = false;
  bool _isLoading = true;
  bool _isInitialized = false;
  Duration _savedPosition = Duration.zero;
  Timer? _positionSaveTimer;

  /// Extract YouTube video ID from various URL formats
  /// Supports: youtube.com/watch?v=, youtube.com/embed/, youtu.be/, etc.
  String? _extractYouTubeVideoId(String url) {
    if (url.isEmpty) return null;
    
    // Remove any leading/trailing whitespace
    url = url.trim();
    
    // First try the built-in converter
    String? videoId = YoutubePlayer.convertUrlToId(url);
    if (videoId != null && videoId.isNotEmpty) {
      return videoId;
    }
    
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

  @override
  void initState() {
    super.initState();

    // Load saved position first
    _loadSavedPosition().then((_) {
      _initializeVideoPlayer();
    });

    // Force portrait orientation
    _setPortraitOrientation();
  }

  /// Load saved video position from SharedPreferences
  Future<void> _loadSavedPosition() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? videoId = _extractYouTubeVideoId(widget.url);
      if (videoId != null) {
        final int? savedSeconds = prefs.getInt('video_position_$videoId');
        if (savedSeconds != null) {
          _savedPosition = Duration(seconds: savedSeconds);
          log('Loaded saved position: $_savedPosition for video: $videoId');
        }
      }
    } catch (e) {
      log('Error loading saved position: $e');
    }
  }

  /// Save current video position to SharedPreferences
  Future<void> _saveCurrentPosition() async {
    if (_controller == null || !_controller!.value.isReady) return;

    try {
      final prefs = await SharedPreferences.getInstance();
      final String? videoId = _extractYouTubeVideoId(widget.url);
      if (videoId != null) {
        final int currentSeconds = _controller!.value.position.inSeconds;
        await prefs.setInt('video_position_$videoId', currentSeconds);
        log('Saved position: ${_controller!.value.position} for video: $videoId');
      }
    } catch (e) {
      log('Error saving position: $e');
    }
  }

  /// Initialize video player with proper error handling
  void _initializeVideoPlayer() {
    log('🎬 Initializing video player with URL: ${widget.url}');
    
    // Safely extract the YouTube video ID using improved extraction
    final String? videoId = _extractYouTubeVideoId(widget.url);
    if (videoId == null || videoId.isEmpty) {
      log("❌ Warning: Invalid or no video ID found in URL: ${widget.url}");
      setState(() {
        _isLoading = false;
        _isInitialized = false;
      });
      return;
    }
    
    log('✅ Extracted video ID: $videoId from URL: ${widget.url}');

    try {
      // Initialize controllers
      _controller = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
          isLive: false,
          hideControls: true,
        ),
      );

      _fullscreenController = YoutubePlayerController(
        initialVideoId: videoId,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
          mute: false,
          enableCaption: true,
          isLive: false,
          hideControls: false,
        ),
      );

      // Set up position saving timer (save every 5 seconds)
      _positionSaveTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
        if (_mountedSafe && _controller != null && _controller!.value.isReady) {
          _saveCurrentPosition();
        }
      });

      // Listen to controller state changes
      _controller!.addListener(_onControllerStateChanged);
      _fullscreenController!.addListener(_onFullscreenControllerStateChanged);

      setState(() {
        _isLoading = false;
        _isInitialized = true;
      });

      log('Video player initialized successfully for video: $videoId');
    } catch (e) {
      log('Error initializing video player: $e');
      setState(() {
        _isLoading = false;
        _isInitialized = false;
      });
    }
  }

  /// Handle controller state changes
  void _onControllerStateChanged() {
    if (_mountedSafe && _controller != null) {
      setState(() {});

      // Save position when video ends
      if (_controller!.value.playerState == PlayerState.ended) {
        _saveCurrentPosition();
      }
    }
  }

  /// Handle fullscreen controller state changes
  void _onFullscreenControllerStateChanged() {
    if (_mountedSafe && _fullscreenController != null) {
      // Sync position back to main controller when fullscreen ends
      if (_fullscreenController!.value.playerState == PlayerState.ended) {
        _saveCurrentPosition();
      }
    }
  }

  /// Ensures the device is fixed to portrait orientation.
  void _setPortraitOrientation() {
    try {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    } catch (e) {
      log("Error setting device orientation: $e");
    }
  }

  void _toggleFullScreen() {
    if (_controller == null || _fullscreenController == null) return;
    if (!_mountedSafe) return;

    setState(() {
      _isFullScreen = true;
    });

    final Duration currentPosition = _controller!.value.position;
    final bool wasPlaying = _controller!.value.isPlaying;

    // Pause before fullscreen
    _controller!.pause();

    // Sync position in fullscreen controller
    _fullscreenController!.seekTo(currentPosition);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FullScreenVideoPage(
          url: widget.url,
          name: widget.name,
          controller: _fullscreenController!,
          initialPosition: currentPosition,
          shouldAutoPlay: wasPlaying,
        ),
      ),
    ).then((_) {
      if (!_mountedSafe) return;
      setState(() {
        _isFullScreen = false;
      });
      _setPortraitOrientation();

      // Resume playback if it was playing
      if (wasPlaying) {
        _controller!.play();
      }
    });
  }

  void _togglePlayPause() {
    if (_controller == null || !_controller!.value.isReady) return;

    try {
      if (_controller!.value.isPlaying) {
        _controller!.pause();
      } else {
        _controller!.play();
      }
      setState(() {});
    } catch (e) {
      log('Error toggling play/pause: $e');
    }
  }

  void _seekForward() {
    if (_controller == null || !_controller!.value.isReady) return;
    try {
      final currentPosition = _controller!.value.position;
      final newPosition = currentPosition + const Duration(seconds: 10);
      _controller!.seekTo(newPosition);
    } catch (e) {
      log('Error seeking forward: $e');
    }
  }

  void _seekBackward() {
    if (_controller == null || !_controller!.value.isReady) return;
    try {
      final currentPosition = _controller!.value.position;
      final newPosition = currentPosition - const Duration(seconds: 10);
      if (newPosition.inSeconds >= 0) {
        _controller!.seekTo(newPosition);
      }
    } catch (e) {
      log('Error seeking backward: $e');
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _timer = null;
    _positionSaveTimer?.cancel();
    _positionSaveTimer = null;

    _controller?.removeListener(_onControllerStateChanged);
    _fullscreenController?.removeListener(_onFullscreenControllerStateChanged);

    _controller?.dispose();
    _controller = null;

    _fullscreenController?.dispose();
    _fullscreenController = null;

    // استعادة إعدادات الـ system UI عند إغلاق الفيديو
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    super.dispose();
  }

  bool get _mountedSafe => mounted && !_disposed;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                // Video Player or Loading
                if (_isLoading)
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Loading video...',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else if (!_isInitialized || _controller == null)
                  Container(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black87,
                    child: const Center(
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
                            'Failed to load video',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SizedBox(
                    height: 250,
                    width: MediaQuery.of(context).size.width,
                    child: YoutubePlayer(
                      controller: _controller!,
                      showVideoProgressIndicator: true,
                      progressIndicatorColor: Colors.red,
                      progressColors: const ProgressBarColors(
                        playedColor: Colors.red,
                        handleColor: Colors.redAccent,
                      ),
                      onReady: () {
                        log('Player is ready.');
                        if (_mountedSafe && _savedPosition > Duration.zero) {
                          // Seek to saved position after a short delay
                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (_mountedSafe && _controller != null) {
                              _controller!.seekTo(_savedPosition);
                              log('Seeked to saved position: $_savedPosition');
                            }
                          });
                        }
                      },
                      onEnded: (YoutubeMetaData metaData) {
                        log('Player ended.');
                        _saveCurrentPosition();
                      },
                    ),
                  ),

                // Bottom Controls Bar (only show when video is ready)
                if (_isInitialized &&
                    _controller != null &&
                    _controller!.value.isReady)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      color: Colors.black.withOpacity(0.2),
                      child: Row(
                        children: [
                          // Play/Pause Button
                          IconButton(
                            icon: Icon(
                              _controller!.value.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: _togglePlayPause,
                          ),
                          // Seek Backward Button
                          IconButton(
                            icon: const Icon(
                              Icons.replay_10,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: _seekBackward,
                          ),
                          // Seek Forward Button
                          IconButton(
                            icon: const Icon(
                              Icons.forward_10,
                              color: Colors.white,
                              size: 24,
                            ),
                            onPressed: _seekForward,
                          ),
                          const Spacer(),
                          // Fullscreen button
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.fullscreen,
                                color: Colors.white,
                                size: 20,
                              ),
                              onPressed: _toggleFullScreen,
                              padding: const EdgeInsets.all(8),
                              constraints: const BoxConstraints(
                                minWidth: 36,
                                minHeight: 36,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_player/video_player.dart';
import 'package:future_app/features/courses/presentation/widgets/full_screen_video_player.dart';

class CourseVideoPlayer extends StatefulWidget {
  final String url;
  final String name;
  final String imageCover;

  final bool isLoadNetwork;
  final String? localFileName;

  const CourseVideoPlayer(this.url, this.imageCover,
      {this.isLoadNetwork = true,
      this.localFileName,
      super.key,
      required this.name});

  @override
  State<CourseVideoPlayer> createState() => _CourseVideoPlayerState();
}

class _CourseVideoPlayerState extends State<CourseVideoPlayer> {
  late VideoPlayerController controller;
  bool isShowPlayButton = false;
  bool isPlaying = true;

  Duration videoDuration = const Duration(seconds: 0);
  Duration videoPosition = const Duration(seconds: 0);

  bool isShowVideoPlayer = false;

  // متغيرات لتحديد مكان النص
  double _watermarkPositionX = 0.0;
  double _watermarkPositionY = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    initVideo();

    // إعداد الـ Timer لتحريك النص
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_watermarkPositionX == 0.0 && _watermarkPositionY == 0.0) {
          _watermarkPositionX = 0.5; // التحرك نحو المنتصف أفقياً
          _watermarkPositionY = 0.5; // التحرك نحو المنتصف رأسياً
        } else {
          _watermarkPositionX = 0.0; // العودة إلى الزاوية العلوية اليسرى
          _watermarkPositionY = 0.0; // العودة إلى الزاوية العلوية اليسرى
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();

    // إيقاف الـ timer
    _timer.cancel();

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

  initVideo() async {
    if (widget.isLoadNetwork) {
      controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      )..initialize().then((_) {
          isShowVideoPlayer = true;

          controllerListener();
          setState(() {});
          controller.play();
        });
    } else {
      String directory = (await getApplicationSupportDirectory()).path;
      print('${directory.toString()}/${widget.localFileName}');

      controller = VideoPlayerController.file(
        File('${directory.toString()}/${widget.localFileName}'),
      )..initialize().then((_) {
          isShowVideoPlayer = true;

          controllerListener();
          setState(() {});
          controller.play();
        });
    }
  }

  controllerListener() {
    controller.addListener(() {
      if (mounted) {
        if (controller.value.isPlaying) {
          if (!isPlaying) {
            setState(() {
              isPlaying = true;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              setState(() {
                isShowPlayButton = false;
              });
            });
          }
        } else {
          if (isPlaying) {
            setState(() {
              isPlaying = false;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              setState(() {
                isShowPlayButton = false;
              });
            });
          }
        }

        if (videoPosition.inSeconds != controller.value.position.inSeconds) {
          log("duration: ${controller.value.duration.inSeconds.toString()}  position: ${controller.value.position.inSeconds.toString()}");

          setState(() {
            videoPosition =
                Duration(seconds: controller.value.position.inSeconds);
          });
        }

        if (videoDuration.inSeconds != controller.value.duration.inSeconds) {
          setState(() {
            videoDuration =
                Duration(seconds: controller.value.duration.inSeconds);
          });
        }
      }
    });
  }

  String secondDurationToString(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }

  @override
  Widget build(BuildContext context) {
    final double videoHeight = MediaQuery.of(context).size.width * 9 / 16;
    return Column(
      children: [
        // video
        if (isShowVideoPlayer) ...{
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: controller.value.isInitialized
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayer(controller),
                      ),

                      AnimatedPositioned(
                        duration: const Duration(seconds: 1), // مدة الحركة
                        left: _watermarkPositionX == 0.0
                            ? 0 // الزاوية العلوية اليسرى
                            : (MediaQuery.of(context).size.width / 2) -
                                100, // المنتصف أفقياً
                        top: _watermarkPositionY == 0.0
                            ? 0 // الزاوية العلوية اليسرى
                            : (videoHeight / 2) - 50, // المنتصف رأسياً
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          color: Colors.transparent,
                          child: Text(
                            widget.name,
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      // play or pouse button
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: () {
                            if (isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Center(
                            child: AnimatedOpacity(
                              opacity: isShowPlayButton ? 1.0 : 0.0,
                              duration: const Duration(milliseconds: 400),
                              child: Container(
                                width: 65,
                                height: 65,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.black.withOpacity(.3)),
                                child: Icon(
                                  !isPlaying
                                      ? Icons.play_arrow_rounded
                                      : Icons.pause_rounded,
                                  color: Colors.white,
                                  size: 35,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : AspectRatio(
                    aspectRatio: 16 / 9,
                    child: Image.network(
                      widget.imageCover,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: videoHeight,
                          color: Colors.grey,
                          child: const Icon(
                            Icons.video_library,
                            color: Colors.white,
                            size: 48,
                          ),
                        );
                      },
                    ),
                  ),
          ),
          const SizedBox(height: 12),
          AnimatedCrossFade(
              firstChild: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // duration and play button
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (isPlaying) {
                              controller.pause();
                            } else {
                              controller.play();
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                )),
                            child: Icon(
                              !isPlaying
                                  ? Icons.play_arrow_rounded
                                  : Icons.pause,
                              size: 17,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${secondDurationToString(videoPosition.inSeconds)} / ${secondDurationToString(videoDuration.inSeconds)}',
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        // sound
                        GestureDetector(
                          onTap: () {
                            if (controller.value.volume == 0.0) {
                              controller.setVolume(1.0);
                            } else {
                              controller.setVolume(0.0);
                            }

                            setState(() {});
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            controller.value.volume == 0.0
                                ? Icons.volume_off
                                : Icons.volume_up,
                            color: const Color(0xFFd4af37),
                          ),
                        ),

                        const SizedBox(width: 22),

                        // full screen
                        GestureDetector(
                          onTap: () async {
                            controller.pause();

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FullScreenVideoPlayerWidget(
                                  controller,
                                  name: widget.name,
                                ),
                              ),
                            );

                            SystemChrome.setPreferredOrientations([
                              DeviceOrientation.portraitUp,
                            ]);
                          },
                          behavior: HitTestBehavior.opaque,
                          child: const Icon(
                            Icons.fullscreen,
                            color: Color(0xFFd4af37),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              secondChild: SizedBox(width: MediaQuery.of(context).size.width),
              crossFadeState: controller.value.isInitialized
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300))
        },
      ],
    );
  }
}

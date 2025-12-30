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
  VideoPlayerController? controller;
  bool isShowPlayButton = false;
  bool isPlaying = true;

  Duration videoDuration = const Duration(seconds: 0);
  Duration videoPosition = const Duration(seconds: 0);

  bool isShowVideoPlayer = false;
  bool hasError = false;
  String? errorMessage;

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
    // Safely dispose controller if it was initialized
    try {
      if (controller != null) {
        controller!.dispose();
      }
    } catch (e) {
      log('Error disposing controller: $e');
    }

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
    try {
      if (widget.isLoadNetwork) {
        // Validate URL before creating controller
        if (widget.url.isEmpty) {
          setState(() {
            hasError = true;
            errorMessage = 'رابط الفيديو غير صحيح';
          });
          return;
        }

        try {
          // ترميز الـ URL بشكل صحيح للأحرف العربية
          final encodedUrl = _encodeUrl(widget.url);
          log('🎬 Original URL: ${widget.url}');
          log('🎬 Encoded URL: $encodedUrl');

          final uri = Uri.parse(encodedUrl);
          if (!uri.hasScheme || (!uri.scheme.startsWith('http'))) {
            log('❌ Invalid URL scheme: ${uri.scheme}');
            setState(() {
              hasError = true;
              errorMessage = 'رابط الفيديو غير صحيح';
            });
            return;
          }

          log('✅ Creating VideoPlayerController with URI: ${uri.toString()}');
          controller = VideoPlayerController.networkUrl(
            uri,
          );
        } catch (e) {
          setState(() {
            hasError = true;
            errorMessage = 'رابط الفيديو غير صحيح';
          });
          return;
        }

        final currentController = controller;
        if (currentController != null) {
          await currentController.initialize().then((_) {
            if (mounted && controller != null) {
              isShowVideoPlayer = true;
              controllerListener();
              setState(() {});
              controller!.play();
            }
          }).catchError((error) {
            log('Error initializing video: $error');
            if (mounted) {
              setState(() {
                hasError = true;
                errorMessage =
                    'فشل تحميل الفيديو. تأكد من اتصال الإنترنت أو أن الرابط صحيح';
              });
            }
          });
        }
      } else {
        String directory = (await getApplicationSupportDirectory()).path;
        print('${directory.toString()}/${widget.localFileName}');

        controller = VideoPlayerController.file(
          File('${directory.toString()}/${widget.localFileName}'),
        );

        final currentController = controller;
        if (currentController != null) {
          await currentController.initialize().then((_) {
            if (mounted && controller != null) {
              isShowVideoPlayer = true;
              controllerListener();
              setState(() {});
              controller!.play();
            }
          }).catchError((error) {
            log('Error initializing video: $error');
            if (mounted) {
              setState(() {
                hasError = true;
                errorMessage = 'فشل تحميل الفيديو من الملف المحلي';
              });
            }
          });
        }
      }
    } catch (e) {
      log('Error in initVideo: $e');
      if (mounted) {
        setState(() {
          hasError = true;
          errorMessage = 'حدث خطأ أثناء تحميل الفيديو';
        });
      }
    }
  }

  controllerListener() {
    if (controller == null) return;

    controller!.addListener(() {
      if (mounted && controller != null) {
        // Check for errors in controller
        if (controller!.value.hasError) {
          log('Video player error: ${controller!.value.errorDescription}');
          if (!hasError) {
            setState(() {
              hasError = true;
              errorMessage = controller!.value.errorDescription ??
                  'حدث خطأ أثناء تشغيل الفيديو';
            });
          }
          return;
        }

        if (controller!.value.isPlaying) {
          if (!isPlaying) {
            setState(() {
              isPlaying = true;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              if (mounted) {
                setState(() {
                  isShowPlayButton = false;
                });
              }
            });
          }
        } else {
          if (isPlaying) {
            setState(() {
              isPlaying = false;
              isShowPlayButton = true;
            });

            Future.delayed(const Duration(milliseconds: 1500)).then((value) {
              if (mounted) {
                setState(() {
                  isShowPlayButton = false;
                });
              }
            });
          }
        }

        if (videoPosition.inSeconds != controller!.value.position.inSeconds) {
          log("duration: ${controller!.value.duration.inSeconds.toString()}  position: ${controller!.value.position.inSeconds.toString()}");

          setState(() {
            videoPosition =
                Duration(seconds: controller!.value.position.inSeconds);
          });
        }

        if (videoDuration.inSeconds != controller!.value.duration.inSeconds) {
          setState(() {
            videoDuration =
                Duration(seconds: controller!.value.duration.inSeconds);
          });
        }
      }
    });
  }

  /// ترميز الـ URL للأحرف العربية بشكل صحيح
  String _encodeUrl(String url) {
    try {
      // تقسيم الـ URL يدوياً لتجنب مشاكل parsing مع الأحرف العربية
      final schemeEnd = url.indexOf('://');
      if (schemeEnd == -1) {
        log('Invalid URL format: $url');
        return url;
      }

      final scheme = url.substring(0, schemeEnd);
      final rest = url.substring(schemeEnd + 3);

      // تقسيم الـ host والمسار
      final pathStart = rest.indexOf('/');
      if (pathStart == -1) {
        // لا يوجد مسار، إرجاع الـ URL كما هو
        return url;
      }

      final host = rest.substring(0, pathStart);
      final pathAndQuery = rest.substring(pathStart);

      // تقسيم المسار والـ query
      final queryStart = pathAndQuery.indexOf('?');
      String path = queryStart != -1
          ? pathAndQuery.substring(0, queryStart)
          : pathAndQuery;
      String query =
          queryStart != -1 ? pathAndQuery.substring(queryStart + 1) : '';

      // ترميز المسار - تقسيمه إلى أجزاء وترميز كل جزء
      final pathSegments = path.split('/').where((s) => s.isNotEmpty).toList();
      final encodedSegments = pathSegments.map((segment) {
        return Uri.encodeComponent(segment);
      }).toList();

      // بناء المسار المرمز
      final encodedPath = '/${encodedSegments.join('/')}';

      // بناء الـ URL المرمز
      final encodedUrl = query.isNotEmpty
          ? '$scheme://$host$encodedPath?$query'
          : '$scheme://$host$encodedPath';

      log('Original URL: $url');
      log('Encoded URL: $encodedUrl');

      return encodedUrl;
    } catch (e) {
      log('Error encoding URL: $e, original URL: $url');
      // في حالة الخطأ، محاولة ترميز بسيط للـ URL كاملاً
      try {
        // ترميز الـ URL كاملاً باستخدام encodeFull
        final encoded = Uri.encodeFull(url);
        log('Fallback encoded URL: $encoded');
        return encoded;
      } catch (e2) {
        log('Error in fallback encoding: $e2');
        return url; // إرجاع الـ URL الأصلي في حالة الفشل
      }
    }
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

    // Show error widget if there's an error
    if (hasError) {
      return Container(
        height: videoHeight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.red.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            const Text(
              'خطأ في تحميل الفيديو',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                errorMessage ?? 'تأكد من اتصال الإنترنت',
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  hasError = false;
                  errorMessage = null;
                });
                initVideo();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
              ),
              child: const Text('إعادة المحاولة'),
            ),
          ],
        ),
      );
    }

    // Show loading indicator while video is initializing
    if (!isShowVideoPlayer) {
      return Container(
        height: videoHeight,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
          ),
        ),
      );
    }

    return Column(
      children: [
        // video
        if (isShowVideoPlayer && controller != null) ...{
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: controller!.value.isInitialized
                ? Stack(
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: VideoPlayer(controller!),
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
                            if (controller != null) {
                              if (isPlaying) {
                                controller!.pause();
                              } else {
                                controller!.play();
                              }
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
                            if (controller != null) {
                              if (isPlaying) {
                                controller!.pause();
                              } else {
                                controller!.play();
                              }
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
                              color: Colors.black,
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
                            if (controller != null) {
                              if (controller!.value.volume == 0.0) {
                                controller!.setVolume(1.0);
                              } else {
                                controller!.setVolume(0.0);
                              }
                              setState(() {});
                            }
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Icon(
                            controller != null &&
                                    controller!.value.volume == 0.0
                                ? Icons.volume_off
                                : Icons.volume_up,
                            color: const Color(0xFFd4af37),
                          ),
                        ),

                        const SizedBox(width: 22),

                        // full screen
                        GestureDetector(
                          onTap: () async {
                            if (controller != null) {
                              controller!.pause();

                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      FullScreenVideoPlayerWidget(
                                    controller!,
                                    name: widget.name,
                                  ),
                                ),
                              );

                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitUp,
                              ]);
                            }
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
              crossFadeState:
                  controller != null && controller!.value.isInitialized
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
              duration: const Duration(milliseconds: 300))
        },
      ],
    );
  }
}

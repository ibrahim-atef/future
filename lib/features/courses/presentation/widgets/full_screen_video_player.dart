import 'dart:async';
import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayerWidget extends StatefulWidget {
  final String name;
  final VideoPlayerController videoPlayerController;

  const FullScreenVideoPlayerWidget(this.videoPlayerController,
      {super.key, required this.name});

  @override
  State<FullScreenVideoPlayerWidget> createState() =>
      _FullScreenVideoPlayerWidgetState();
}

class _FullScreenVideoPlayerWidgetState
    extends State<FullScreenVideoPlayerWidget> {
  late ChewieController chewieController;

  // متغيرات لتحديد مكان النص
  double _watermarkPositionX = 0.0;
  double _watermarkPositionY = 0.0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // إعداد ChewieController
    chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
    );

    // إعداد الـ Timer لتحريك النص
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        if (_watermarkPositionX == 0.0 && _watermarkPositionY == 0.0) {
          // تحريك النص نحو المنتصف
          _watermarkPositionX = 0.5; // المنتصف أفقياً
          _watermarkPositionY = 0.5; // المنتصف رأسياً
        } else {
          // العودة إلى الزاوية العلوية اليسرى
          _watermarkPositionX = 0.0;
          _watermarkPositionY = 0.0;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // إيقاف الـ Timer عند التخلص من الشاشة
    chewieController.dispose();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: true,
        top: true,
        child: Stack(
          children: [
            // عرض الفيديو باستخدام Chewie

            Chewie(
              controller: chewieController,
            ),
            AnimatedPositioned(
              duration: const Duration(seconds: 1),
              // مدة الحركة
              // الحساب لتحديد مكان العلامة المائية أفقيًا ورأسيًا في وسط الفيديو
              right: _watermarkPositionX == 0.0
                  ? 20 // الزاوية العلوية اليسرى
                  : (MediaQuery.of(context).size.width / 2) - 100,
              // المنتصف أفقياً (للسهولة، قمنا بطرح 100 لأن عرض النص سيكون 200 تقريبًا)
              top: _watermarkPositionY ==
                      (MediaQuery.of(context).size.height / 2)
                  ? 20 // الزاوية العلوية اليسرى
                  : (MediaQuery.of(context).size.height / 2) - 50,
              // المنتصف رأسياً (حيث أن ارتفاع الشاشة هو 250، نقوم بتحديد المنتصف عن طريق الحساب)
              child: Container(
                padding: const EdgeInsets.all(8),
                color: Colors.transparent,
                child: Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 10, // حجم الخط
                    color: Colors.black.withOpacity(0.5), // شفافية النص
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            Positioned(
              left: 10,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.logout)),
            ),
            // أزرار التقديم والتأخير
            Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                // زر التأخير
                GestureDetector(
                  onTap: () {
                    final currentPosition =
                        widget.videoPlayerController.value.position;
                    final rewindPosition =
                        currentPosition - const Duration(seconds: 10);
                    widget.videoPlayerController.seekTo(
                      rewindPosition > Duration.zero
                          ? rewindPosition
                          : Duration.zero,
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.replay_10,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                // زر التقديم
                GestureDetector(
                  onTap: () {
                    final currentPosition =
                        widget.videoPlayerController.value.position;
                    final maxDuration =
                        widget.videoPlayerController.value.duration;
                    final forwardPosition =
                        currentPosition + const Duration(seconds: 10);
                    widget.videoPlayerController.seekTo(
                      forwardPosition < maxDuration
                          ? forwardPosition
                          : maxDuration,
                    );
                  },
                  child: Container(
                    width: 25,
                    height: 25,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.forward_10,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

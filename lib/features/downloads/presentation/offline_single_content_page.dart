import 'dart:io';
import 'package:flutter/material.dart';
import 'package:future_app/features/downloads/presentation/downloaded_video_player.dart';

class OfflineSingleContentPage extends StatefulWidget {
  static const String pageName = '/offline-single-content';
  final int courseId;
  final Map<String, dynamic> content;

  const OfflineSingleContentPage({
    super.key,
    required this.courseId,
    required this.content,
  });

  @override
  State<OfflineSingleContentPage> createState() =>
      _OfflineSingleContentPageState();
}

class _OfflineSingleContentPageState extends State<OfflineSingleContentPage> {
  String? videoPath;
  bool isLoading = true;
  String? errorMessage;

  List<String> videoFormats = [
    'mp4',
    'mkv',
    'mov',
    'wmv',
    'avi',
    'webm',
    'video'
  ];

  @override
  void initState() {
    super.initState();
    _loadContent();
  }

  Future<void> _loadContent() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      // TODO: Load content from local database
      // This is a placeholder - implement your database logic here
      String? localPath = widget.content['local_path'];
      
      if (localPath != null && 
          videoFormats.contains(widget.content['file_type']?.toLowerCase())) {
        File file = File(localPath);
        if (await file.exists()) {
          videoPath = localPath;
          setState(() {
            isLoading = false;
          });
        } else {
          setState(() {
            errorMessage = 'الملف غير موجود على الجهاز';
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'حدث خطأ في تحميل المحتوى: $e';
        isLoading = false;
      });
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
          'تفاصيل المحتوى',
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
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFd4af37)),
              ),
            )
          : errorMessage != null
              ? _buildErrorState()
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),

                      // Title
                      Text(
                        widget.content['title'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Video player button
                      if (videoPath != null) ...[
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: const Color(0xFFd4af37).withOpacity(0.3),
                            ),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.play_circle_filled,
                                color: Color(0xFFd4af37),
                                size: 60,
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DownloadedVideoPlayer(
                                        videoPath: videoPath!,
                                        videoTitle: widget.content['title'] ?? '',
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.play_arrow,
                                    color: Colors.black),
                                label: const Text(
                                  'تشغيل الفيديو',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
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
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],

                      // Offline indicator
                      Container(
                        width: double.infinity,
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
                              Icons.offline_bolt,
                              color: Color(0xFFd4af37),
                              size: 24,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'هذا المحتوى محمل محلياً - يعمل بدون إنترنت',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Content info
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF2a2a2a),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildInfoRow(
                              icon: Icons.category,
                              label: 'النوع',
                              value: widget.content['file_type']?.toString().toUpperCase() ??
                                  widget.content['type'] ?? 'غير محدد',
                            ),
                            if (widget.content['duration'] != null) ...[
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.access_time,
                                label: 'المدة',
                                value: '${widget.content['duration']} دقيقة',
                              ),
                            ],
                            if (widget.content['volume'] != null) ...[
                              const SizedBox(height: 12),
                              _buildInfoRow(
                                icon: Icons.storage,
                                label: 'الحجم',
                                value: widget.content['volume'],
                              ),
                            ],
                            const SizedBox(height: 12),
                            _buildInfoRow(
                              icon: Icons.download_done,
                              label: 'قابل للتحميل',
                              value: widget.content['downloadable'] == 1 ? 'نعم' : 'لا',
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Description
                      if (widget.content['description'] != null) ...[
                        const Text(
                          'الوصف',
                          style: TextStyle(
                            color: Color(0xFFd4af37),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2a2a2a),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            widget.content['description'],
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
      bottomNavigationBar: errorMessage == null
          ? Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF2a2a2a),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.1),
                    blurRadius: 15,
                    offset: const Offset(0, -3),
                  ),
                ],
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(30)),
              ),
              child: SafeArea(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFd4af37),
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'رجوع',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : null,
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            const SizedBox(height: 16),
            const Text(
              'حدث خطأ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              errorMessage ?? 'خطأ غير معروف',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                _loadContent();
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

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFFd4af37),
          size: 20,
        ),
        const SizedBox(width: 12),
        Text(
          '$label: ',
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}


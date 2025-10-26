import 'package:flutter/material.dart';
import 'package:future_app/features/downloads/presentation/downloaded_video_player.dart';
import 'package:future_app/core/models/download_model.dart';

class OfflineSingleCoursePage extends StatefulWidget {
  static const String pageName = '/offline-single-course';
  final Map<String, dynamic> course;

  const OfflineSingleCoursePage({super.key, required this.course});

  @override
  State<OfflineSingleCoursePage> createState() =>
      _OfflineSingleCoursePageState();
}

class _OfflineSingleCoursePageState extends State<OfflineSingleCoursePage>
    with SingleTickerProviderStateMixin {
  List<Map<String, dynamic>> contents = [];
  late TabController tabController;
  bool viewMore = false;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    _loadCourseContents();
  }

  Future<void> _loadCourseContents() async {
    // Load videos from the course data
    final videos = widget.course['videos'] as List<DownloadedVideoModel>? ?? [];
    setState(() {
      contents = videos
          .map((video) => {
                'id': video.id,
                'title': video.title,
                'description': video.description,
                'duration': video.durationText,
                'fileSize': '${video.fileSizeMb.toStringAsFixed(1)} MB',
                'localPath': video.localPath,
                'video': video,
              })
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1a1a1a),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: Text(
          widget.course['title'] ?? '',
          style: const TextStyle(
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
      body: Column(
        children: [
          // Tab bar
          Container(
            color: const Color(0xFF2a2a2a),
            child: TabBar(
              controller: tabController,
              indicatorColor: const Color(0xFFd4af37),
              labelColor: const Color(0xFFd4af37),
              unselectedLabelColor: Colors.white70,
              tabs: const [
                Tab(text: 'المعلومات', height: 45),
                Tab(text: 'المحتوى', height: 45),
              ],
            ),
          ),

          // Body
          Expanded(
            child: TabBarView(
              controller: tabController,
              children: [
                _informationTab(),
                _contentTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _informationTab() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15),

          // Description
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF2a2a2a),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'الوصف',
                  style: TextStyle(
                    color: Color(0xFFd4af37),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  widget.course['description'] ?? 'لا يوجد وصف متاح',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    height: 1.5,
                  ),
                  maxLines: viewMore ? null : 10,
                  overflow: viewMore ? null : TextOverflow.ellipsis,
                ),
                if (!viewMore &&
                    (widget.course['description']?.length ?? 0) > 200) ...[
                  const SizedBox(height: 8),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          viewMore = true;
                        });
                      },
                      child: const Text(
                        'عرض المزيد',
                        style: TextStyle(color: Color(0xFFd4af37)),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Course Info
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildInfoItem(
                icon: Icons.people,
                label: 'الطلاب',
                value: widget.course['students_count']?.toString() ?? '0',
              ),
              _buildInfoItem(
                icon: Icons.menu_book,
                label: 'الفصول',
                value: contents.length.toString(),
              ),
              _buildInfoItem(
                icon: Icons.access_time,
                label: 'المدة',
                value: '${widget.course['duration'] ?? '0'} ساعة',
              ),
              _buildInfoItem(
                icon: Icons.video_library,
                label: 'النوع',
                value: widget.course['type'] ?? 'كورس',
              ),
            ],
          ),

          const SizedBox(height: 20),

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
                    'هذا الكورس متاح بدون إنترنت',
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
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFd4af37).withOpacity(0.2),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFd4af37),
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentTab() {
    if (contents.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.folder_open,
                color: Color(0xFFd4af37),
                size: 60,
              ),
              SizedBox(height: 16),
              Text(
                'لا يوجد محتوى متاح',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'لم يتم تحميل أي محتوى لهذا الكورس بعد',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 8),
          ...List.generate(contents.length, (index) {
            return _buildVideoItem(contents[index]);
          }),
          const SizedBox(height: 12),
        ],
      ),
    );
  }

  Widget _buildVideoItem(Map<String, dynamic> item) {
    final video = item['video'] as DownloadedVideoModel?;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF2a2a2a),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFFd4af37).withOpacity(0.3),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            if (video != null) {
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
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFd4af37).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.play_circle_filled,
                    color: Color(0xFFd4af37),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'] ?? '',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['duration'] ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Icon(
                            Icons.storage,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            item['fileSize'] ?? '',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      const Row(
                        children: [
                          Icon(
                            Icons.offline_bolt,
                            color: Color(0xFFd4af37),
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'متاح أوفلاين',
                            style: TextStyle(
                              color: Color(0xFFd4af37),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.play_arrow,
                  color: Color(0xFFd4af37),
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
}

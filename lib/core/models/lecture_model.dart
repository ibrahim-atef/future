class LectureModel {
  final String id;
  final String courseId;
  final String title;
  final String? description;
  final String? excerpt;
  final String type; // video, pdf, audio, quiz
  final String? videoUrl;
  final String? videoSource; // html5, youtube
  final String? pdfUrl;
  final String? audioUrl;
  final String? thumbnailUrl;
  final int duration; // in seconds
  final String? durationTextFromApi;
  final int order;
  final String week;
  final String module;
  final bool isFree;
  final bool isDownloadable;
  final bool isVideoDownloadable;
  final DateTime createdAt;
  final DateTime updatedAt;

  LectureModel({
    required this.id,
    required this.courseId,
    required this.title,
    this.description,
    this.excerpt,
    required this.type,
    this.videoUrl,
    this.videoSource,
    this.pdfUrl,
    this.audioUrl,
    this.thumbnailUrl,
    this.duration = 0,
    this.durationTextFromApi,
    this.order = 0,
    this.week = '',
    this.module = '',
    this.isFree = false,
    this.isDownloadable = true,
    this.isVideoDownloadable = false,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LectureModel.fromJson(Map<String, dynamic> json) {
    return LectureModel(
      id: json['id']?.toString() ?? '',
      courseId: json['courseId']?.toString() ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      excerpt: json['excerpt'],
      type: json['type'] ?? 'video',
      videoUrl: json['videoUrl'],
      videoSource: json['videoSource'],
      pdfUrl: json['pdfUrl'],
      audioUrl: json['audioUrl'],
      thumbnailUrl: json['thumbnailUrl'],
      duration: json['duration'] ?? 0,
      durationTextFromApi: json['durationText'],
      order: json['order'] ?? 0,
      week: json['week'] ?? '',
      module: json['module'] ?? '',
      isFree: json['isFree'] ?? false,
      isDownloadable: json['isDownloadable'] ?? true,
      isVideoDownloadable: json['isVideoDownloadable'] ?? false,
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      updatedAt:
          DateTime.parse(json['updatedAt'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseId': courseId,
      'title': title,
      'description': description,
      'excerpt': excerpt,
      'type': type,
      'videoUrl': videoUrl,
      'videoSource': videoSource,
      'pdfUrl': pdfUrl,
      'audioUrl': audioUrl,
      'thumbnailUrl': thumbnailUrl,
      'duration': duration,
      'durationText': durationTextFromApi,
      'order': order,
      'week': week,
      'module': module,
      'isFree': isFree,
      'isDownloadable': isDownloadable,
      'isVideoDownloadable': isVideoDownloadable,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get durationText {
    if (duration <= 0) return '';

    final hours = duration ~/ 3600;
    final minutes = (duration % 3600) ~/ 60;
    final seconds = duration % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  String get contentUrl {
    switch (type) {
      case 'video':
        return videoUrl ?? '';
      case 'pdf':
        return pdfUrl ?? '';
      case 'audio':
        return audioUrl ?? '';
      default:
        return '';
    }
  }
}

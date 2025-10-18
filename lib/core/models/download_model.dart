import 'package:json_annotation/json_annotation.dart';

part 'download_model.g.dart';

@JsonSerializable()
class DownloadResponseModel {
  final bool success;
  final String message;
  final DownloadData data;

  const DownloadResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory DownloadResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadResponseModelToJson(this);
}

@JsonSerializable()
class DownloadData {
  @JsonKey(name: 'lesson_id')
  final String lessonId;
  @JsonKey(name: 'course_id')
  final String courseId;
  final String title;
  final String description;
  @JsonKey(name: 'video_url')
  final String videoUrl;
  @JsonKey(name: 'file_size', defaultValue: 0)
  final int fileSize;
  @JsonKey(name: 'file_size_mb', defaultValue: 0.0)
  final double fileSizeMb;
  @JsonKey(name: 'file_type', defaultValue: 'video/mp4')
  final String fileType;
  @JsonKey(defaultValue: 0)
  final int duration;
  @JsonKey(name: 'duration_text', defaultValue: '')
  final String durationText;
  @JsonKey(name: 'downloadable', defaultValue: true)
  final bool downloadable;
  @JsonKey(name: 'video_source')
  final String videoSource;
  @JsonKey(name: 'download_note', defaultValue: '')
  final String downloadNote;

  const DownloadData({
    required this.lessonId,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    this.fileSize = 0,
    this.fileSizeMb = 0.0,
    this.fileType = 'video/mp4',
    this.duration = 0,
    this.durationText = '',
    this.downloadable = true,
    required this.videoSource,
    this.downloadNote = '',
  });

  factory DownloadData.fromJson(Map<String, dynamic> json) =>
      _$DownloadDataFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadDataToJson(this);
}

// Downloaded video model for local storage
@JsonSerializable()
class DownloadedVideoModel {
  final String id;
  final String lessonId;
  final String courseId;
  final String title;
  final String description;
  final String videoUrl;
  final String localPath;
  final int fileSize;
  final double fileSizeMb;
  final String fileType;
  final int duration;
  final String durationText;
  final String videoSource;
  final DateTime downloadedAt;
  final String thumbnailPath;

  const DownloadedVideoModel({
    required this.id,
    required this.lessonId,
    required this.courseId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.localPath,
    required this.fileSize,
    required this.fileSizeMb,
    required this.fileType,
    required this.duration,
    required this.durationText,
    required this.videoSource,
    required this.downloadedAt,
    required this.thumbnailPath,
  });

  factory DownloadedVideoModel.fromJson(Map<String, dynamic> json) =>
      _$DownloadedVideoModelFromJson(json);

  Map<String, dynamic> toJson() => _$DownloadedVideoModelToJson(this);
}

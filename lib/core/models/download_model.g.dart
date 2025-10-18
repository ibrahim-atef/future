// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DownloadResponseModel _$DownloadResponseModelFromJson(
        Map<String, dynamic> json) =>
    DownloadResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: DownloadData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$DownloadResponseModelToJson(
        DownloadResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

DownloadData _$DownloadDataFromJson(Map<String, dynamic> json) => DownloadData(
      lessonId: json['lesson_id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['video_url'] as String,
      fileSize: (json['file_size'] as num?)?.toInt() ?? 0,
      fileSizeMb: (json['file_size_mb'] as num?)?.toDouble() ?? 0.0,
      fileType: json['file_type'] as String? ?? 'video/mp4',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      durationText: json['duration_text'] as String? ?? '',
      downloadable: json['downloadable'] as bool? ?? true,
      videoSource: json['video_source'] as String,
      downloadNote: json['download_note'] as String? ?? '',
    );

Map<String, dynamic> _$DownloadDataToJson(DownloadData instance) =>
    <String, dynamic>{
      'lesson_id': instance.lessonId,
      'course_id': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'video_url': instance.videoUrl,
      'file_size': instance.fileSize,
      'file_size_mb': instance.fileSizeMb,
      'file_type': instance.fileType,
      'duration': instance.duration,
      'duration_text': instance.durationText,
      'downloadable': instance.downloadable,
      'video_source': instance.videoSource,
      'download_note': instance.downloadNote,
    };

DownloadedVideoModel _$DownloadedVideoModelFromJson(
        Map<String, dynamic> json) =>
    DownloadedVideoModel(
      id: json['id'] as String,
      lessonId: json['lessonId'] as String,
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      videoUrl: json['videoUrl'] as String,
      localPath: json['localPath'] as String,
      fileSize: (json['fileSize'] as num).toInt(),
      fileSizeMb: (json['fileSizeMb'] as num).toDouble(),
      fileType: json['fileType'] as String,
      duration: (json['duration'] as num).toInt(),
      durationText: json['durationText'] as String,
      videoSource: json['videoSource'] as String,
      downloadedAt: DateTime.parse(json['downloadedAt'] as String),
      thumbnailPath: json['thumbnailPath'] as String,
    );

Map<String, dynamic> _$DownloadedVideoModelToJson(
        DownloadedVideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'lessonId': instance.lessonId,
      'courseId': instance.courseId,
      'title': instance.title,
      'description': instance.description,
      'videoUrl': instance.videoUrl,
      'localPath': instance.localPath,
      'fileSize': instance.fileSize,
      'fileSizeMb': instance.fileSizeMb,
      'fileType': instance.fileType,
      'duration': instance.duration,
      'durationText': instance.durationText,
      'videoSource': instance.videoSource,
      'downloadedAt': instance.downloadedAt.toIso8601String(),
      'thumbnailPath': instance.thumbnailPath,
    };

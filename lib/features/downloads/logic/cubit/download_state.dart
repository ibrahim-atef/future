import 'package:future_app/core/models/download_model.dart';

abstract class DownloadState {}

class DownloadInitial extends DownloadState {}

class DownloadLoading extends DownloadState {}

class DownloadInProgress extends DownloadState {
  final int progress; // 0-100
  final String? message;

  DownloadInProgress(this.progress, {this.message});
}

class DownloadSuccess extends DownloadState {
  final DownloadResponseModel response;

  DownloadSuccess(this.response);
}

class DownloadError extends DownloadState {
  final String message;

  DownloadError(this.message);
}

class GetDownloadedVideosLoading extends DownloadState {}

class GetDownloadedVideosSuccess extends DownloadState {
  final List<DownloadedVideoModel> videos;

  GetDownloadedVideosSuccess(this.videos);
}

class GetDownloadedVideosError extends DownloadState {
  final String message;

  GetDownloadedVideosError(this.message);
}

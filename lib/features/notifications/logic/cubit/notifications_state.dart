import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/core/network/api_error_model.dart';
import 'package:future_app/features/notifications/data/models/notifications_model.dart';

part 'notifications_state.freezed.dart';

@freezed
class NotificationsState with _$NotificationsState {
  const factory NotificationsState.initial() = _Initial;

  // Get notifications
  const factory NotificationsState.getNotificationsLoading() =
      GetNotificationsLoading;
  const factory NotificationsState.getNotificationsSuccess(
      GetNotificationsResponseModel data) = GetNotificationsSuccess;
  const factory NotificationsState.getNotificationsError(
      ApiErrorModel apiErrorModel) = GetNotificationsError;

  // Mark notification as read
  const factory NotificationsState.markNotificationAsReadLoading() =
      MarkNotificationAsReadLoading;
  const factory NotificationsState.markNotificationAsReadSuccess(
      MarkNotificationReadResponseModel data) = MarkNotificationAsReadSuccess;
  const factory NotificationsState.markNotificationAsReadError(
      ApiErrorModel apiErrorModel) = MarkNotificationAsReadError;

  // Delete notification
  const factory NotificationsState.deleteNotificationLoading() =
      DeleteNotificationLoading;
  const factory NotificationsState.deleteNotificationSuccess(
      DeleteNotificationResponseModel data) = DeleteNotificationSuccess;
  const factory NotificationsState.deleteNotificationError(
      ApiErrorModel apiErrorModel) = DeleteNotificationError;
}


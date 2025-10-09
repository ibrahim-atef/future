import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/notifications/data/models/notifications_model.dart';
import 'package:future_app/features/notifications/data/repos/notifications_repo.dart';
import 'package:future_app/features/notifications/logic/cubit/notifications_state.dart';
import 'dart:developer';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._notificationsRepo)
      : super(const NotificationsState.initial());

  final NotificationsRepo _notificationsRepo;

  // Local state for notifications
  List<NotificationModel> _notifications = [];
  int _unreadCount = 0;

  // Getters
  List<NotificationModel> get notifications => _notifications;
  int get unreadCount => _unreadCount;

  // Get user notifications
  Future<void> getUserNotifications(String userId) async {
    log('🚀 NotificationsCubit: Starting getUserNotifications for userId: $userId');
    emit(const NotificationsState.getNotificationsLoading());
    final response = await _notificationsRepo.getUserNotifications(userId);
    response.when(
      success: (data) {
        log('✅ NotificationsCubit: Notifications success - ${data.data.notifications.length} notifications');
        _notifications = data.data.notifications;
        _unreadCount = data.data.unreadCount;
        emit(NotificationsState.getNotificationsSuccess(data));
      },
      failure: (apiErrorModel) {
        log('❌ NotificationsCubit: Notifications failed - ${apiErrorModel.message}');
        emit(NotificationsState.getNotificationsError(apiErrorModel));
      },
    );
  }

  // Mark notification as read
  Future<void> markNotificationAsRead(
      String notificationId, String userId) async {
    log('🚀 NotificationsCubit: Starting markNotificationAsRead for notificationId: $notificationId');
    emit(const NotificationsState.markNotificationAsReadLoading());
    final response =
        await _notificationsRepo.markNotificationAsRead(notificationId);
    response.when(
      success: (data) {
        log('✅ NotificationsCubit: Mark notification as read success');
        // Update local state
        _updateNotificationReadStatus(notificationId, true);
        emit(NotificationsState.markNotificationAsReadSuccess(data));
        // Refresh notifications to get updated list
        getUserNotifications(userId);
      },
      failure: (apiErrorModel) {
        log('❌ NotificationsCubit: Mark notification as read failed - ${apiErrorModel.message}');
        emit(NotificationsState.markNotificationAsReadError(apiErrorModel));
      },
    );
  }

  // Delete notification
  Future<void> deleteNotification(String notificationId, String userId) async {
    log('🚀 NotificationsCubit: Starting deleteNotification for notificationId: $notificationId');
    emit(const NotificationsState.deleteNotificationLoading());
    final response =
        await _notificationsRepo.deleteNotification(notificationId);
    response.when(
      success: (data) {
        log('✅ NotificationsCubit: Delete notification success');
        // Update local state
        _removeNotificationFromList(notificationId);
        emit(NotificationsState.deleteNotificationSuccess(data));
        // Refresh notifications to get updated list
        getUserNotifications(userId);
      },
      failure: (apiErrorModel) {
        log('❌ NotificationsCubit: Delete notification failed - ${apiErrorModel.message}');
        emit(NotificationsState.deleteNotificationError(apiErrorModel));
      },
    );
  }

  // Mark all notifications as read
  Future<void> markAllAsRead(String userId) async {
    log('🚀 NotificationsCubit: Starting markAllAsRead');
    // Get all unread notifications
    final unreadNotifications =
        _notifications.where((notif) => !notif.isRead).toList();

    // Mark each unread notification as read
    for (var notification in unreadNotifications) {
      await _notificationsRepo.markNotificationAsRead(notification.id);
    }

    // Refresh the notifications list
    await getUserNotifications(userId);
  }

  // Helper method to update notification read status in local state
  void _updateNotificationReadStatus(String notificationId, bool isRead) {
    final index =
        _notifications.indexWhere((notif) => notif.id == notificationId);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: isRead);
      if (isRead) {
        _unreadCount = (_unreadCount - 1).clamp(0, _notifications.length);
      }
    }
  }

  // Helper method to remove notification from local state
  void _removeNotificationFromList(String notificationId) {
    final index =
        _notifications.indexWhere((notif) => notif.id == notificationId);
    if (index != -1) {
      final wasUnread = !_notifications[index].isRead;
      _notifications.removeAt(index);
      if (wasUnread) {
        _unreadCount = (_unreadCount - 1).clamp(0, _notifications.length);
      }
    }
  }

  // Refresh notifications
  Future<void> refresh(String userId) async {
    await getUserNotifications(userId);
  }
}


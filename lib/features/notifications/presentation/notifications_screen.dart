import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/di/di.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/features/notifications/logic/cubit/notifications_cubit.dart';
import 'package:future_app/features/notifications/logic/cubit/notifications_state.dart';
import 'package:future_app/features/notifications/data/models/notifications_model.dart';
import 'package:skeletonizer/skeletonizer.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<NotificationsCubit>()
        ..getUserNotifications(UserConstant.userId.toString()),
      child: const _NotificationsScreenContent(),
    );
  }
}

class _NotificationsScreenContent extends StatelessWidget {
  const _NotificationsScreenContent();

  @override
  Widget build(BuildContext context) {
    String userId = UserConstant.userId ?? '1'; //

    return Scaffold(
      backgroundColor: const Color(0xFF0D0D0D),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1a1a1a),
        elevation: 0,
        title: const Text(
          'التنبيهات',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: const [],
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(
              child: CircularProgressIndicator(
                color: Color(0xFFd4af37),
              ),
            ),
            getNotificationsLoading: () => _buildLoadingSkeleton(),
            getNotificationsSuccess: (data) =>
                _buildNotificationsList(context, data, userId),
            getNotificationsError: (error) => _buildErrorState(
              context,
              error.getAllErrorsAsString(),
              userId,
            ),
            markNotificationAsReadLoading: () => _buildNotificationsList(
              context,
              GetNotificationsResponseModel(
                success: true,
                message: '',
                data: NotificationsData(
                  notifications:
                      context.read<NotificationsCubit>().notifications,
                  unreadCount: context.read<NotificationsCubit>().unreadCount,
                  pagination: PaginationModel(
                    currentPage: 1,
                    perPage: 10,
                    totalItems:
                        context.read<NotificationsCubit>().notifications.length,
                    totalPages: 1,
                  ),
                ),
              ),
              userId,
            ),
            markNotificationAsReadSuccess: (_) => _buildNotificationsList(
              context,
              GetNotificationsResponseModel(
                success: true,
                message: '',
                data: NotificationsData(
                  notifications:
                      context.read<NotificationsCubit>().notifications,
                  unreadCount: context.read<NotificationsCubit>().unreadCount,
                  pagination: PaginationModel(
                    currentPage: 1,
                    perPage: 10,
                    totalItems:
                        context.read<NotificationsCubit>().notifications.length,
                    totalPages: 1,
                  ),
                ),
              ),
              userId,
            ),
            markNotificationAsReadError: (error) {
              // Show snackbar for error but keep showing the list
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.getAllErrorsAsString()),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              return _buildNotificationsList(
                context,
                GetNotificationsResponseModel(
                  success: true,
                  message: '',
                  data: NotificationsData(
                    notifications:
                        context.read<NotificationsCubit>().notifications,
                    unreadCount: context.read<NotificationsCubit>().unreadCount,
                    pagination: PaginationModel(
                      currentPage: 1,
                      perPage: 10,
                      totalItems: context
                          .read<NotificationsCubit>()
                          .notifications
                          .length,
                      totalPages: 1,
                    ),
                  ),
                ),
                userId,
              );
            },
            deleteNotificationLoading: () => _buildNotificationsList(
              context,
              GetNotificationsResponseModel(
                success: true,
                message: '',
                data: NotificationsData(
                  notifications:
                      context.read<NotificationsCubit>().notifications,
                  unreadCount: context.read<NotificationsCubit>().unreadCount,
                  pagination: PaginationModel(
                    currentPage: 1,
                    perPage: 10,
                    totalItems:
                        context.read<NotificationsCubit>().notifications.length,
                    totalPages: 1,
                  ),
                ),
              ),
              userId,
            ),
            deleteNotificationSuccess: (_) => _buildNotificationsList(
              context,
              GetNotificationsResponseModel(
                success: true,
                message: '',
                data: NotificationsData(
                  notifications:
                      context.read<NotificationsCubit>().notifications,
                  unreadCount: context.read<NotificationsCubit>().unreadCount,
                  pagination: PaginationModel(
                    currentPage: 1,
                    perPage: 10,
                    totalItems:
                        context.read<NotificationsCubit>().notifications.length,
                    totalPages: 1,
                  ),
                ),
              ),
              userId,
            ),
            deleteNotificationError: (error) {
              // Show snackbar for error but keep showing the list
              WidgetsBinding.instance.addPostFrameCallback((_) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(error.getAllErrorsAsString()),
                    backgroundColor: Colors.red,
                  ),
                );
              });
              return _buildNotificationsList(
                context,
                GetNotificationsResponseModel(
                  success: true,
                  message: '',
                  data: NotificationsData(
                    notifications:
                        context.read<NotificationsCubit>().notifications,
                    unreadCount: context.read<NotificationsCubit>().unreadCount,
                    pagination: PaginationModel(
                      currentPage: 1,
                      perPage: 10,
                      totalItems: context
                          .read<NotificationsCubit>()
                          .notifications
                          .length,
                      totalPages: 1,
                    ),
                  ),
                ),
                userId,
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildLoadingSkeleton() {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xFF2a2a2a),
        highlightColor: Color(0xFF3a3a3a),
        duration: Duration(seconds: 1),
      ),
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 8,
        itemBuilder: (context, index) {
          return _buildNotificationCard(
            context,
            NotificationModel(
              id: 'loading-$index',
              userId: 'loading',
              title: 'تنبيه جديد من الكورسات',
              message:
                  'هذا نص تجريبي لتنبيه جديد في التطبيق يحتوي على معلومات مهمة',
              type: index % 4 == 0
                  ? 'course'
                  : index % 4 == 1
                      ? 'blog'
                      : index % 4 == 2
                          ? 'download'
                          : 'system',
              isRead: index % 3 == 0,
              createdAt: DateTime.now().toIso8601String(),
            ),
            '1',
            isLoading: true,
          );
        },
      ),
    );
  }

  Widget _buildNotificationsList(
      BuildContext context, GetNotificationsResponseModel data, String userId) {
    final notifications = data.data.notifications;

    if (notifications.isEmpty) {
      return _buildEmptyState(context, userId);
    }

    return RefreshIndicator(
      color: const Color(0xFFd4af37),
      backgroundColor: const Color(0xFF2a2a2a),
      onRefresh: () async {
        await context.read<NotificationsCubit>().refresh(userId);
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return _buildNotificationCard(
            context,
            notifications[index],
            userId,
          );
        },
      ),
    );
  }

  Widget _buildNotificationCard(
    BuildContext context,
    NotificationModel notification,
    String userId, {
    bool isLoading = false,
  }) {
    return Dismissible(
      key: Key(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF2a2a2a), Color(0xFFd32f2f)],
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.delete_outline,
              color: Colors.white,
              size: 28,
            ),
            SizedBox(height: 4),
            Text(
              'حذف',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (direction) {
        if (!isLoading) {
          // Immediately remove from local state to prevent Dismissible error
          context
              .read<NotificationsCubit>()
              .removeNotificationFromList(notification.id);
          // Then call delete API
          context
              .read<NotificationsCubit>()
              .deleteNotification(notification.id, userId);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                'تم حذف التنبيه',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: const Color(0xFF2a2a2a),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          gradient: notification.isRead
              ? const LinearGradient(
                  colors: [Color(0xFF1a1a1a), Color(0xFF2a2a2a)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : const LinearGradient(
                  colors: [Color(0xFF2a2a2a), Color(0xFF1f1f1f)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: notification.isRead
                ? Colors.transparent
                : const Color(0xFFd4af37).withOpacity(0.3),
            width: 1.5,
          ),
          boxShadow: [
            if (!notification.isRead)
              BoxShadow(
                color: const Color(0xFFd4af37).withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: const Color(0xFFd4af37).withOpacity(0.1),
            highlightColor: const Color(0xFFd4af37).withOpacity(0.05),
            onTap: isLoading
                ? null
                : () {
                    // Mark notification as read when tapped
                    context
                        .read<NotificationsCubit>()
                        .markNotificationAsRead(notification.id, userId);
                    _handleNotificationTap(context, notification);
                  },
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Notification Icon
                  Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          _getNotificationColor(notification.type)
                              .withOpacity(0.25),
                          _getNotificationColor(notification.type)
                              .withOpacity(0.15),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _getNotificationColor(notification.type)
                            .withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      _getNotificationIcon(notification.type),
                      color: _getNotificationColor(notification.type),
                      size: 26,
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Notification Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                notification.title,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: notification.isRead
                                      ? FontWeight.w500
                                      : FontWeight.bold,
                                  height: 1.3,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!notification.isRead)
                              Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFd4af37),
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFd4af37)
                                          .withOpacity(0.5),
                                      blurRadius: 4,
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(
                          notification.message,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: 14,
                              color: const Color(0xFFd4af37).withOpacity(0.7),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              notification.timeAgoText,
                              style: TextStyle(
                                color: const Color(0xFFd4af37).withOpacity(0.7),
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 3,
                              ),
                              decoration: BoxDecoration(
                                color: _getNotificationColor(notification.type)
                                    .withOpacity(0.15),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color:
                                      _getNotificationColor(notification.type)
                                          .withOpacity(0.3),
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                _getNotificationTypeLabel(notification.type),
                                style: TextStyle(
                                  color:
                                      _getNotificationColor(notification.type),
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, String userId) {
    return RefreshIndicator(
      color: const Color(0xFFd4af37),
      backgroundColor: const Color(0xFF2a2a2a),
      onRefresh: () async {
        await context.read<NotificationsCubit>().refresh(userId);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2a2a2a), Color(0xFF1a1a1a)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFd4af37).withOpacity(0.3),
                      width: 2,
                    ),
                  ),
                  child: Icon(
                    Icons.notifications_none_outlined,
                    size: 60,
                    color: const Color(0xFFd4af37).withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'لا توجد تنبيهات',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'سيتم عرض جميع التنبيهات والإشعارات هنا\nعند وصولها',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.5),
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, String message, String userId) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.red.withOpacity(0.2),
                    Colors.red.withOpacity(0.1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.red.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 50,
                color: Colors.red.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'حدث خطأ',
              style: TextStyle(
                color: Colors.white.withOpacity(0.9),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () {
                context.read<NotificationsCubit>().refresh(userId);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFd4af37),
                foregroundColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 0,
              ),
              icon: const Icon(Icons.refresh, size: 20),
              label: const Text(
                'إعادة المحاولة',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'course':
        return Icons.school_outlined;
      case 'blog':
        return Icons.article_outlined;
      case 'download':
        return Icons.download_outlined;
      case 'system':
      default:
        return Icons.notifications_active_outlined;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'course':
        return const Color(0xFFd4af37); // Gold
      case 'blog':
        return const Color(0xFFFF9800); // Orange
      case 'download':
        return const Color(0xFF4CAF50); // Green
      case 'system':
      default:
        return const Color(0xFF2196F3); // Blue
    }
  }

  String _getNotificationTypeLabel(String type) {
    switch (type) {
      case 'course':
        return 'كورس';
      case 'blog':
        return 'مدونة';
      case 'download':
        return 'تحميل';
      case 'system':
      default:
        return 'عام';
    }
  }

  void _handleNotificationTap(
      BuildContext context, NotificationModel notification) {
    // TODO: Implement navigation based on notification type and relatedId
    // For now, just show a snackbar with better styling
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              _getNotificationIcon(notification.type),
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                'تم فتح التنبيه: ${notification.title}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2a2a2a),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: const Color(0xFFd4af37).withOpacity(0.3),
            width: 1,
          ),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}

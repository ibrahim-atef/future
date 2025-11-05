// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notifications_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetNotificationsResponseModel _$GetNotificationsResponseModelFromJson(
        Map<String, dynamic> json) =>
    GetNotificationsResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: NotificationsData.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetNotificationsResponseModelToJson(
        GetNotificationsResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

NotificationsData _$NotificationsDataFromJson(Map<String, dynamic> json) =>
    NotificationsData(
      notifications: (json['notifications'] as List<dynamic>)
          .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      unreadCount: (json['unread_count'] as num).toInt(),
      pagination:
          PaginationModel.fromJson(json['pagination'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationsDataToJson(NotificationsData instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'unread_count': instance.unreadCount,
      'pagination': instance.pagination,
    };

PaginationModel _$PaginationModelFromJson(Map<String, dynamic> json) =>
    PaginationModel(
      currentPage: (json['current_page'] as num).toInt(),
      perPage: (json['per_page'] as num).toInt(),
      totalItems: (json['total_items'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PaginationModelToJson(PaginationModel instance) =>
    <String, dynamic>{
      'current_page': instance.currentPage,
      'per_page': instance.perPage,
      'total_items': instance.totalItems,
      'total_pages': instance.totalPages,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      relatedId: json['relatedId'] as String?,
      imageUrl: json['imageUrl'],
      isRead: json['isRead'] as bool,
      createdAt: json['createdAt'] as String,
      courseId: json['course_id'] as String?,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'relatedId': instance.relatedId,
      'imageUrl': instance.imageUrl,
      'isRead': instance.isRead,
      'createdAt': instance.createdAt,
      'course_id': instance.courseId,
    };

MarkNotificationReadResponseModel _$MarkNotificationReadResponseModelFromJson(
        Map<String, dynamic> json) =>
    MarkNotificationReadResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : MarkNotificationReadData.fromJson(
              json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarkNotificationReadResponseModelToJson(
        MarkNotificationReadResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };

MarkNotificationReadData _$MarkNotificationReadDataFromJson(
        Map<String, dynamic> json) =>
    MarkNotificationReadData(
      notificationId: json['notification_id'] as String? ?? '',
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['read_at'] as String?,
    );

Map<String, dynamic> _$MarkNotificationReadDataToJson(
        MarkNotificationReadData instance) =>
    <String, dynamic>{
      'notification_id': instance.notificationId,
      'isRead': instance.isRead,
      'read_at': instance.readAt,
    };

DeleteNotificationResponseModel _$DeleteNotificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    DeleteNotificationResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$DeleteNotificationResponseModelToJson(
        DeleteNotificationResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };

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
    );

Map<String, dynamic> _$NotificationsDataToJson(NotificationsData instance) =>
    <String, dynamic>{
      'notifications': instance.notifications,
      'unread_count': instance.unreadCount,
    };

NotificationModel _$NotificationModelFromJson(Map<String, dynamic> json) =>
    NotificationModel(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      message: json['message'] as String,
      type: json['type'] as String,
      relatedId: json['related_id'] as String?,
      imageUrl: json['image_url'] as String?,
      isRead: json['is_read'] as bool,
      createdAt: json['created_at'] as String,
    );

Map<String, dynamic> _$NotificationModelToJson(NotificationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'title': instance.title,
      'message': instance.message,
      'type': instance.type,
      'related_id': instance.relatedId,
      'image_url': instance.imageUrl,
      'is_read': instance.isRead,
      'created_at': instance.createdAt,
    };

MarkNotificationReadResponseModel _$MarkNotificationReadResponseModelFromJson(
        Map<String, dynamic> json) =>
    MarkNotificationReadResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : NotificationModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarkNotificationReadResponseModelToJson(
        MarkNotificationReadResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
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

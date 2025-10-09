import 'package:json_annotation/json_annotation.dart';

part 'notifications_model.g.dart';

// ==================== Get Notifications Response ====================
@JsonSerializable()
class GetNotificationsResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final NotificationsData data;

  GetNotificationsResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory GetNotificationsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationsResponseModelToJson(this);
}

@JsonSerializable()
class NotificationsData {
  @JsonKey(name: 'notifications')
  final List<NotificationModel> notifications;

  @JsonKey(name: 'unread_count')
  final int unreadCount;

  NotificationsData({
    required this.notifications,
    required this.unreadCount,
  });

  factory NotificationsData.fromJson(Map<String, dynamic> json) =>
      _$NotificationsDataFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationsDataToJson(this);
}

@JsonSerializable()
class NotificationModel {
  @JsonKey(name: 'id')
  final String id;

  @JsonKey(name: 'user_id')
  final String userId;

  @JsonKey(name: 'title')
  final String title;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'related_id')
  final String? relatedId;

  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @JsonKey(name: 'is_read')
  final bool isRead;

  @JsonKey(name: 'created_at')
  final String createdAt;

  NotificationModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.message,
    required this.type,
    this.relatedId,
    this.imageUrl,
    required this.isRead,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);

  // Helper to get formatted time
  String get timeAgoText {
    try {
      final createdDate = DateTime.parse(createdAt);
      final now = DateTime.now();
      final difference = now.difference(createdDate);

      if (difference.inDays > 0) {
        return 'منذ ${difference.inDays} يوم';
      } else if (difference.inHours > 0) {
        return 'منذ ${difference.inHours} ساعة';
      } else if (difference.inMinutes > 0) {
        return 'منذ ${difference.inMinutes} دقيقة';
      } else {
        return 'الآن';
      }
    } catch (e) {
      return '';
    }
  }

  NotificationModel copyWith({
    String? id,
    String? userId,
    String? title,
    String? message,
    String? type,
    String? relatedId,
    String? imageUrl,
    bool? isRead,
    String? createdAt,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      message: message ?? this.message,
      type: type ?? this.type,
      relatedId: relatedId ?? this.relatedId,
      imageUrl: imageUrl ?? this.imageUrl,
      isRead: isRead ?? this.isRead,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

// ==================== Mark Notification as Read Response ====================
@JsonSerializable()
class MarkNotificationReadResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  @JsonKey(name: 'data')
  final NotificationModel? data;

  MarkNotificationReadResponseModel({
    required this.success,
    required this.message,
    this.data,
  });

  factory MarkNotificationReadResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MarkNotificationReadResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$MarkNotificationReadResponseModelToJson(this);
}

// ==================== Delete Notification Response ====================
@JsonSerializable()
class DeleteNotificationResponseModel {
  @JsonKey(name: 'success')
  final bool success;

  @JsonKey(name: 'message')
  final String message;

  DeleteNotificationResponseModel({
    required this.success,
    required this.message,
  });

  factory DeleteNotificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteNotificationResponseModelFromJson(json);

  Map<String, dynamic> toJson() =>
      _$DeleteNotificationResponseModelToJson(this);
}

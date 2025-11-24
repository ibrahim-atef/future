import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String courseId;
  final String userId;
  final String userName;
  final String message;
  final DateTime timestamp;
  final String? messageId; // Firestore document ID

  ChatMessage({
    required this.id,
    required this.courseId,
    required this.userId,
    required this.userName,
    required this.message,
    required this.timestamp,
    this.messageId,
  });

  // Convert to Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'courseId': courseId,
      'userId': userId,
      'userName': userName,
      'message': message,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }

  // Create from Firestore document
  factory ChatMessage.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatMessage(
      id: doc.id,
      courseId: data['courseId'] ?? '',
      userId: data['userId'] ?? '',
      userName: data['userName'] ?? '',
      message: data['message'] ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      messageId: doc.id,
    );
  }

  // Create from Map (for testing)
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'] ?? '',
      courseId: map['courseId'] ?? '',
      userId: map['userId'] ?? '',
      userName: map['userName'] ?? '',
      message: map['message'] ?? '',
      timestamp: map['timestamp'] is Timestamp
          ? (map['timestamp'] as Timestamp).toDate()
          : DateTime.parse(map['timestamp'] ?? DateTime.now().toIso8601String()),
      messageId: map['messageId'],
    );
  }
}



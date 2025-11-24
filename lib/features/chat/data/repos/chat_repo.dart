import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:future_app/features/chat/data/models/chat_model.dart';

class ChatRepo {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get chat collection reference for a course
  CollectionReference _getChatCollection(String courseId) {
    return _firestore.collection('courses').doc(courseId).collection('chat');
  }

  // Send a message
  Future<void> sendMessage({
    required String courseId,
    required String userId,
    required String userName,
    required String message,
  }) async {
    try {
      log('📤 ChatRepo: Attempting to send message');
      log('📤 ChatRepo: courseId=$courseId, userId=$userId, userName=$userName');
      log('📤 ChatRepo: message length=${message.length}');
      
      final chatMessage = ChatMessage(
        id: '', // Will be set by Firestore
        courseId: courseId,
        userId: userId,
        userName: userName,
        message: message,
        timestamp: DateTime.now(),
      );

      final messageData = chatMessage.toFirestore();
      log('📤 ChatRepo: Message data: $messageData');
      
      final collectionRef = _getChatCollection(courseId);
      log('📤 ChatRepo: Collection path: ${collectionRef.path}');
      
      final docRef = await collectionRef.add(messageData);
      log('✅ ChatRepo: Message sent successfully with ID: ${docRef.id}');
    } catch (e, stackTrace) {
      log('❌ ChatRepo: Error sending message: $e');
      log('❌ ChatRepo: Stack trace: $stackTrace');
      throw Exception('Failed to send message: $e');
    }
  }

  // Stream messages for a course (real-time updates)
  Stream<List<ChatMessage>> getMessagesStream(String courseId) {
    try {
      log('📥 ChatRepo: Setting up message stream for courseId: $courseId');
      final collectionRef = _getChatCollection(courseId);
      log('📥 ChatRepo: Collection path: ${collectionRef.path}');
      
      return collectionRef
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        log('📥 ChatRepo: Received ${snapshot.docs.length} messages');
        final messages = snapshot.docs
            .map((doc) {
              try {
                return ChatMessage.fromFirestore(doc);
              } catch (e) {
                log('❌ ChatRepo: Error parsing message ${doc.id}: $e');
                return null;
              }
            })
            .whereType<ChatMessage>()
            .toList();
        return messages;
      }).handleError((error) {
        log('❌ ChatRepo: Stream error: $error');
        throw error;
      });
    } catch (e, stackTrace) {
      log('❌ ChatRepo: Error setting up stream: $e');
      log('❌ ChatRepo: Stack trace: $stackTrace');
      rethrow;
    }
  }

  // Get messages once (non-streaming)
  Future<List<ChatMessage>> getMessages(String courseId) async {
    try {
      final snapshot = await _getChatCollection(courseId)
          .orderBy('timestamp', descending: false)
          .get();

      return snapshot.docs
          .map((doc) => ChatMessage.fromFirestore(doc))
          .toList();
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  // Delete a message (optional - for moderation)
  Future<void> deleteMessage(String courseId, String messageId) async {
    try {
      await _getChatCollection(courseId).doc(messageId).delete();
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }
}



import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:future_app/features/chat/data/models/chat_model.dart';
import 'package:future_app/features/chat/data/repos/chat_repo_base.dart';

class CommunityChatRepo implements ChatRepoBase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get chat collection reference for a grade (community)
  CollectionReference _getChatCollection(String gradeId) {
    return _firestore.collection('community').doc(gradeId).collection('chat');
  }

  // Send a message
  Future<void> sendMessage({
    required String courseId, // gradeId in this context
    required String userId,
    required String userName,
    required String message,
  }) async {
    try {
      log('📤 CommunityChatRepo: Attempting to send message');
      log('📤 CommunityChatRepo: gradeId=$courseId, userId=$userId, userName=$userName');
      log('📤 CommunityChatRepo: message length=${message.length}');
      
      final chatMessage = ChatMessage(
        id: '', // Will be set by Firestore
        courseId: courseId,
        userId: userId,
        userName: userName,
        message: message,
        timestamp: DateTime.now(),
      );

      final messageData = chatMessage.toFirestore();
      log('📤 CommunityChatRepo: Message data: $messageData');
      
      final collectionRef = _getChatCollection(courseId);
      log('📤 CommunityChatRepo: Collection path: ${collectionRef.path}');
      
      final docRef = await collectionRef.add(messageData);
      log('✅ CommunityChatRepo: Message sent successfully with ID: ${docRef.id}');
    } catch (e, stackTrace) {
      log('❌ CommunityChatRepo: Error sending message: $e');
      log('❌ CommunityChatRepo: Stack trace: $stackTrace');
      throw Exception('Failed to send message: $e');
    }
  }

  // Stream messages for a grade (real-time updates)
  Stream<List<ChatMessage>> getMessagesStream(String courseId) {
    try {
      log('📥 CommunityChatRepo: Setting up message stream for gradeId: $courseId');
      final collectionRef = _getChatCollection(courseId);
      log('📥 CommunityChatRepo: Collection path: ${collectionRef.path}');
      
      return collectionRef
          .orderBy('timestamp', descending: false)
          .snapshots()
          .map((snapshot) {
        log('📥 CommunityChatRepo: Received ${snapshot.docs.length} messages');
        final messages = snapshot.docs
            .map((doc) {
              try {
                return ChatMessage.fromFirestore(doc);
              } catch (e) {
                log('❌ CommunityChatRepo: Error parsing message ${doc.id}: $e');
                return null;
              }
            })
            .whereType<ChatMessage>()
            .toList();
        return messages;
      }).handleError((error) {
        log('❌ CommunityChatRepo: Stream error: $error');
        throw error;
      });
    } catch (e, stackTrace) {
      log('❌ CommunityChatRepo: Error setting up stream: $e');
      log('❌ CommunityChatRepo: Stack trace: $stackTrace');
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


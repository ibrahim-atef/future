import 'package:future_app/features/chat/data/models/chat_model.dart';

abstract class ChatRepoBase {
  Future<void> sendMessage({
    required String courseId,
    required String userId,
    required String userName,
    required String message,
  });

  Stream<List<ChatMessage>> getMessagesStream(String courseId);

  Future<List<ChatMessage>> getMessages(String courseId);

  Future<void> deleteMessage(String courseId, String messageId);
}


import 'dart:async';
import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/features/chat/data/models/chat_model.dart';
import 'package:future_app/features/chat/data/repos/chat_repo.dart';
import 'package:future_app/features/chat/logic/cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit(this._chatRepo) : super(const ChatState.initial());

  final ChatRepo _chatRepo;
  StreamSubscription<List<ChatMessage>>? _messagesSubscription;

  // Load messages for a course
  void loadMessages(String courseId) {
    log('🔄 ChatCubit: Loading messages for courseId: $courseId');
    emit(const ChatState.loading());
    
    // Cancel previous subscription
    _messagesSubscription?.cancel();
    
    // Listen to real-time updates
    _messagesSubscription = _chatRepo.getMessagesStream(courseId).listen(
      (messages) {
        log('✅ ChatCubit: Received ${messages.length} messages');
        emit(ChatState.loaded(messages));
      },
      onError: (error, stackTrace) {
        log('❌ ChatCubit: Error loading messages: $error');
        log('❌ ChatCubit: Stack trace: $stackTrace');
        emit(ChatState.error(error.toString()));
      },
    );
  }

  // Send a message
  Future<void> sendMessage({
    required String courseId,
    required String userId,
    required String userName,
    required String message,
  }) async {
    if (message.trim().isEmpty) {
      log('⚠️ ChatCubit: Attempted to send empty message');
      return;
    }

    log('📤 ChatCubit: Sending message');
    log('📤 ChatCubit: courseId=$courseId, userId=$userId, userName=$userName');
    log('📤 ChatCubit: message="${message.trim()}"');
    
    emit(const ChatState.sending());
    
    try {
      await _chatRepo.sendMessage(
        courseId: courseId,
        userId: userId,
        userName: userName,
        message: message.trim(),
      );
      log('✅ ChatCubit: Message sent successfully');
      emit(const ChatState.sent());
      // Reset to loaded state after a short delay
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!isClosed) {
          // State will be updated by stream listener
        }
      });
    } catch (e, stackTrace) {
      log('❌ ChatCubit: Error sending message: $e');
      log('❌ ChatCubit: Stack trace: $stackTrace');
      emit(ChatState.sendError(e.toString()));
    }
  }

  // Delete a message (optional)
  Future<void> deleteMessage(String courseId, String messageId) async {
    try {
      await _chatRepo.deleteMessage(courseId, messageId);
    } catch (e) {
      emit(ChatState.error('Failed to delete message: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}



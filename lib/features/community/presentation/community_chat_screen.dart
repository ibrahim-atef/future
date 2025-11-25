import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:future_app/core/helper/shared_pref_keys.dart';
import 'package:future_app/features/chat/data/models/chat_model.dart';
import 'package:future_app/features/chat/logic/cubit/chat_cubit.dart';
import 'package:future_app/features/chat/logic/cubit/chat_state.dart';
import 'package:future_app/features/community/data/repos/community_chat_repo.dart';

class CommunityChatScreen extends StatefulWidget {
  final String gradeId;
  final String gradeName;

  const CommunityChatScreen({
    super.key,
    required this.gradeId,
    required this.gradeName,
  });

  @override
  State<CommunityChatScreen> createState() => _CommunityChatScreenState();
}

class _CommunityChatScreenState extends State<CommunityChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String? _userId;
  String? _userName;
  late ChatCubit _chatCubit;
  List<ChatMessage> _lastMessages = []; // حفظ آخر قائمة رسائل

  @override
  void initState() {
    super.initState();
    // Create ChatCubit with CommunityChatRepo
    _chatCubit = ChatCubit(CommunityChatRepo());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  Future<void> _loadUserData() async {
    _userId = UserConstant.userId;
    _userName = UserConstant.userName ?? 'مستخدم';
    
    if (_userId == null || _userId!.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('يجب تسجيل الدخول للمشاركة في المحادثة'),
            backgroundColor: Colors.red,
          ),
        );
        Navigator.pop(context);
      }
      return;
    }

    if (mounted) {
      _chatCubit.loadMessages(widget.gradeId);
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يرجى إدخال رسالة'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }
    
    if (_userId == null || _userId!.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('يجب تسجيل الدخول لإرسال الرسائل'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    _chatCubit.sendMessage(
      courseId: widget.gradeId,
      userId: _userId!,
      userName: _userName ?? 'مستخدم',
      message: _messageController.text,
    );

    _messageController.clear();
    _scrollToBottom();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _chatCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _chatCubit,
      child: Scaffold(
        backgroundColor: const Color(0xFF1a1a1a),
        appBar: AppBar(
          backgroundColor: const Color(0xFF1a1a1a),
          elevation: 0,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'كميونيتي',
                style: TextStyle(
                  color: Color(0xFFd4af37),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              ),
              Text(
                widget.gradeName,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontFamily: 'Cairo',
                ),
              ),
            ],
          ),
          centerTitle: false,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFFd4af37)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocListener<ChatCubit, ChatState>(
          listener: (context, state) {
            state.whenOrNull(
              sendError: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('فشل إرسال الرسالة: $error'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
              sent: () {
                // Message sent successfully
              },
              error: (error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('خطأ: $error'),
                    backgroundColor: Colors.red,
                    duration: const Duration(seconds: 4),
                  ),
                );
              },
            );
          },
          child: Column(
            children: [
              // Messages List
              Expanded(
                child: BlocBuilder<ChatCubit, ChatState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFd4af37),
                        ),
                      ),
                      loading: () => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFd4af37),
                        ),
                      ),
                      loaded: (messages) {
                        _lastMessages = messages; // حفظ آخر قائمة رسائل
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          _scrollToBottom();
                        });

                        if (messages.isEmpty) {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat_bubble_outline,
                                  size: 64,
                                  color: Colors.white54,
                                ),
                                SizedBox(height: 16),
                                Text(
                                  'لا توجد رسائل بعد',
                                  style: TextStyle(
                                    color: Colors.white54,
                                    fontSize: 16,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                                SizedBox(height: 8),
                                Text(
                                  'كن أول من يشارك في المحادثة!',
                                  style: TextStyle(
                                    color: Colors.white38,
                                    fontSize: 14,
                                    fontFamily: 'Cairo',
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          padding: const EdgeInsets.all(16),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            final isCurrentUser = message.userId == _userId;
                            return _buildMessageBubble(message, isCurrentUser);
                          },
                        );
                      },
                      error: (error) => Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.error_outline,
                              size: 64,
                              color: Colors.red,
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'حدث خطأ في تحميل الرسائل',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'Cairo',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              error,
                              style: const TextStyle(
                                color: Colors.white54,
                                fontSize: 14,
                                fontFamily: 'Cairo',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton(
                              onPressed: () {
                                _chatCubit.loadMessages(widget.gradeId);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFd4af37),
                                foregroundColor: Colors.black,
                              ),
                              child: const Text(
                                'إعادة المحاولة',
                                style: TextStyle(fontFamily: 'Cairo'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      sending: () {
                        // عرض آخر قائمة رسائل أثناء الإرسال
                        if (_lastMessages.isNotEmpty) {
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: _lastMessages.length,
                            itemBuilder: (context, index) {
                              final message = _lastMessages[index];
                              final isCurrentUser = message.userId == _userId;
                              return _buildMessageBubble(message, isCurrentUser);
                            },
                          );
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Color(0xFFd4af37),
                          ),
                        );
                      },
                      sent: () {
                        // عرض آخر قائمة رسائل بعد الإرسال
                        if (_lastMessages.isNotEmpty) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            _scrollToBottom();
                          });
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: _lastMessages.length,
                            itemBuilder: (context, index) {
                              final message = _lastMessages[index];
                              final isCurrentUser = message.userId == _userId;
                              return _buildMessageBubble(message, isCurrentUser);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      sendError: (error) {
                        // عرض آخر قائمة رسائل حتى في حالة الخطأ
                        if (_lastMessages.isNotEmpty) {
                          return ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.all(16),
                            itemCount: _lastMessages.length,
                            itemBuilder: (context, index) {
                              final message = _lastMessages[index];
                              final isCurrentUser = message.userId == _userId;
                              return _buildMessageBubble(message, isCurrentUser);
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    );
                  },
                ),
              ),

              // Message Input
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF2a2a2a),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: SafeArea(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1a1a1a),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFFd4af37).withOpacity(0.3),
                              width: 1,
                            ),
                          ),
                          child: TextField(
                            controller: _messageController,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: 'Cairo',
                            ),
                            decoration: InputDecoration(
                              hintText: 'اكتب رسالتك...',
                              hintStyle: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 16,
                                fontFamily: 'Cairo',
                              ),
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                            ),
                            maxLines: null,
                            textInputAction: TextInputAction.send,
                            onSubmitted: (_) => _sendMessage(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color(0xFFd4af37),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Icons.send,
                            color: Colors.black,
                          ),
                          onPressed: _sendMessage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ChatMessage message, bool isCurrentUser) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isCurrentUser) ...[
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFFd4af37),
              child: Text(
                message.userName.isNotEmpty
                    ? message.userName[0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: isCurrentUser
                    ? const Color(0xFFd4af37)
                    : const Color(0xFF2a2a2a),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(16),
                  topRight: const Radius.circular(16),
                  bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                  bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isCurrentUser)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        message.userName,
                        style: TextStyle(
                          color: isCurrentUser
                              ? Colors.black87
                              : const Color(0xFFd4af37),
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                  Text(
                    message.message,
                    style: TextStyle(
                      color: isCurrentUser ? Colors.black : Colors.white,
                      fontSize: 15,
                      fontFamily: 'Cairo',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isCurrentUser
                          ? Colors.black54
                          : Colors.white54,
                      fontSize: 11,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFFd4af37),
              child: Text(
                _userName?.isNotEmpty == true
                    ? _userName![0].toUpperCase()
                    : 'U',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays} يوم';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} ساعة';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} دقيقة';
    } else {
      return 'الآن';
    }
  }
}


import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:future_app/features/chat/data/models/chat_model.dart';

part 'chat_state.freezed.dart';

@freezed
class ChatState with _$ChatState {
  const factory ChatState.initial() = _Initial;
  const factory ChatState.loading() = _Loading;
  const factory ChatState.loaded(List<ChatMessage> messages) = _Loaded;
  const factory ChatState.error(String message) = _Error;
  const factory ChatState.sending() = _Sending;
  const factory ChatState.sent() = _Sent;
  const factory ChatState.sendError(String message) = _SendError;
}



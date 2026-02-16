library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat_list_event.freezed.dart';

@freezed
class ChatListEvent with _$ChatListEvent {
  const factory ChatListEvent.loadRequested(String userId) =
      ChatListLoadRequested;
  const factory ChatListEvent.createConversationRequested(String userId) =
      ChatListCreateConversationRequested;
  const factory ChatListEvent.deleteConversationRequested(
    String userId,
    String conversationId,
  ) = ChatListDeleteConversationRequested;
}

library;

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class ChatLocalDataSource {
  Future<List<ConversationModel>> getCachedConversations(String userId);
  Future<void> cacheConversations(String userId, List<ConversationModel> list);
  /// Caches a single conversation (with messages), merging into the list.
  Future<void> cacheConversation(String userId, ConversationModel conversation);
  Future<void> cacheMessage(String userId, MessageModel message);
  Future<ConversationModel?> getCachedConversation(
    String userId,
    String conversationId,
  );

  /// Removes a conversation from cache (e.g. after delete).
  Future<void> removeConversation(String userId, String conversationId);

  /// Offline queue: add a message to be sent when back online.
  Future<void> addPendingMessage(String userId, MessageModel message);
  Future<List<MessageModel>> getPendingMessages(String userId);
  Future<void> removePendingMessage(String userId, String messageId);
}

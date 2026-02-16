library;

import '../entities/conversation.dart';
import '../entities/message.dart';
import '../../../../core/error/failures.dart';

abstract class ChatRepository {
  Future<({Failure? failure, List<Conversation>? data})>
  getCachedConversationsOnly(String userId);
  Future<({Failure? failure, List<Conversation>? data})> getConversations(
    String userId,
  );
  Future<({Failure? failure, Conversation? data})> createConversation(
    String userId,
  );

  Future<({Failure? failure, Conversation? data})> getCachedConversationOnly(
    String userId,
    String conversationId,
  );
  Future<({Failure? failure, Conversation? data})> getConversation(
    String userId,
    String conversationId,
  );
  Future<({Failure? failure, Message? data})> sendMessage(
    String userId,
    Message message,
  );
  Future<({Failure? failure, void data})> saveAssistantMessage(
    String userId,
    Message message,
  );
  Stream<({Failure? failure, String? data})> streamAIResponse({
    required String conversationId,
    required String message,
    required List<Message> history,
  });
  Future<({Failure? failure, void data})> deleteConversation(
    String userId,
    String conversationId,
  );

  /// Offline queue: add message to send when back online.
  Future<void> addPendingMessage(String userId, Message message);

  /// Sends all pending messages for [userId]. Call when connectivity is restored.
  Future<void> flushPendingMessages(String userId);
}

library;

import '../models/conversation_model.dart';
import '../models/message_model.dart';

abstract class ChatRemoteDataSource {
  Future<List<ConversationModel>> getConversations(String userId);
  Future<ConversationModel> createConversation(String userId);
  Future<ConversationModel?> getConversation(
    String userId,
    String conversationId,
  );
  Future<MessageModel> sendMessage(String userId, MessageModel message);
  Future<void> saveAssistantMessage(String userId, MessageModel message);
  Future<void> deleteConversation(String userId, String conversationId);
}

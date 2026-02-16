library;

import 'dart:convert';

import '../../../../config/constants/app_constants.dart';
import '../../../../core/constants/storage_keys.dart';
import '../../../../core/services/storage/storage_manager.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';
import 'chat_local_datasource.dart';

class ChatLocalDataSourceImpl implements ChatLocalDataSource {
  ChatLocalDataSourceImpl(this._storage);

  final StorageManager _storage;

  static List<ConversationModel> _trimConversations(
    List<ConversationModel> list,
  ) {
    if (list.length <= AppConstants.cacheMaxConversations) return list;
    return list.take(AppConstants.cacheMaxConversations).toList();
  }

  static List<MessageModel> _trimMessages(List<MessageModel> list) {
    if (list.length <= AppConstants.cacheMaxMessagesPerConversation) {
      return list;
    }
    return list.reversed
        .take(AppConstants.cacheMaxMessagesPerConversation)
        .toList()
        .reversed
        .toList();
  }

  @override
  Future<List<ConversationModel>> getCachedConversations(String userId) async {
    final key = '${StorageKeys.conversationsCache}_$userId';
    final json = await _storage.getPreference<String>(key);
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list
          .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> cacheConversations(
    String userId,
    List<ConversationModel> list,
  ) async {
    final trimmed = _trimConversations(list).toList();
    final key = '${StorageKeys.conversationsCache}_$userId';
    final encoded = jsonEncode(trimmed.map((c) => c.toJson()).toList());
    await _storage.savePreference(key, encoded);
  }

  @override
  Future<void> cacheConversation(
    String userId,
    ConversationModel conversation,
  ) async {
    final list = await getCachedConversations(userId);
    final trimmedMessages = _trimMessages(conversation.messages);
    final toCache = conversation.copyWith(messages: trimmedMessages);
    final index = list.indexWhere((c) => c.id == toCache.id);
    final updated = index >= 0
        ? [...list.take(index), toCache, ...list.skip(index + 1)]
        : [toCache, ...list];
    await cacheConversations(userId, updated);
  }

  @override
  Future<void> cacheMessage(String userId, MessageModel message) async {
    final list = await getCachedConversations(userId);
    final index = list.indexWhere((c) => c.id == message.conversationId);
    if (index < 0) return;
    final conv = list[index];
    final newMessages = _trimMessages([...conv.messages, message]);
    final updated = [
      ...list.take(index),
      conv.copyWith(messages: newMessages),
      ...list.skip(index + 1),
    ];
    final key = '${StorageKeys.conversationsCache}_$userId';
    await _storage.savePreference(
      key,
      jsonEncode(updated.map((c) => c.toJson()).toList()),
    );
  }

  @override
  Future<ConversationModel?> getCachedConversation(
    String userId,
    String conversationId,
  ) async {
    final list = await getCachedConversations(userId);
    try {
      return list.firstWhere((c) => c.id == conversationId);
    } catch (_) {
      return null;
    }
  }

  @override
  Future<void> removeConversation(String userId, String conversationId) async {
    final list = await getCachedConversations(userId);
    final updated = list.where((c) => c.id != conversationId).toList();
    if (updated.length == list.length) return;
    await cacheConversations(userId, updated);
  }

  @override
  Future<void> addPendingMessage(String userId, MessageModel message) async {
    final key = '${StorageKeys.pendingMessages}_$userId';
    final json = await _storage.getPreference<String>(key);
    final List<dynamic> list = json != null
        ? jsonDecode(json) as List<dynamic>
        : [];
    list.add(message.toJson());
    await _storage.savePreference(key, jsonEncode(list));
  }

  @override
  Future<List<MessageModel>> getPendingMessages(String userId) async {
    final key = '${StorageKeys.pendingMessages}_$userId';
    final json = await _storage.getPreference<String>(key);
    if (json == null) return [];
    try {
      final list = jsonDecode(json) as List<dynamic>;
      return list
          .map((e) => MessageModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  @override
  Future<void> removePendingMessage(String userId, String messageId) async {
    final key = '${StorageKeys.pendingMessages}_$userId';
    final json = await _storage.getPreference<String>(key);
    if (json == null) return;
    try {
      final list = jsonDecode(json) as List<dynamic>;
      final filtered = list
          .where((e) => (e as Map<String, dynamic>)['id'] != messageId)
          .toList();
      await _storage.savePreference(key, jsonEncode(filtered));
    } catch (_) {}
  }
}

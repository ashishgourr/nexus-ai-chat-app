library;

import 'dart:async';
import 'dart:io';

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../config/constants/api_constants.dart';
import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/conversation.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/chat_repository.dart';
import '../datasources/ai_datasource.dart';
import '../datasources/chat_local_datasource.dart';
import '../datasources/chat_remote_datasource.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';

const String _offlineMessage = AppStrings.offlineCheckConnection;

bool _isLikelyOffline(Object e) {
  if (e is SocketException ||
      e is TimeoutException ||
      e is HandshakeException) {
    return true;
  }
  final s = e.toString().toLowerCase();
  return s.contains('socket') ||
      s.contains('connection') ||
      s.contains('network') ||
      s.contains('timeout') ||
      s.contains('unreachable');
}

class ChatRepositoryImpl implements ChatRepository {
  ChatRepositoryImpl(this._remote, this._local, this._ai);

  final ChatRemoteDataSource _remote;
  final ChatLocalDataSource _local;
  final AIDatasource _ai;

  @override
  Future<({Failure? failure, List<Conversation>? data})>
  getCachedConversationsOnly(String userId) async {
    final cached = await _local.getCachedConversations(userId);
    return (failure: null, data: cached.map((m) => m.toEntity()).toList());
  }

  @override
  Future<({Failure? failure, List<Conversation>? data})> getConversations(
    String userId,
  ) async {
    try {
      final list = await _remote.getConversations(userId);
      await _local.cacheConversations(userId, list);
      return (failure: null, data: list.map((m) => m.toEntity()).toList());
    } on AppException catch (e) {
      final cached = await _local.getCachedConversations(userId);
      if (cached.isNotEmpty) {
        return (failure: null, data: cached.map((m) => m.toEntity()).toList());
      }
      return (failure: CacheFailure(e.message), data: null);
    } catch (e) {
      final cached = await _local.getCachedConversations(userId);
      if (cached.isNotEmpty) {
        return (failure: null, data: cached.map((m) => m.toEntity()).toList());
      }
      return (failure: CacheFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, Conversation? data})> createConversation(
    String userId,
  ) async {
    try {
      final model = await _remote.createConversation(userId);
      await _local.cacheConversation(userId, model);
      return (failure: null, data: model.toEntity());
    } on AppException catch (e) {
      return (failure: CacheFailure(e.message), data: null);
    } catch (e) {
      return (failure: CacheFailure(e.toString()), data: null);
    }
  }

  @override
  Future<({Failure? failure, Conversation? data})> getCachedConversationOnly(
    String userId,
    String conversationId,
  ) async {
    final cached = await _local.getCachedConversation(userId, conversationId);
    return (failure: null, data: cached?.toEntity());
  }

  @override
  Future<({Failure? failure, Conversation? data})> getConversation(
    String userId,
    String conversationId,
  ) async {
    try {
      final ConversationModel? model = await _remote.getConversation(
        userId,
        conversationId,
      );
      if (model != null) {
        await _local.cacheConversation(userId, model);
      }
      return (failure: null, data: model?.toEntity());
    } on AppException {
      final cached = await _local.getCachedConversation(userId, conversationId);
      return (failure: null, data: cached?.toEntity());
    } catch (e) {
      final cached = await _local.getCachedConversation(userId, conversationId);
      return (failure: null, data: cached?.toEntity());
    }
  }

  @override
  Future<({Failure? failure, Message? data})> sendMessage(
    String userId,
    Message message,
  ) async {
    try {
      final model = MessageModel.fromEntity(message);
      final MessageModel sent = await _remote.sendMessage(userId, model);
      await _local.cacheMessage(userId, sent);
      return (failure: null, data: sent.toEntity());
    } on AppException catch (e) {
      return (
        failure: _isLikelyOffline(e)
            ? const NetworkFailure(_offlineMessage)
            : CacheFailure(e.message),
        data: null,
      );
    } catch (e) {
      return (
        failure: _isLikelyOffline(e)
            ? const NetworkFailure(_offlineMessage)
            : CacheFailure(e.toString()),
        data: null,
      );
    }
  }

  @override
  Future<({Failure? failure, void data})> saveAssistantMessage(
    String userId,
    Message message,
  ) async {
    try {
      final model = MessageModel.fromEntity(message);
      await _remote.saveAssistantMessage(userId, model);
      await _local.cacheMessage(userId, model);
      return (failure: null, data: null);
    } on AppException catch (e) {
      return (failure: CacheFailure(e.message), data: null);
    } catch (e) {
      return (failure: CacheFailure(e.toString()), data: null);
    }
  }

  @override
  Stream<({Failure? failure, String? data})> streamAIResponse({
    required String conversationId,
    required String message,
    required List<Message> history,
  }) async* {
    final nonSystem = history
        .where((m) => m.role != MessageRole.system)
        .toList();
    final trimmed = nonSystem.length <= ApiConstants.geminiMaxHistoryMessages
        ? nonSystem
        : nonSystem.sublist(
            nonSystem.length - ApiConstants.geminiMaxHistoryMessages,
          );
    final contentHistory = trimmed.map((m) => Content.text(m.content)).toList();
    try {
      await for (final chunk in _ai.streamResponse(
        message: message,
        history: contentHistory,
      )) {
        yield (failure: null, data: chunk);
      }
    } on AppException catch (e) {
      yield (
        failure: _isLikelyOffline(e)
            ? const NetworkFailure(_offlineMessage)
            : ServerFailure(e.message),
        data: null,
      );
    } catch (e) {
      yield (
        failure: _isLikelyOffline(e)
            ? const NetworkFailure(_offlineMessage)
            : ServerFailure(e.toString()),
        data: null,
      );
    }
  }

  @override
  Future<({Failure? failure, void data})> deleteConversation(
    String userId,
    String conversationId,
  ) async {
    try {
      await _remote.deleteConversation(userId, conversationId);
      await _local.removeConversation(userId, conversationId);
      return (failure: null, data: null);
    } on AppException catch (e) {
      return (failure: CacheFailure(e.message), data: null);
    } catch (e) {
      return (failure: CacheFailure(e.toString()), data: null);
    }
  }

  @override
  Future<void> addPendingMessage(String userId, Message message) async {
    final model = MessageModel.fromEntity(message);
    await _local.addPendingMessage(userId, model);
  }

  @override
  Future<void> flushPendingMessages(String userId) async {
    final pending = await _local.getPendingMessages(userId);
    for (final model in pending) {
      try {
        await _remote.sendMessage(userId, model);
        await _local.removePendingMessage(userId, model.id);
        await _local.cacheMessage(userId, model);
      } catch (_) {
        break;
      }
    }
  }
}

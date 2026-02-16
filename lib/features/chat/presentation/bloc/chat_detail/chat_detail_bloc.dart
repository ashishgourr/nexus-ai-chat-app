library;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../../../core/constants/app_strings.dart';

import '../../../../../core/error/failures.dart';
import '../../../domain/entities/message.dart';
import '../../../domain/usecases/add_pending_message.dart';
import '../../../domain/usecases/get_cached_conversation_only.dart';
import '../../../domain/usecases/get_conversation.dart';
import '../../../domain/usecases/save_assistant_message.dart';
import '../../../domain/usecases/send_message.dart';
import '../../../domain/usecases/stream_ai_response.dart';
import 'chat_detail_event.dart';
import 'chat_detail_state.dart';

const Duration _minSendInterval = Duration(seconds: 2);

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  ChatDetailBloc({
    required GetCachedConversationOnly getCachedConversationOnly,
    required GetConversation getConversation,
    required SendMessage sendMessage,
    required AddPendingMessage addPendingMessage,
    required StreamAIResponse streamAIResponse,
    required SaveAssistantMessage saveAssistantMessage,
  }) : _getCachedConversationOnly = getCachedConversationOnly,
       _getConversation = getConversation,
       _sendMessage = sendMessage,
       _addPendingMessage = addPendingMessage,
       _streamAIResponse = streamAIResponse,
       _saveAssistantMessage = saveAssistantMessage,
       super(const ChatDetailState.initial()) {
    on<ChatDetailLoadRequested>(_onLoadRequested);
    on<ChatDetailSendMessage>(_onSendMessage);
  }

  final GetCachedConversationOnly _getCachedConversationOnly;
  final GetConversation _getConversation;
  final SendMessage _sendMessage;
  final AddPendingMessage _addPendingMessage;
  final StreamAIResponse _streamAIResponse;
  final SaveAssistantMessage _saveAssistantMessage;
  static const _uuid = Uuid();

  DateTime? _lastSendTime;

  Future<void> _onLoadRequested(
    ChatDetailLoadRequested event,
    Emitter<ChatDetailState> emit,
  ) async {
    final cached = await _getCachedConversationOnly((
      userId: event.userId,
      conversationId: event.conversationId,
    ));
    if (cached.data != null && cached.data!.messages.isNotEmpty) {
      emit(ChatDetailState.loaded(messages: cached.data!.messages));
    }
    emit(const ChatDetailState.loading());
    final result = await _getConversation((
      userId: event.userId,
      conversationId: event.conversationId,
    ));
    if (result.failure != null) {
      emit(ChatDetailState.error(result.failure!.message));
      return;
    }
    final conv = result.data;
    if (conv == null) {
      emit(const ChatDetailState.loaded(messages: []));
      return;
    }
    emit(ChatDetailState.loaded(messages: conv.messages));
  }

  Future<void> _onSendMessage(
    ChatDetailSendMessage event,
    Emitter<ChatDetailState> emit,
  ) async {
    // Simple client-side rate limiting: min interval between sends
    final now = DateTime.now();
    if (_lastSendTime != null &&
        now.difference(_lastSendTime!) < _minSendInterval) {
      final currentMessages = state is ChatDetailLoaded
          ? (state as ChatDetailLoaded).messages
          : <Message>[];
      emit(const ChatDetailState.error(AppStrings.rateLimitMessage));
      emit(
        ChatDetailState.loaded(messages: currentMessages, isStreaming: false),
      );
      return;
    }
    _lastSendTime = now;

    final currentMessages = state is ChatDetailLoaded
        ? (state as ChatDetailLoaded).messages
        : <Message>[];
    emit(
      ChatDetailState.loaded(
        messages: [...currentMessages, event.message],
        isStreaming: true,
      ),
    );

    final sendResult = await _sendMessage((
      userId: event.userId,
      message: event.message,
    ));
    if (sendResult.failure != null) {
      if (sendResult.failure is NetworkFailure) {
        await _addPendingMessage(event.userId, event.message);
        emit(const ChatDetailState.error(AppStrings.savedForWhenBackOnline));
        emit(
          ChatDetailState.loaded(
            messages: [...currentMessages, event.message],
            isStreaming: false,
          ),
        );
      } else {
        emit(ChatDetailState.error(sendResult.failure!.message));
      }
      return;
    }

    final assistantPlaceholder = Message(
      id: 'temp-${event.message.id}',
      conversationId: event.conversationId,
      role: MessageRole.assistant,
      content: '',
      createdAt: DateTime.now(),
      status: MessageStatus.streaming,
    );
    List<Message> messages = [
      ...currentMessages,
      event.message,
      assistantPlaceholder,
    ];
    emit(ChatDetailState.loaded(messages: messages, isStreaming: true));

    final history = [...currentMessages, event.message];
    await for (final chunk in _streamAIResponse((
      conversationId: event.conversationId,
      message: event.message.content,
      history: history,
    ))) {
      if (chunk.failure != null) {
        emit(
          ChatDetailState.loaded(
            messages: messages
                .map(
                  (m) => m.id == assistantPlaceholder.id
                      ? m.copyWith(
                          content: m.content,
                          status: MessageStatus.error,
                        )
                      : m,
                )
                .toList(),
            isStreaming: false,
          ),
        );
        emit(ChatDetailState.error(chunk.failure!.message));
        return;
      }
      final content = chunk.data ?? '';
      messages = messages
          .map(
            (m) => m.id == assistantPlaceholder.id
                ? m.copyWith(content: content, status: MessageStatus.streaming)
                : m,
          )
          .toList();
      emit(
        ChatDetailState.loaded(
          messages: messages,
          isStreaming: content.isEmpty,
        ),
      );
    }

    final finalMessages = messages
        .map(
          (m) => m.id == assistantPlaceholder.id
              ? m.copyWith(status: MessageStatus.done)
              : m,
        )
        .toList();
    emit(ChatDetailState.loaded(messages: finalMessages, isStreaming: false));

    // Save the message we just streamed (identified by placeholder id), not the first assistant in the list
    Message? assistantMessage;
    for (final m in finalMessages) {
      if (m.id == assistantPlaceholder.id) {
        assistantMessage = m;
        break;
      }
    }
    if (assistantMessage != null && assistantMessage.content.isNotEmpty) {
      final toSave = Message(
        id: _uuid.v4(),
        conversationId: event.conversationId,
        role: MessageRole.assistant,
        content: assistantMessage.content,
        createdAt: assistantMessage.createdAt,
        status: MessageStatus.done,
      );
      await _saveAssistantMessage((userId: event.userId, message: toSave));
    }
  }
}

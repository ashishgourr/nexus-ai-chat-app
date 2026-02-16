library;

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/usecases/create_conversation.dart';
import '../../../domain/usecases/delete_conversation.dart';
import '../../../domain/usecases/get_cached_conversations_only.dart';
import '../../../domain/usecases/get_conversations.dart';
import 'chat_list_event.dart';
import 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  ChatListBloc({
    required GetCachedConversationsOnly getCachedConversationsOnly,
    required GetConversations getConversations,
    required CreateConversation createConversation,
    required DeleteConversation deleteConversation,
  }) : _getCachedConversationsOnly = getCachedConversationsOnly,
       _getConversations = getConversations,
       _createConversation = createConversation,
       _deleteConversation = deleteConversation,
       super(const ChatListState.initial()) {
    on<ChatListLoadRequested>(_onLoadRequested);
    on<ChatListCreateConversationRequested>(_onCreateRequested);
    on<ChatListDeleteConversationRequested>(_onDeleteRequested);
  }

  final GetCachedConversationsOnly _getCachedConversationsOnly;
  final GetConversations _getConversations;
  final CreateConversation _createConversation;
  final DeleteConversation _deleteConversation;

  Future<void> _onLoadRequested(
    ChatListLoadRequested event,
    Emitter<ChatListState> emit,
  ) async {
    final cached = await _getCachedConversationsOnly(event.userId);
    if (cached.data != null && cached.data!.isNotEmpty) {
      emit(ChatListState.loaded(cached.data!));
    }
    emit(const ChatListState.loading());
    final result = await _getConversations(event.userId);
    if (result.failure != null) {
      emit(ChatListState.error(result.failure!.message));
      return;
    }
    emit(ChatListState.loaded(result.data ?? []));
  }

  Future<void> _onCreateRequested(
    ChatListCreateConversationRequested event,
    Emitter<ChatListState> emit,
  ) async {
    final result = await _createConversation(event.userId);
    if (result.failure != null) {
      emit(ChatListState.error(result.failure!.message));
      return;
    }
    if (result.data != null && state is ChatListLoaded) {
      final current = (state as ChatListLoaded).conversations;
      emit(
        ChatListState.loaded([
          result.data!,
          ...current,
        ], createdId: result.data!.id),
      );
    } else if (result.data != null) {
      emit(ChatListState.loaded([result.data!], createdId: result.data!.id));
    }
  }

  Future<void> _onDeleteRequested(
    ChatListDeleteConversationRequested event,
    Emitter<ChatListState> emit,
  ) async {
    final result = await _deleteConversation((
      userId: event.userId,
      conversationId: event.conversationId,
    ));
    if (result.failure != null) {
      if (state is ChatListLoaded) {
        emit(ChatListState.error(result.failure!.message));
        emit(state);
      } else {
        emit(ChatListState.error(result.failure!.message));
      }
      return;
    }
    if (state is ChatListLoaded) {
      final current = (state as ChatListLoaded).conversations;
      final updated = current
          .where((c) => c.id != event.conversationId)
          .toList();
      emit(ChatListState.loaded(updated));
    }
  }
}

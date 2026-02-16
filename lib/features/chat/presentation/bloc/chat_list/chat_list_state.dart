library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/conversation.dart';

part 'chat_list_state.freezed.dart';

@freezed
class ChatListState with _$ChatListState {
  const factory ChatListState.initial() = ChatListInitial;
  const factory ChatListState.loading() = ChatListLoading;
  const factory ChatListState.loaded(
    List<Conversation> conversations, {
    String? createdId,
  }) = ChatListLoaded;
  const factory ChatListState.error(String message) = ChatListError;
}

library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message.dart';

part 'chat_detail_state.freezed.dart';

@freezed
class ChatDetailState with _$ChatDetailState {
  const factory ChatDetailState.initial() = ChatDetailInitial;
  const factory ChatDetailState.loading() = ChatDetailLoading;
  const factory ChatDetailState.loaded({
    required List<Message> messages,
    @Default(false) bool isStreaming,
  }) = ChatDetailLoaded;
  const factory ChatDetailState.error(String message) = ChatDetailError;
}

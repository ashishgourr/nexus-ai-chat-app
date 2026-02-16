library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/message.dart';

part 'chat_detail_event.freezed.dart';

@freezed
class ChatDetailEvent with _$ChatDetailEvent {
  const factory ChatDetailEvent.loadRequested({
    required String userId,
    required String conversationId,
  }) = ChatDetailLoadRequested;
  const factory ChatDetailEvent.sendMessage({
    required String userId,
    required String conversationId,
    required Message message,
  }) = ChatDetailSendMessage;
}

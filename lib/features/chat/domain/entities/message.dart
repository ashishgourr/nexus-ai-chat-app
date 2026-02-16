library;

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message.freezed.dart';

enum MessageRole { user, assistant, system }

enum MessageStatus { sending, sent, streaming, done, error }

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String conversationId,
    required MessageRole role,
    required String content,
    required DateTime createdAt,
    @Default(MessageStatus.sent) MessageStatus status,
  }) = _Message;
}

library;

import 'package:freezed_annotation/freezed_annotation.dart';

import 'message.dart';

part 'conversation.freezed.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required String ownerUid,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<Message> messages,
  }) = _Conversation;
}

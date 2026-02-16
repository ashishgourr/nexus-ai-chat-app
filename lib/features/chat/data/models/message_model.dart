library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/message.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
class MessageModel with _$MessageModel {
  const MessageModel._();

  const factory MessageModel({
    required String id,
    required String conversationId,
    required String role,
    required String content,
    required DateTime createdAt,
    @Default('sent') String status,
  }) = _MessageModel;

  factory MessageModel.fromJson(Map<String, dynamic> json) =>
      _$MessageModelFromJson(json);

  Message toEntity() {
    return Message(
      id: id,
      conversationId: conversationId,
      role: _roleFromString(role),
      content: content,
      createdAt: createdAt,
      status: _statusFromString(status),
    );
  }

  static MessageModel fromEntity(Message message) {
    return MessageModel(
      id: message.id,
      conversationId: message.conversationId,
      role: message.role.name,
      content: message.content,
      createdAt: message.createdAt,
      status: message.status.name,
    );
  }

  static MessageRole _roleFromString(String role) {
    return MessageRole.values.firstWhere(
      (e) => e.name == role,
      orElse: () => MessageRole.user,
    );
  }

  static MessageStatus _statusFromString(String status) {
    return MessageStatus.values.firstWhere(
      (e) => e.name == status,
      orElse: () => MessageStatus.sent,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'role': role,
      'content': content,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'status': status,
    };
  }

  static MessageModel fromFirestore(
    String id,
    String conversationId,
    Map<String, dynamic> map,
  ) {
    return MessageModel(
      id: id,
      conversationId: conversationId,
      role: map['role'] as String? ?? 'user',
      content: map['content'] as String? ?? '',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.now(),
      status: map['status'] as String? ?? 'sent',
    );
  }
}

library;

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/conversation.dart';
import 'message_model.dart';

part 'conversation_model.freezed.dart';
part 'conversation_model.g.dart';

@freezed
class ConversationModel with _$ConversationModel {
  const ConversationModel._();

  const factory ConversationModel({
    required String id,
    required String ownerUid,
    required String title,
    required DateTime createdAt,
    required DateTime updatedAt,
    @Default([]) List<MessageModel> messages,
  }) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
      _$ConversationModelFromJson(json);

  Conversation toEntity() {
    return Conversation(
      id: id,
      ownerUid: ownerUid,
      title: title,
      createdAt: createdAt,
      updatedAt: updatedAt,
      messages: messages.map((m) => m.toEntity()).toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'ownerUid': ownerUid,
      'title': title,
      'createdAt': createdAt.millisecondsSinceEpoch,
      'updatedAt': updatedAt.millisecondsSinceEpoch,
    };
  }

  static ConversationModel fromFirestore(
    String id,
    Map<String, dynamic> map,
    List<MessageModel> messageModels,
  ) {
    return ConversationModel(
      id: id,
      ownerUid: map['ownerUid'] as String? ?? '',
      title: map['title'] as String? ?? 'Chat',
      createdAt: map['createdAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['createdAt'] as int)
          : DateTime.now(),
      updatedAt: map['updatedAt'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['updatedAt'] as int)
          : DateTime.now(),
      messages: messageModels,
    );
  }
}

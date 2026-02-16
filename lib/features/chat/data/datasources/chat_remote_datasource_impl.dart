library;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/error/exceptions.dart';
import '../models/conversation_model.dart';
import '../models/message_model.dart';
import 'chat_remote_datasource.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  ChatRemoteDataSourceImpl(this._firestore);

  final FirebaseFirestore _firestore;
  final _uuid = const Uuid();

  CollectionReference<Map<String, dynamic>> _usersRef(String uid) =>
      _firestore.collection('users').doc(uid).collection('conversations');

  @override
  Future<List<ConversationModel>> getConversations(String userId) async {
    try {
      final snapshot = await _usersRef(
        userId,
      ).orderBy('updatedAt', descending: true).get();
      final list = <ConversationModel>[];
      for (final doc in snapshot.docs) {
        final messages = await _getMessages(userId, doc.id);
        list.add(ConversationModel.fromFirestore(doc.id, doc.data(), messages));
      }
      return list;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  Future<List<MessageModel>> _getMessages(
    String userId,
    String conversationId,
  ) async {
    final snapshot = await _usersRef(
      userId,
    ).doc(conversationId).collection('messages').orderBy('createdAt').get();
    return snapshot.docs
        .map((d) => MessageModel.fromFirestore(d.id, conversationId, d.data()))
        .toList();
  }

  @override
  Future<ConversationModel> createConversation(String userId) async {
    try {
      final id = _uuid.v4();
      final now = DateTime.now();
      final data = {
        'ownerUid': userId,
        'title': AppStrings.newChat,
        'createdAt': now.millisecondsSinceEpoch,
        'updatedAt': now.millisecondsSinceEpoch,
      };
      await _usersRef(userId).doc(id).set(data);
      return ConversationModel(
        id: id,
        ownerUid: userId,
        title: AppStrings.newChat,
        createdAt: now,
        updatedAt: now,
        messages: [],
      );
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<ConversationModel?> getConversation(
    String userId,
    String conversationId,
  ) async {
    try {
      final doc = await _usersRef(userId).doc(conversationId).get();
      if (!doc.exists || doc.data() == null) return null;
      final messages = await _getMessages(userId, conversationId);
      return ConversationModel.fromFirestore(doc.id, doc.data()!, messages);
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<MessageModel> sendMessage(String userId, MessageModel message) async {
    try {
      final ref = _usersRef(
        userId,
      ).doc(message.conversationId).collection('messages').doc(message.id);
      await ref.set(message.toFirestore());
      await _usersRef(userId).doc(message.conversationId).update({
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
        if (message.role == 'user')
          'title': message.content.length > 50
              ? '${message.content.substring(0, 50)}...'
              : message.content,
      });
      return message;
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> saveAssistantMessage(String userId, MessageModel message) async {
    try {
      final ref = _usersRef(
        userId,
      ).doc(message.conversationId).collection('messages').doc(message.id);
      await ref.set(message.toFirestore());
      await _usersRef(userId).doc(message.conversationId).update({
        'updatedAt': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      throw CacheException(e.toString());
    }
  }

  @override
  Future<void> deleteConversation(String userId, String conversationId) async {
    try {
      await _usersRef(userId).doc(conversationId).delete();
    } catch (e) {
      throw CacheException(e.toString());
    }
  }
}

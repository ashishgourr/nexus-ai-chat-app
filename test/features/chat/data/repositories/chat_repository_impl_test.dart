/// Unit tests for [ChatRepositoryImpl] cache-first and cache-on-success behavior.
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_ai_chat_app/features/chat/data/datasources/ai_datasource.dart';
import 'package:mini_ai_chat_app/features/chat/data/datasources/chat_local_datasource.dart';
import 'package:mini_ai_chat_app/features/chat/data/datasources/chat_remote_datasource.dart';
import 'package:mini_ai_chat_app/features/chat/data/models/conversation_model.dart';
import 'package:mini_ai_chat_app/features/chat/data/models/message_model.dart';
import 'package:mini_ai_chat_app/features/chat/data/repositories/chat_repository_impl.dart';

class MockChatRemoteDataSource extends Mock implements ChatRemoteDataSource {}

class MockChatLocalDataSource extends Mock implements ChatLocalDataSource {}

class MockAIDatasource extends Mock implements AIDatasource {}

void main() {
  group('ChatRepositoryImpl', () {
    late ChatRepositoryImpl repository;
    late MockChatRemoteDataSource remote;
    late MockChatLocalDataSource local;
    late MockAIDatasource ai;

    setUpAll(() {
      registerFallbackValue(
        ConversationModel(
          id: '',
          ownerUid: '',
          title: '',
          createdAt: DateTime(0),
          updatedAt: DateTime(0),
          messages: [],
        ),
      );
    });

    setUp(() {
      remote = MockChatRemoteDataSource();
      local = MockChatLocalDataSource();
      ai = MockAIDatasource();
      repository = ChatRepositoryImpl(remote, local, ai);
      when(() => local.getCachedConversation(any(), any()))
          .thenAnswer((_) async => null);
      when(() => local.cacheConversation(any(), any())).thenAnswer((_) async {});
    });

    group('getCachedConversationsOnly', () {
      test('returns cached list from local without calling remote', () async {
        final now = DateTime.now();
        final cached = [
          ConversationModel(
            id: 'c1',
            ownerUid: 'u1',
            title: 'Chat 1',
            createdAt: now,
            updatedAt: now,
            messages: [],
          ),
        ];
        when(() => local.getCachedConversations('u1'))
            .thenAnswer((_) async => cached);

        final result = await repository.getCachedConversationsOnly('u1');

        expect(result.failure, isNull);
        expect(result.data, isNotNull);
        expect(result.data!.length, 1);
        expect(result.data!.first.id, 'c1');
        verify(() => local.getCachedConversations('u1')).called(1);
        verifyNever(() => remote.getConversations(any()));
      });
    });

    group('getConversation', () {
      test('caches conversation when remote returns success', () async {
        final now = DateTime.now();
        final model = ConversationModel(
          id: 'conv1',
          ownerUid: 'u1',
          title: 'Chat',
          createdAt: now,
          updatedAt: now,
          messages: [
            MessageModel(
              id: 'm1',
              conversationId: 'conv1',
              role: 'user',
              content: 'Hi',
              createdAt: now,
            ),
          ],
        );
        when(() => remote.getConversation('u1', 'conv1'))
            .thenAnswer((_) async => model);

        final result = await repository.getConversation('u1', 'conv1');

        expect(result.failure, isNull);
        expect(result.data, isNotNull);
        expect(result.data!.messages.length, 1);
        verify(() => local.cacheConversation('u1', model)).called(1);
      });
    });
  });
}

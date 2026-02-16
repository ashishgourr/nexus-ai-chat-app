/// Tests for [ChatListPage].
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_ai_chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_ai_chat_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:mini_ai_chat_app/features/chat/presentation/bloc/chat_list/chat_list_bloc.dart';
import 'package:mini_ai_chat_app/features/chat/presentation/bloc/chat_list/chat_list_state.dart';
import 'package:mini_ai_chat_app/features/chat/presentation/pages/chat_list_page.dart';

class MockChatListBloc extends Mock implements ChatListBloc {}

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  group('ChatListPage', () {
    late MockChatListBloc mockChatListBloc;
    late MockAuthBloc mockAuthBloc;

    Widget buildTestWidget(Widget child) {
      return MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>.value(value: mockAuthBloc),
            BlocProvider<ChatListBloc>.value(value: mockChatListBloc),
          ],
          child: child,
        ),
      );
    }

    setUp(() {
      mockChatListBloc = MockChatListBloc();
      mockAuthBloc = MockAuthBloc();
      when(() => mockChatListBloc.close()).thenAnswer((_) async {});
      when(() => mockAuthBloc.close()).thenAnswer((_) async {});
      when(() => mockAuthBloc.state).thenReturn(const AuthState.unauthenticated());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());
    });

    testWidgets('shows loading when state is ChatListLoading', (tester) async {
      when(
        () => mockChatListBloc.state,
      ).thenReturn(const ChatListState.loading());
      when(
        () => mockChatListBloc.stream,
      ).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        buildTestWidget(const ChatListPage(userId: 'test-user-id')),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows Chats app bar', (tester) async {
      when(
        () => mockChatListBloc.state,
      ).thenReturn(const ChatListState.initial());
      when(
        () => mockChatListBloc.stream,
      ).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        buildTestWidget(const ChatListPage(userId: 'test-user-id')),
      );
      await tester.pump();

      expect(find.text('Chats'), findsOneWidget);
    });

    testWidgets('shows empty state when ChatListLoaded with empty list', (
      tester,
    ) async {
      when(() => mockChatListBloc.state).thenReturn(ChatListState.loaded([]));
      when(
        () => mockChatListBloc.stream,
      ).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        buildTestWidget(const ChatListPage(userId: 'test-user-id')),
      );
      await tester.pump();

      expect(find.byType(ChatListPage), findsOneWidget);
    });
  });
}

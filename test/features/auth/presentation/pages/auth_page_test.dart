/// Tests for [AuthPage].
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:mini_ai_chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mini_ai_chat_app/features/auth/presentation/bloc/auth_state.dart';
import 'package:mini_ai_chat_app/features/auth/presentation/pages/auth_page.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  group('AuthPage', () {
    late MockAuthBloc mockAuthBloc;

    setUp(() {
      mockAuthBloc = MockAuthBloc();
      when(() => mockAuthBloc.close()).thenAnswer((_) async {});
    });

    testWidgets('shows sign in options when unauthenticated', (tester) async {
      when(
        () => mockAuthBloc.state,
      ).thenReturn(const AuthState.unauthenticated());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const AuthPage(),
          ),
        ),
      );
      await tester.pump();

      expect(find.text('Welcome to\nNexus AI'), findsOneWidget);
      expect(find.text('Continue as Guest'), findsOneWidget);
    });

    testWidgets('shows loading when state is AuthLoading', (tester) async {
      when(() => mockAuthBloc.state).thenReturn(const AuthState.loading());
      when(() => mockAuthBloc.stream).thenAnswer((_) => const Stream.empty());

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<AuthBloc>.value(
            value: mockAuthBloc,
            child: const AuthPage(),
          ),
        ),
      );
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}

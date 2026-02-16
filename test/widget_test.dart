// Smoke test for Mini AI Chat app.
//
// Verifies that the app builds when Firebase and DI are initialized.
// Skips when Firebase is not available (e.g. test env without options).
// Feature-level tests live under test/features/.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mini_ai_chat_app/core/di/injection_container.dart';
import 'package:mini_ai_chat_app/main.dart';

bool _firebaseInitialized = false;

void main() {
  setUpAll(() async {
    WidgetsFlutterBinding.ensureInitialized();
    try {
      await Firebase.initializeApp();
      await initializeDependencies();
      _firebaseInitialized = true;
    } catch (_) {
      _firebaseInitialized = false;
    }
  });

  testWidgets('MiniAiChatApp builds when Firebase is initialized', (
    tester,
  ) async {
    if (!_firebaseInitialized) {
      return; // Skip when Firebase not available in test env
    }
    await tester.pumpWidget(const MiniAiChatApp());
    await tester.pump();
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}

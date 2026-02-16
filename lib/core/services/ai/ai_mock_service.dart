library;

import 'package:google_generative_ai/google_generative_ai.dart';

abstract class AIMockServiceInterface {
  Stream<String> generateResponse({
    required String message,
    required List<Content> history,
  });
}

class AIMockService implements AIMockServiceInterface {
  @override
  Stream<String> generateResponse({
    required String message,
    required List<Content> history,
  }) async* {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    final response = _generateContextualResponse(message, history);
    for (int i = 0; i < response.length; i++) {
      yield response.substring(0, i + 1);
      await Future<void>.delayed(const Duration(milliseconds: 20));
    }
  }

  String _generateContextualResponse(String message, List<Content> history) {
    final lower = message.toLowerCase();
    if (lower.contains('hello') || lower.contains('hi')) {
      return history.isEmpty
          ? "Hello! I'm your AI assistant. How can I help you today?"
          : "Hello again! What else can I help you with?";
    }
    if (lower.contains('?')) {
      return "That's an interesting question! Based on general knowledge, there are several factors to consider here. Let me share some thoughts that might help.";
    }
    return "I appreciate you sharing that. Here's my perspective on this topic based on the information provided.";
  }
}

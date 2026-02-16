library;

import 'package:google_generative_ai/google_generative_ai.dart';

import '../../../../core/services/ai/ai_mock_service.dart';
import '../../../../core/services/ai/gemini_service.dart';

class AIDatasource {
  AIDatasource(this._gemini, this._mock);

  final GeminiService _gemini;
  final AIMockService _mock;

  Stream<String> streamResponse({
    required String message,
    required List<Content> history,
  }) async* {
    try {
      yield* _gemini.generateStreamedResponse(
        message: message,
        conversationHistory: history,
      );
    } catch (_) {
      yield* _mock.generateResponse(message: message, history: history);
    }
  }
}

library;

class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://generativelanguage.googleapis.com';
  /// v1beta paths per Gemini API quickstart (gemini-3-flash-preview).
  /// See: https://ai.google.dev/gemini-api/docs/quickstart
  static const String geminiGenerateContentPath =
      '/v1beta/models/gemini-3-flash-preview:generateContent';
  static const String geminiStreamContentPath =
      '/v1beta/models/gemini-3-flash-preview:streamGenerateContent';

  static const Duration connectTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);
  static const Duration sendTimeout = Duration(seconds: 30);

  /// Shorter connect for Gemini so we fail fast; long receive for streaming.
  static const Duration geminiConnectTimeout = Duration(seconds: 15);
  static const Duration geminiReceiveTimeout = Duration(seconds: 120);
  static const Duration geminiSendTimeout = Duration(seconds: 30);

  /// Max conversation turns sent to Gemini (reduces payload and speeds first token).
  static const int geminiMaxHistoryMessages = 20;

  static const int maxRetries = 3;
  static const Duration retryDelay = Duration(seconds: 2);

  static const String contentTypeJson = 'application/json';
  static const String headerAuthorization = 'Authorization';
  static const String headerContentType = 'Content-Type';
}

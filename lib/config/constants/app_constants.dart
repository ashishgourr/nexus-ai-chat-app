library;

class AppConstants {
  AppConstants._();

  static const String appName = 'Mini AI Chat';
  static const int maxMessageLength = 4000;
  static const int maxConversationTitleLength = 100;
  static const int cacheMaxAgeMinutes = 60;
  static const int splashDelaySeconds = 2;

  /// Max number of conversations to keep in cache per user.
  static const int cacheMaxConversations = 50;
  /// Max messages per conversation in cache.
  static const int cacheMaxMessagesPerConversation = 500;
}

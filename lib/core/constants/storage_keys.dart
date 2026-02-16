library;

class StorageKeys {
  StorageKeys._();

  // ----- Auth (Secure Storage) -----
  static const String accessToken = 'access_token';
  static const String refreshToken = 'refresh_token';
  static const String anonymousUid = 'anonymous_uid';
  static const String userId = 'user_id';
  static const String userEmail = 'user_email';
  static const String authProvider = 'auth_provider';
  static const String lastSignInTime = 'last_sign_in_time';
  static const String sessionExpiry = 'session_expiry';

  // ----- Preferences (Local Storage) -----
  static const String theme = 'theme_mode';
  static const String language = 'language';
  static const String onboardingCompleted = 'onboarding_completed';
  static const String hasSeenWelcome = 'has_seen_welcome';
  static const String fontSize = 'font_size';
  static const String reduceMotion = 'reduce_motion';
  static const String notificationsEnabled = 'notifications_enabled';
  static const String soundEnabled = 'sound_enabled';
  static const String hapticEnabled = 'haptic_enabled';
  static const String defaultModel = 'default_model';
  static const String lastSelectedConversation = 'last_selected_conversation';
  static const String sortOrder = 'sort_order';
  static const String showTimestamps = 'show_timestamps';
  static const String compactMode = 'compact_mode';

  // ----- Encrypted (Encrypted Storage) -----
  static const String userCredentials = 'user_credentials';
  static const String sensitiveUserData = 'sensitive_user_data';
  static const String apiKeysEncrypted = 'api_keys_encrypted';
  static const String backupEncryptionKey = 'backup_encryption_key';

  // ----- Cache (Local Storage) -----
  static const String conversationsCache = 'conversations_cache';
  static const String messagesCachePrefix = 'messages_cache_';
  static const String userProfileCache = 'user_profile_cache';
  static const String cacheVersion = 'cache_version';
  static const String lastSyncTime = 'last_sync_time';
  static const String pendingMessages = 'pending_messages';
  static const String offlineQueue = 'offline_queue';

  // ----- Feature flags / settings -----
  static const String featureGeminiEnabled = 'feature_gemini_enabled';
  static const String featureStreamingEnabled = 'feature_streaming_enabled';
  static const String debugLogsEnabled = 'debug_logs_enabled';
  static const String crashReportingEnabled = 'crash_reporting_enabled';
  static const String analyticsEnabled = 'analytics_enabled';

  // ----- UI state -----
  static const String sidebarCollapsed = 'sidebar_collapsed';
  static const String chatListScrollPosition = 'chat_list_scroll_position';
  static const String inputDraftPrefix = 'input_draft_';
  static const String selectedFilters = 'selected_filters';
  static const String searchHistory = 'search_history';
  static const String recentSearches = 'recent_searches';

  // ----- Sync / backup -----
  static const String lastBackupTime = 'last_backup_time';
  static const String syncToken = 'sync_token';
  static const String migrationVersion = 'migration_version';
  static const String dataExportRequested = 'data_export_requested';

  // ----- Session -----
  static const String sessionId = 'session_id';
  static const String deviceId = 'device_id';
  static const String appInstallId = 'app_install_id';
  static const String firstLaunchTime = 'first_launch_time';
  static const String launchCount = 'launch_count';
}

library;

class AppConfig {
  AppConfig._();

  static const String environment = String.fromEnvironment(
    'ENVIRONMENT',
    defaultValue: 'dev',
  );

  static bool get isProd => environment == 'prod';
  static bool get isStaging => environment == 'staging';
  static bool get isDev => !isProd && !isStaging;

  /// Disable verbose logging in production.
  static bool get enableLogging => !isProd;
}

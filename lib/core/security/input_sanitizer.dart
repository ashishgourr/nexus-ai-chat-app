library;

import '../error/exceptions.dart';

class InputSanitizer {
  InputSanitizer._();

  /// Removes script tags, javascript: URIs, and event handlers.
  static String sanitizeString(String input) {
    if (input.isEmpty) return input;
    return input
        .replaceAll(
          RegExp(
            r'<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>',
            caseSensitive: false,
          ),
          '',
        )
        .replaceAll(RegExp(r'javascript:', caseSensitive: false), '')
        .replaceAll(RegExp(r'on\w+\s*=', caseSensitive: false), '')
        .trim();
  }

  /// Validates and sanitizes email; throws [InvalidInputException] if invalid.
  static String sanitizeEmail(String email) {
    final sanitized = email.toLowerCase().trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(sanitized)) {
      throw const InvalidInputException('Invalid email format');
    }
    return sanitized;
  }
}

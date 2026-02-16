library;

import 'package:intl/intl.dart';

class AppDateFormatter {
  AppDateFormatter._();

  static String time(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String shortDate(DateTime dateTime) {
    return DateFormat.MMMd().format(dateTime);
  }

  static String listRelative(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final dt = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (dt == today) {
      return 'Today ${time(dateTime)}';
    }
    if (dt == yesterday) {
      return 'Yesterday ${time(dateTime)}';
    }
    return '${shortDate(dateTime)}, ${time(dateTime)}';
  }
}

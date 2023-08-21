import 'dart:math';

import 'package:intl/intl.dart';

/// date format,difference, remaining days,  today-yesterday-this-week-days ago-years-ago etc...
class MyDateUtils {
  /// Find time Difference in between [Today and the given date-time] in format of today, yesterday otherwise dd/MM/yyyy
  static String formatDateTime(DateTime dateTime, [String? format]) {
    final now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      // If the date matches today, return the time in "jm" format
      return formatDate(dateTime, "jm");
    } else if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day - 1) {
      // If the date matches yesterday, return "Yesterday"
      return "Yesterday";
    } else {
      // For other dates, return the date in "dd/MM/yyyy" format
      return formatDate(dateTime, format ?? "dd/MM/yyyy");
    }
  }

  /// Find [Time Difference] in between today and the given date-time
  static String getTimeDifference(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = difference.inDays ~/ 365;
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 30) {
      final months = difference.inDays ~/ 30;
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays >= 7) {
      final weeks = difference.inDays ~/ 7;
      return '$weeks week${weeks > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 1) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return 'Yesterday';
    } else {
      return 'Today';
    }
  }

  /// format a date with format of you choice
  static String formatDate(DateTime dateTime, [String? format]) {
    final formatter = DateFormat(format ?? 'dd MMM yyyy');
    return formatter.format(dateTime);
  }

  static DateTime randomDate([int days=365]) {
    final random = Random();
    final currentDate = DateTime.now();
    final daysToSubtract = random.nextInt(days); // Maximum of 365 days
    final newDate = currentDate.subtract(Duration(days: daysToSubtract));
    return newDate;
  }
}

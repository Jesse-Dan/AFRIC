import "package:flutter/material.dart";
import "package:wallet/src/reusables/extensions/int.dart";

extension DateTimeExtension on DateTime {
  String get timeAgo {
    final now = DateTime.now();
    final diff = now.difference(this);

    if (diff.inSeconds < 60) {
      return "Just now";
    } else if (diff.inMinutes < 60) {
      return "${diff.inMinutes} min${diff.inMinutes > 1 ? "s" : ""} ago";
    } else if (diff.inHours < 24) {
      return "${diff.inHours} hour${diff.inHours > 1 ? "s" : ""} ago";
    } else if (diff.inDays < 7) {
      return "${diff.inDays} day${diff.inDays > 1 ? "s" : ""} ago";
    } else if (diff.inDays < 30) {
      final weeks = (diff.inDays / 7).floor();
      return "$weeks week${weeks > 1 ? "s" : ""} ago";
    } else if (diff.inDays < 365) {
      final months = (diff.inDays / 30).floor();
      return "$months month${months > 1 ? "s" : ""} ago";
    } else {
      final years = (diff.inDays / 365).floor();
      return "$years year${years > 1 ? "s" : ""} ago";
    }
  }

  String get formatDateForUser {
    var month = this.month;
    var day = this.day;
    var year = this.year;

    return "${month.nameOfMonth} $day, $year";
  }

  /// Returns a user-friendly string for chat message timestamps.
  /// - Today: "HH:mm AM/PM"
  /// - Yesterday: "Yesterday"
  /// - This year: "MMM d"
  /// - Previous years: "MMM d, yyyy"
  String get formatForChat {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final date = DateTime(year, month, day);

    if (date == today) {
      return formatTime12h;
    } else if (date == today.subtract(const Duration(days: 1))) {
      return "Yesterday";
    } else if (year == now.year) {
      return "${month.nameOfMonth.substring(0, 3)} $day";
    } else {
      return "${month.nameOfMonth.substring(0, 3)} $day, $year";
    }
  }

  String get formatDateForServer {
    var month = "${this.month}".padLeft(2, "0");
    var day = "${this.day}".padLeft(2, "0");
    var year = this.year;

    return "$year-$month-$day";
  }

  String get formatTime12h {
    final hour = this.hour % 12 == 0 ? 12 : this.hour % 12;
    final minute = this.minute.toString().padLeft(2, '0');
    final period = this.hour >= 12 ? "PM" : "AM";
    return "$hour:$minute $period";
  }
}

DateTime? parseMonthDayYear(String input) {
  try {
    return DateTime.parse(
      DateTime.parse(
        DateTime.tryParse(input) != null
            ? input
            : DateTime.parse(_normalizeDateString(input)).toIso8601String(),
      ).toString(),
    );
  } catch (_) {
    try {
      // Try using built-in date formatter
      final parts = input.trim().replaceAll(",", "").split(" ");
      if (parts.length != 3) return null;

      final month = _monthNameToNumber(parts[0]);
      final day = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      if (month == null) return null;

      return DateTime(year, month, day);
    } catch (_) {
      return null;
    }
  }
}

int? _monthNameToNumber(String month) {
  const months = {
    "january": 1,
    "february": 2,
    "march": 3,
    "april": 4,
    "may": 5,
    "june": 6,
    "july": 7,
    "august": 8,
    "september": 9,
    "october": 10,
    "november": 11,
    "december": 12,
  };

  return months[month.toLowerCase()];
}

String _normalizeDateString(String input) {
  try {
    final parts = input.trim().replaceAll(",", "").split(" ");
    if (parts.length != 3) {
      throw FormatException("Invalid date format");
    }

    final month = _monthNameToNumber(parts[0]);
    final day = parts[1].padLeft(2, '0');
    final year = parts[2];

    if (month == null) {
      throw FormatException("Invalid month name");
    }

    final monthStr = month.toString().padLeft(2, '0');
    return "$year-$monthStr-$day"; // e.g. 2025-06-20
  } catch (e) {
    throw FormatException("Unable to normalize date: $e");
  }
}

TimeOfDay stringToTimeOfDay(String timeString) {
  try {
    final parts = timeString.trim().split(RegExp(r'[:\s]'));

    if (parts.length != 3) {
      throw FormatException("Invalid time format: $timeString");
    }

    int hour = int.parse(parts[0]);
    int minute = int.parse(parts[1]);
    String period = parts[2].toUpperCase();

    if (period != 'AM' && period != 'PM') {
      throw FormatException("Invalid period (AM/PM): $timeString");
    }

    if (period == 'PM' && hour != 12) {
      hour += 12;
    } else if (period == 'AM' && hour == 12) {
      hour = 0;
    }

    return TimeOfDay(hour: hour, minute: minute);
  } catch (e) {
    throw FormatException("Invalid time format: $timeString");
  }
}

import 'package:intl/intl.dart';

final supaDateFormat = DateFormat('yyyy-MM-dd');

extension DateTimeExt on DateTime {
  /// Returns the date with seconds set to 0
  DateTime toMinute() {
    return DateTime(year, month, day, hour, minute, 0);
  }

  /// Returns the date with minutes and seconds set to 0
  DateTime toHour() {
    return DateTime(year, month, day, hour, 0, 0);
  }

  /// Returns the date with hour, minutes and seconds set to 0
  DateTime toDate() {
    return DateTime(year, month, day, 0, 0, 0);
  }

  // Returns todays date at a specific hour
  DateTime atHour(int hour) {
    return toDate().add(Duration(hours: hour));
  }

  // Returns true if this date is the same as todays date
  bool isToday() => toDate() == DateTime.now().toDate();

  // Returns true if this date is the same as todays date
  bool isTodayOrAfter() {
    final today = DateTime.now().toDate();
    return toDate() == today || toDate().isAfter(today);
  }

  /// Returns the date with hour, minutes and seconds set to 0
  String toSupaDate() {
    return supaDateFormat.format(DateTime(year, month, day, 0, 0, 0));
  }
}

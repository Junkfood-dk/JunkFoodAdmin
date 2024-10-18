// Milliseconds
const Duration _duration300ms = Duration(milliseconds: 300);
const Duration _duration500ms = Duration(milliseconds: 500);

// Seconds
const Duration _duration1s = Duration(seconds: 1);
const Duration _duration2s = Duration(seconds: 2);

// Minutes
const Duration _duration1min = Duration(minutes: 1);
const Duration _duration60min = Duration(minutes: 60);

// Days
const Duration _duration1day = Duration(days: 1);
const Duration _duration2days = Duration(days: 2);
const Duration _duration1week = Duration(days: 7);

// Years
const Duration _duration1year = Duration(days: 365);

abstract class DurationExt {
  /// Returns a duration of 300 milliseconds
  static const duration300ms = _duration300ms;

  /// Returns a duration of 500 milliseconds
  static const duration500ms = _duration500ms;

  /// Returns a duration of 1 second
  static const duration1s = _duration1s;

  /// Returns a duration of 2 seconds
  static const duration2s = _duration2s;

  /// Returns a duration of 1 minute
  static const duration1min = _duration1min;

  /// Returns a duration of 60 minutes
  static const duration60min = _duration60min;

  /// Returns a duration of 1 day
  static const duration1day = _duration1day;

  /// Returns a duration of 2 days
  static const duration2days = _duration2days;

  /// Returns a duration of 1 week
  static const duration1week = _duration1week;

  /// Returns a duration of 1 year
  static const duration1year = _duration1year;
}

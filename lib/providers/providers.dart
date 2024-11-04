import 'package:chefapp/extensions/duration_ext.dart';
import 'package:chefapp/providers/app_date_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
DateFormat dateFormatterNotifier(DateFormatterNotifierRef ref) {
  // TODO: Make sure to set this according to the user's preferences...
  return DateFormat('dd-MM-y');
}

abstract class Providers {
  /// Returns the date currently selected by the user
  static AutoDisposeNotifierProvider<AppDateNotifier, DateTime> get appDate =>
      appDateNotifierProvider;

  /// Returns the date formatter for the currently selected language
  static AutoDisposeProvider<DateFormat> get dateFormatter =>
      dateFormatterNotifierProvider;

  /// Returns the first date of the app
  static DateTime get firstAppDate =>
      DateTime.now().subtract(DurationExt.duration1year);

  /// Returns the last date of the app which is always tomorrow
  static DateTime get lastAppDate =>
      DateTime.now().add(DurationExt.duration1week);
}

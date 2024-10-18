import 'package:chefapp/extensions/date_time_ext.dart';
import 'package:chefapp/extensions/duration_ext.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_date_notifier.g.dart';

@riverpod
class AppDateNotifier extends _$AppDateNotifier {
  @override
  DateTime build() => DateTime.now();

  // Expose state here in order to be able to access it without going through
  // Riverpod read/watch

  // ignore: avoid_public_notifier_properties
  DateTime get appDate => state;

  /// Returns true if [date] is within a week from todays date
  bool isNextDateAllowed() {
    final nextDate = DateTime.now().add(DurationExt.duration1week).toDate();
    return state.isBefore(nextDate);
  }

  /// Returns true if [date] is on or within a week from now. We don't allow setting
  /// the date further into the future as dishes are not planned that far ahead.
  bool isDateAllowed(DateTime date) {
    final dayNextWeek = DateTime.now().add(DurationExt.duration1week).toDate();
    return date.isBefore(dayNextWeek);
  }

  // Returns true if [date] is within a week from todays date
  bool canAddDish(DateTime date) {
    final dayNextWeek = DateTime.now().add(DurationExt.duration1week).toDate();
    return dayNextWeek.difference(date).inDays <= 8;
  }

  /// Sets the date to the day after the current date
  void setNextDate() {
    DateTime nextDate = state.add(DurationExt.duration1day).toDate();
    if (isDateAllowed(nextDate)) {
      state = nextDate;
    }
  }

  /// Sets the date to the day before current date
  void setPreviousDate() {
    DateTime previousDate = state.subtract(DurationExt.duration1day).toDate();
    state = previousDate;
  }

  /// Sets the date to a specific [date]
  void setDate(DateTime date) {
    if (isDateAllowed(date)) {
      state = date;
    }
  }
}

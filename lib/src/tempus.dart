import 'package:intl/intl.dart';
import 'package:tempus/src/locale/locales.dart';
import 'package:tempus/src/format/formats.dart';

enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

class Tempus {
  DateTime _date;
  ILocale _locale;
  IFormat _format;
  static ILocale _globalLocale = LocaleEN();
  static IFormat _globalFormat = FormatEN();

  static String _hourFormat = 'HH:mm';
  static String _dayFormat = 'dd';
  static String _weekDayFormat = 'EEE MMM dd';
  static String _dayOfWeekFormat = 'EEE';
  static String _apiDayFormat = 'yyyy-MM-dd';
  static String _monthFormat = 'MMMM yyyy';
  static String _dayOfMonthFormat = 'MMM dd';

  /// Returns the global [_hourFormat]
  static String get hourFormat => _hourFormat;

  /// Sets the global [_hourFormat]
  static void setHourFormat(String format) => _hourFormat = format;

  /// Returns the global [_dayFormat]
  static String get dayFormat => _dayFormat;

  /// Sets the global [_dayFormat]
  static void setDayFormat(String format) => _dayFormat = format;

  /// Returns the global [_dayOfWeekFormat]
  static String get dayOfWeekFormat => _dayOfWeekFormat;

  /// Sets the global [_dayOfWeekFormat]
  static void setDayOfWeekFormat(String format) => _dayOfWeekFormat = format;

  /// Returns the global [_weekDayFormat]
  static String get weekDayFormat => _weekDayFormat;

  /// Sets the global [_weekDayFormat]
  static void setWeekDayFormat(String format) => _weekDayFormat = format;

  /// Returns the global [_apiDayFormat]
  static String get apiDayFormat => _apiDayFormat;

  /// Sets the global [_apiDayFormat]
  static void setApiDayFormat(String format) => _apiDayFormat = format;

  /// Returns the global [_monthFormat]
  static String get monthFormat => _monthFormat;

  /// Sets the global [_monthFormat]
  static void setMonthFormat(String format) => _monthFormat = format;

  /// Returns the global [_dayOfMonthFormat]
  static String get dayOfMonthFormat => _dayOfMonthFormat;

  /// Sets the global [_dayOfMonthFormat]
  static void setDayOfMonthFormat(String format) => _dayOfMonthFormat = format;

  /// Returns a formatted string in the [Tempus.dayFormat] format
  static String formatDay(DateTime d) => DateFormat(_dayFormat).format(d);

  /// Returns a formatted string in the [Tempus.weekDayFormat] format
  static String formatWeekDay(DateTime d) =>
      DateFormat(_weekDayFormat).format(d);

  /// Returns a formatted string in the [Tempus.dayOfWeekFormat] format
  static String formatDayOfWeek(DateTime d) =>
      DateFormat(_dayOfWeekFormat).format(d);

  /// Returns a formatted string in the [Tempus.apiDayFormat] format
  static String formatApiDay(DateTime d) => DateFormat(_apiDayFormat).format(d);

  /// Returns a formatted string in the [Tempus.monthFormat] format
  static String formatMonth(DateTime d) => DateFormat(_monthFormat).format(d);

  /// Returns a formatted string in the [Tempus.dayOfMonthFormat] format
  static String formatDayOfMonth(DateTime d) =>
      DateFormat(_dayOfMonthFormat).format(d);

  static DateTime normalizeDate(DateTime value) {
    return DateTime.utc(value.year, value.month, value.day, 12);
  }

  /// Default Tempus constructor. Creates a new Tempus instance based on current time in the local
  /// time zone.
  Tempus() {
    _date = _now();
  }

  /// Creates a new Tempus with the specified date.
  ///
  /// Throws a [FormatException] if the argument is null or of an invalid type.
  Tempus.fromDate(DateTime date) {
    if (date != null && date is DateTime) {
      _date = date;
    } else {
      throw FormatException('Date is null or of an invalid type.', date);
    }
  }

  /// Constructs a new Tempus instance based on formatted date strings.
  ///
  /// Throws a [FormatException] if the input cannot be parsed.
  /// The function parses a subset of ISO 8601 which includes the subset accepted by RFC 3339.
  static Tempus parse(String date) {
    return Tempus.fromDate(DateTime.parse(date));
  }

  /// Simultaneous getter and setter for the global locale.
  ///
  /// If no argument is specified, returns the current global locale. If a valid locale is
  /// specified, sets the global locale and then returns the new value.
  static ILocale globalLocale([ILocale locale]) {
    if (locale != null) _globalLocale = locale;
    return _globalLocale;
  }

  /// Simultaneous getter and setter for this instance's locale.
  ///
  /// If no argument is specified, returns the current locale. If a valid locale is specified, sets
  /// the instance's locale and then returns the new value.
  ILocale locale([ILocale locale]) {
    if (locale != null && locale is ILocale) _locale = locale;
    return _getLocale();
  }

  /// Simultaneous getter and setter for the global format.
  ///
  /// If no argument is specified, returns the current global format. If a valid format is
  /// specified, sets the global format and then returns the new value.
  static IFormat globalFormat([IFormat format]) {
    if (format != null) _globalFormat = format;
    return _globalFormat;
  }

  /// Simultaneous getter and setter for this instance's format.
  ///
  /// If no argument is specified, returns the current format. If a valid format is specified, sets
  /// the instance's format and then returns the new value.
  IFormat format([IFormat format]) {
    if (format != null && format is IFormat) _format = format;
    return _getFormat();
  }

  /// Returns a grid-like list of [DateTime]s in a given month, with 35 items.
  ///
  /// [startOnMonday] will start the grid on Monday instead of Sunday.
  static List<DateTime> datesInMonthGrid(
    DateTime month, {
    bool startOnMonday = false,
  }) {
    int _getWeekdayNumber(DayOfWeek weekday) {
      return DayOfWeek.values.indexOf(weekday) + 1;
    }

    int _getDaysBefore(DateTime firstDay, DayOfWeek startingWeekDay) {
      return (firstDay.weekday + 7 - _getWeekdayNumber(startingWeekDay)) % 7;
    }

    int _getDaysAfter(DateTime lastDay, DayOfWeek startingWeekDay) {
      final invertedStartingWeekday = 8 - _getWeekdayNumber(startingWeekDay);

      var daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7) + 1;
      if (daysAfter == 8) {
        daysAfter = 1;
      }

      return daysAfter;
    }

    final first = firstDayOfMonth(month);
    final daysBefore = _getDaysBefore(
        first, startOnMonday ? DayOfWeek.monday : DayOfWeek.sunday);
    final firstToDisplay = first.subtract(Duration(days: daysBefore));

    final last = lastDayOfMonth(month);
    final daysAfter = _getDaysAfter(
        last, startOnMonday ? DayOfWeek.monday : DayOfWeek.sunday);

    final lastToDisplay = last.add(Duration(days: daysAfter));
    return daysInRange(firstToDisplay, lastToDisplay).toList();
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] is inclusive and [end] is exclusive
  static Iterable<DateTime> daysInRange(DateTime start, DateTime end) sync* {
    var temp = start;

    while (temp.isBefore(end)) {
      yield normalizeDate(temp);
      temp = temp.add(const Duration(days: 1));
    }
  }

  /// Returns a new [DateTime] on Monday of the current week.
  static DateTime firstDayOfWeek(DateTime day, [bool startOnMonday = false]) {
    // Handle Daylight Savings by setting hour to 12:00 Noon
    // rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    // Weekday is on a 1-7 scale Monday - Sunday,
    // This Calendar works from Sunday - Monday
    final sub = startOnMonday ? (day.weekday % 7) - 1 : day.weekday % 7;
    return day.subtract(Duration(days: sub));
  }

  /// Returns a new [DateTime] on Saturday of the current week.
  static DateTime lastDayOfWeek(DateTime day, [bool endOnSunday = false]) {
    // Handle Daylight Savings by setting hour to 12:00 Noon
    // rather than the default of Midnight
    day = DateTime.utc(day.year, day.month, day.day, 12);

    // Weekday is on a 1-7 scale Monday - Sunday,
    // This Calendar's Week starts on Sunday
    final sub = endOnSunday ? 6 - (day.weekday % 7) : 7 - (day.weekday % 7);
    return day.add(Duration(days: sub));
  }

  /// Returns a new [DateTime] in the 1st day of the given month
  static DateTime firstDayOfMonth(DateTime month) {
    return DateTime.utc(month.year, month.month, 1, 12);
  }

  /// Returns a new [DateTime] in the last day of the given month
  static DateTime lastDayOfMonth(DateTime month) {
    final date = month.month < 12
        ? DateTime.utc(month.year, month.month + 1, 1, 12)
        : DateTime.utc(month.year + 1, 1, 1, 12);
    return date.subtract(const Duration(days: 1));
  }

  /// Returns a new [DateTime] in the previous calendar month.
  ///
  /// If the month is January (01), the returned [DateTime] is in the previous year
  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return DateTime(year, month);
  }

  /// Returns a new [DateTime] in the next calendar month.
  ///
  /// If the month is December (12), the returned [DateTime] is in the next year
  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return DateTime(year, month);
  }

  /// Returns a new [DateTime] 7 days before the given date
  static DateTime previousWeek(DateTime w) {
    return w.subtract(Duration(days: 7));
  }

  /// Returns a new [DateTime] 7 days after the given date
  static DateTime nextWeek(DateTime w) {
    return w.add(Duration(days: 7));
  }

  /// Whether or not two dates are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Whether or not two dates are in the same week
  static bool isSameWeek(DateTime a, DateTime b) {
    // Handle Daylight Savings by setting hour to 12:00 Noon rather than the default of Midnight
    a = DateTime.utc(a.year, a.month, a.day, 12);
    b = DateTime.utc(b.year, b.month, b.day, 12);

    var diff = a.difference(b).inDays;
    if (diff.abs() >= 7) {
      return false;
    }

    var min = a.isBefore(b) ? a : b;
    var max = a.isBefore(b) ? b : a;

    return max.weekday % 7 - min.weekday % 7 >= 0;
  }

  /// Whether or not the given date is the first day of a month
  static bool isFirstDayOfMonth(DateTime day) =>
      isSameDay(firstDayOfMonth(day), day);

  /// Whether or not the given date is the last day of a month
  static bool isLastDayOfMonth(DateTime day) =>
      isSameDay(lastDayOfMonth(day), day);

  /// Returns a [String] with the different between [this] and [Tempus()]. Takes an optional
  /// [bool] argument to decide whether to use an identifier. [withoutPrefixOrSuffix] defaults
  /// to `false`.
  ///
  /// ```
  /// var berlinWallFell = Tempus.parse('19891109');
  /// // Assuming Tempus() is in 2018
  /// String difference = berlinWallFell.fromNow();
  /// assert(difference == 'in 29 years');
  ///
  /// var berlinWallFell = Tempus.parse('19891109');
  /// // Assuming Tempus() is in 2018
  /// String difference = berlinWallFell.fromNow(true);
  /// assert(difference == '29 years');
  /// ```
  String fromNow([bool withoutPrefixOrSuffix = false]) {
    return Tempus().from(this, withoutPrefixOrSuffix);
  }

  /// Returns a [String] with the different between [this] and [other]. Takes an optional [bool]
  /// argument to decide whether to use an identifier. [withoutPrefixOrSuffix] defaults to `false`.
  ///
  /// ```
  /// var berlinWallFell = Tempus.parse('19891109');
  /// var dDay = Tempus.parse('19440606');
  /// String difference = berlinWallFell.from(dDay);
  /// assert(difference == '46 years ago');
  ///
  /// var berlinWallFell = Tempus.parse('19891109');
  /// var dDay = Tempus.parse('19440606');
  /// String difference = berlinWallFell.from(dDay, false);
  /// assert(difference == '46 years');
  /// ```
  String from(Tempus other, [bool withoutPrefixOrSuffix = false]) {
    final diff = _date.difference(other._date);

    var timeString = '';

    var locale = _getLocale();

    if (diff.inSeconds.abs() < 45) {
      timeString = locale.seconds.replaceFirst('%i', '${diff.inSeconds.abs()}');
    } else if (diff.inMinutes.abs() < 2) {
      timeString = locale.aMinute.replaceFirst('%i', '${diff.inMinutes.abs()}');
    } else if (diff.inMinutes.abs() < 45) {
      timeString = locale.minutes.replaceFirst('%i', '${diff.inMinutes.abs()}');
    } else if (diff.inHours.abs() < 2) {
      timeString = locale.anHour.replaceFirst('%i', '${diff.inHours.abs()}');
    } else if (diff.inHours.abs() < 22) {
      timeString = locale.hours.replaceFirst('%i', '${diff.inHours.abs()}');
    } else if (diff.inDays.abs() < 2) {
      timeString = locale.aDay.replaceFirst('%i', '${diff.inDays.abs()}');
    } else if (diff.inDays.abs() < 26) {
      timeString = locale.days.replaceFirst('%i', '${diff.inDays.abs()}');
    } else if (diff.inDays.abs() < 60) {
      timeString =
          locale.aMonth.replaceFirst('%i', '${diff.inDays.abs() ~/ 30}');
    } else if (diff.inDays.abs() < 320) {
      timeString =
          locale.months.replaceFirst('%i', '${diff.inDays.abs() ~/ 30}');
    } else if (diff.inDays.abs() < 547) {
      timeString =
          locale.aYear.replaceFirst('%i', '${diff.inDays.abs() ~/ 356}');
    } else {
      timeString =
          locale.years.replaceFirst('%i', '${diff.inDays.abs() ~/ 356}');
    }

    if (!withoutPrefixOrSuffix) {
      if (diff.isNegative) {
        timeString = _addIdentifier(
            timeString, locale.futurePosition, locale.futureIdentifier);
      } else {
        timeString = _addIdentifier(
            timeString, locale.pastPosition, locale.pastIdentifier);
      }
    }

    return timeString;
  }

  void normalize() {
    _date = DateTime.utc(_date.year, _date.month, _date.day, 12);
  }

  /// Returns the inner [DateTime].
  DateTime get date => _date;

  /// Returns a human-readable [String] for this instance.
  ///
  /// The resulting string can be parsed back using [parse].
  @override
  String toString() {
    return _date.toString();
  }

  String _addIdentifier(
      String timeString, IdentifierPosition position, String identifier) {
    switch (position) {
      case IdentifierPosition.prepend:
        return '${identifier} ${timeString}';
      case IdentifierPosition.append:
        return '${timeString} ${identifier}';

      case IdentifierPosition.dontDisplay:
      default:
        return timeString;
    }
  }

  DateTime _now() => DateTime.now();

  ILocale _getLocale() => _locale ?? _globalLocale;

  IFormat _getFormat() => _format ?? _globalFormat;
}

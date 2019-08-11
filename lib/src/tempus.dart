import 'package:intl/intl.dart';
import 'package:tempus/src/locale/locales.dart';
import 'package:tempus/src/format/formats.dart';

class Tempus {
  DateTime _date;
  ILocale _locale;
  IFormat _format;
  static ILocale _globalLocale = new LocaleEN();
  static IFormat _globalFormat = new FormatEN();

  static String _dayFormat = "dd";
  static String _weekDayFormat = "EEE MMM dd";
  static String _apiDayFormat = "yyyy-MM-dd";
  static String _monthFormat = "MMMM yyyy";
  static String _dayOfMonthFormat = "MMM dd";

  /// Returns the global [_dayFormat]
  static String get dayFormat => _dayFormat;

  /// Sets the global [_dayFormat]
  static void setDayFormat(String format) => _dayFormat = format;

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
  static String formatDay(DateTime d) => new DateFormat(_dayFormat).format(d);

  /// Returns a formatted string in the [Tempus.weekDayFormat] format
  static String formatWeekDay(DateTime d) =>
      new DateFormat(_weekDayFormat).format(d);

  /// Returns a formatted string in the [Tempus.apiDayFormat] format
  static String formatApiDay(DateTime d) =>
      new DateFormat(_apiDayFormat).format(d);

  /// Returns a formatted string in the [Tempus.monthFormat] format
  static String formatMonth(DateTime d) =>
      new DateFormat(_monthFormat).format(d);

  /// Returns a formatted string in the [Tempus.dayOfMonthFormat] format
  static String formatDayOfMonth(DateTime d) =>
      new DateFormat(_dayOfMonthFormat).format(d);

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
      throw new FormatException('Date is null or of an invalid type.', date);
    }
  }

  /// Constructs a new Tempus instance based on [formattedString].
  ///
  /// Throws a [FormatException] if the input cannot be parsed.
  /// The function parses a subset of ISO 8601 which includes the subset accepted by RFC 3339.
  static Tempus parse(String date) {
    return new Tempus.fromDate(DateTime.parse(date));
  }

  /// Simultaneous getter and setter for the global locale.
  ///
  /// If no argument is specified, returns the current global locale. If a valid locale is
  /// specified, sets the global locale and then returns the new value.
  static ILocale globalLocale([ILocale locale = null]) {
    if (locale != null) _globalLocale = locale;
    return _globalLocale;
  }

  /// Simultaneous getter and setter for this instance's locale.
  ///
  /// If no argument is specified, returns the current locale. If a valid locale is specified, sets
  /// the instance's locale and then returns the new value.
  ILocale locale([ILocale locale = null]) {
    if (locale != null && locale is ILocale) _locale = locale;
    return _getLocale();
  }

  /// Simultaneous getter and setter for the global format.
  ///
  /// If no argument is specified, returns the current global format. If a valid format is
  /// specified, sets the global format and then returns the new value.
  static IFormat globalFormat([IFormat format = null]) {
    if (format != null) _globalFormat = format;
    return _globalFormat;
  }

  /// Simultaneous getter and setter for this instance's format.
  ///
  /// If no argument is specified, returns the current format. If a valid format is specified, sets
  /// the instance's format and then returns the new value.
  IFormat format([IFormat format = null]) {
    if (format != null && format is IFormat) _format = format;
    return _getFormat();
  }

  /// Returns a grid-like list of [DateTimes] in a given month, with either 35 or 42 items.
  ///
  /// [sixBySeven] will add 7 days of padding in case the list only has 35 items. That is,
  /// a "grid" of 6 rows by 7 columns.
  ///
  /// [startOnMonday] will start the grid on Monday instead of Sunday.
  static List<DateTime> datesInMonthGrid(DateTime month,
      [bool sixBySeven = false, bool startOnMonday = false]) {
    DateTime first = firstDayOfMonth(month);
    int daysBefore = startOnMonday ? first.weekday - 1 : first.weekday;
    DateTime firstToDisplay = first.subtract(new Duration(days: daysBefore));
    DateTime last = lastDayOfMonth(month);

    int daysAfter = startOnMonday ? 8 - last.weekday : 7 - last.weekday;

    // If the last day is sunday (7) the entire week must be rendered
    // Otherwise, if we're ending on Sunday leave it as zero
    if (daysAfter == 0 && !startOnMonday) daysAfter = 7;

    DateTime lastToDisplay = last.add(new Duration(days: daysAfter));

    List<DateTime> grid = datesInRange(firstToDisplay, lastToDisplay).toList();

    if (sixBySeven && grid.length < 42 && grid.length >= 35) {
      lastToDisplay = lastToDisplay.add(new Duration(days: 42 - grid.length));
      grid = datesInRange(firstToDisplay, lastToDisplay).toList();
    }

    return grid;
  }

  /// Returns a [DateTime] for each day the given range.
  ///
  /// [start] is inclusive and [end] is exclusive
  static Iterable<DateTime> datesInRange(DateTime start, DateTime end) sync* {
    var i = start;
    var offset = start.timeZoneOffset;
    while (i.isBefore(end)) {
      yield i;
      i = i.add(new Duration(days: 1));
      var timeZoneDiff = i.timeZoneOffset - offset;
      if (timeZoneDiff.inSeconds != 0) {
        offset = i.timeZoneOffset;
        i = i.subtract(new Duration(seconds: timeZoneDiff.inSeconds));
      }
    }
  }

  /// Returns a new [DateTime] on Monday of the current week.
  static DateTime firstDayOfWeek(DateTime day, [bool startOnMonday = false]) {
    // Handle Daylight Savings by setting hour to 12:00 Noon
    // rather than the default of Midnight
    day = new DateTime.utc(day.year, day.month, day.day, 12);

    // Weekday is on a 1-7 scale Monday - Sunday,
    // This Calendar works from Sunday - Monday
    int sub = startOnMonday ? (day.weekday % 7) - 1 : day.weekday % 7;
    return day.subtract(new Duration(days: sub));
  }

  /// Returns a new [DateTime] on Saturday of the current week.
  static DateTime lastDayOfWeek(DateTime day, [bool endOnSunday = false]) {
    // Handle Daylight Savings by setting hour to 12:00 Noon
    // rather than the default of Midnight
    day = new DateTime.utc(day.year, day.month, day.day, 12);

    // Weekday is on a 1-7 scale Monday - Sunday,
    // This Calendar's Week starts on Sunday
    int sub = endOnSunday ? 6 - (day.weekday % 7) : 7 - (day.weekday % 7);
    return day.add(new Duration(days: sub));
  }

  /// Returns a new [DateTime] in the 1st day of the given month
  static DateTime firstDayOfMonth(DateTime month) {
    return new DateTime(month.year, month.month);
  }

  /// Returns a new [DateTime] in the last day of the given month
  static DateTime lastDayOfMonth(DateTime month) {
    return nextMonth(month).subtract(new Duration(days: 1));
  }

  /// Retuns a new [DateTime] in the previous calendar month.
  ///
  /// If the month is January (01), the retuned [DateTime] is in the previous year
  static DateTime previousMonth(DateTime m) {
    var year = m.year;
    var month = m.month;
    if (month == 1) {
      year--;
      month = 12;
    } else {
      month--;
    }
    return new DateTime(year, month);
  }

  /// Retuns a new [DateTime] in the next calendar month.
  ///
  /// If the month is December (12), the retuned [DateTime] is in the next year
  static DateTime nextMonth(DateTime m) {
    var year = m.year;
    var month = m.month;

    if (month == 12) {
      year++;
      month = 1;
    } else {
      month++;
    }
    return new DateTime(year, month);
  }

  /// Returns a new [DateTime] 7 days before the given date
  static DateTime previousWeek(DateTime w) {
    return w.subtract(new Duration(days: 7));
  }

  /// Returns a new [DateTime] 7 days after the given date
  static DateTime nextWeek(DateTime w) {
    return w.add(new Duration(days: 7));
  }

  /// Whether or not two dates are on the same day.
  static bool isSameDay(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  /// Whether or not two dates are in the same week
  static bool isSameWeek(DateTime a, DateTime b) {
    // Handle Daylight Savings by setting hour to 12:00 Noon rather than the default of Midnight
    a = new DateTime.utc(a.year, a.month, a.day, 12);
    b = new DateTime.utc(b.year, b.month, b.day, 12);

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
  /// to [false].
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
    return new Tempus().from(this, withoutPrefixOrSuffix);
  }

  /// Returns a [String] with the different between [this] and [other]. Takes an optional [bool]
  /// argument to decide whether to use an identifier. [withoutPrefixOrSuffix] defaults to [false].
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
    Duration diff = _date.difference(other._date);

    String timeString = '';

    var locale = _getLocale();

    if (diff.inSeconds.abs() < 45)
      timeString = locale.seconds.replaceFirst('%i', '${diff.inSeconds.abs()}');
    else if (diff.inMinutes.abs() < 2)
      timeString = locale.aMinute.replaceFirst('%i', '${diff.inMinutes.abs()}');
    else if (diff.inMinutes.abs() < 45)
      timeString = locale.minutes.replaceFirst('%i', '${diff.inMinutes.abs()}');
    else if (diff.inHours.abs() < 2)
      timeString = locale.anHour.replaceFirst('%i', '${diff.inHours.abs()}');
    else if (diff.inHours.abs() < 22)
      timeString = locale.hours.replaceFirst('%i', '${diff.inHours.abs()}');
    else if (diff.inDays.abs() < 2)
      timeString = locale.aDay.replaceFirst('%i', '${diff.inDays.abs()}');
    else if (diff.inDays.abs() < 26)
      timeString = locale.days.replaceFirst('%i', '${diff.inDays.abs()}');
    else if (diff.inDays.abs() < 60)
      timeString =
          locale.aMonth.replaceFirst('%i', '${diff.inDays.abs() ~/ 30}');
    else if (diff.inDays.abs() < 320)
      timeString =
          locale.months.replaceFirst('%i', '${diff.inDays.abs() ~/ 30}');
    else if (diff.inDays.abs() < 547)
      timeString =
          locale.aYear.replaceFirst('%i', '${diff.inDays.abs() ~/ 356}');
    else
      timeString =
          locale.years.replaceFirst('%i', '${diff.inDays.abs() ~/ 356}');

    if (!withoutPrefixOrSuffix) {
      if (diff.isNegative)
        timeString = _addIdentifier(
            timeString, locale.futurePosition, locale.futureIdentifier);
      else
        timeString = _addIdentifier(
            timeString, locale.pastPosition, locale.pastIdentifier);
    }

    return timeString;
  }

  /// Returns the inner [DateTime].
  DateTime date() => this._date;

  /// Retuns a human-readable [String] for this instance.
  ///
  /// The resulting string can be parsed back using [parse].
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

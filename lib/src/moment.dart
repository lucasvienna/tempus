import 'package:better_moment/src/locale/locale.dart';
import 'package:better_moment/src/locale/locales/en.dart';

class Moment {
  DateTime _date;
  ILocale _locale;
  static ILocale _globalLocale = new LocaleEN();

  /// Default Moment constructor. Creates a new Moment instance based on current time in the local
  /// time zone.
  Moment() {
    _date = _now();
  }

  /// Creates a Moment based on current system time in the local time zone.
  ///
  /// Uses [DateTime.now()] internally.
  Moment.now() {
    _date = _now();
  }

  /// Creates a new Moment with the specified date.
  ///
  /// Throws a [FormatException] if the argument is null or of an invalid type.
  Moment.fromDate(DateTime date) {
    if (date != null && date is DateTime) {
      _date = date;
    } else {
      throw new FormatException('Date is null or of an invalid type.', date);
    }
  }

  /// Creates a new Moment based on miliseconds since the Epoch (January 1st 1970)
  ///
  /// [isUtc]: Dictates whether or not the passed values is in UTC
  Moment.fromMillisecondsSinceEpoch(int millisecondsSinceEpoch,
      {bool isUtc: false}) {
    _date = new DateTime.fromMillisecondsSinceEpoch(millisecondsSinceEpoch,
        isUtc: isUtc);
  }

  /// Constructs a new Moment instance based on [formattedString].
  ///
  /// Throws a [FormatException] if the input cannot be parsed.
  /// The function parses a subset of ISO 8601 which includes the subset accepted by RFC 3339.
  static Moment parse(String date) {
    return new Moment.fromDate(DateTime.parse(date));
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

  /// Returns a [String] with the different between [this] and [Moment.now()]. Takes an optional
  /// [boolean] argument to decide whether to use an identifier. [withoutPrefixOrSuffix] defaults
  /// to [false].
  ///
  /// ```
  /// var berlinWallFell = Moment.parse('19891109');
  /// // Assuming Moment.now() is in 2018
  /// String difference = berlinWallFell.fromNow();
  /// assert(difference == 'in 29 years');
  ///
  /// var berlinWallFell = Moment.parse('19891109');
  /// // Assuming Moment.now() is in 2018
  /// String difference = berlinWallFell.fromNow(false);
  /// assert(difference == '29 years');
  /// ```
  String fromNow([bool withoutPrefixOrSuffix = false]) {
    return from(new Moment(), withoutPrefixOrSuffix);
  }

  /// Returns a [String] with the different between [this] and [date]. Takes an optional [boolean]
  /// argument to decide whether to use an identifier. [withoutPrefixOrSuffix] defaults to [false].
  ///
  /// ```
  /// var berlinWallFell = Moment.parse('19891109');
  /// var dDay = new Moment.parse('19440606');
  /// String difference = berlinWallFell.from(dDay);
  /// assert(difference == '46 years ago');
  ///
  /// var berlinWallFell = Moment.parse('19891109');
  /// var dDay = new Moment.parse('19440606');
  /// String difference = berlinWallFell.from(dDay, false);
  /// assert(difference == '46 years');
  /// ```
  String from(Moment date, [bool withoutPrefixOrSuffix = false]) {
    Duration diff = date._date.difference(_date);

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
            timeString, locale.pastPosition, locale.pastIdentifier);
      else
        timeString = _addIdentifier(
            timeString, locale.futurePosition, locale.futureIdentifier);
    }

    return timeString;
  }

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
}

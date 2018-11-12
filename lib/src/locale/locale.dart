abstract class ILocale {
  String get seconds;

  String get aMinute;
  String get minutes;

  String get anHour;
  String get hours;

  String get aDay;
  String get days;

  String get aMonth;
  String get months;

  String get aYear;
  String get years;

  String get futureIdentifier;
  String get pastIdentifier;

  IdentifierPosition get futurePosition;
  IdentifierPosition get pastPosition;
}

enum IdentifierPosition {
  prepend,
  append,
  dontDisplay
}
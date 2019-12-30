part of tempus;

class LocaleEN implements ILocale {
  @override
  String get seconds => 'a few seconds';

  @override
  String get aMinute => 'a minute';
  @override
  String get minutes => '%i minutes';

  @override
  String get anHour => 'an hour';
  @override
  String get hours => '%i hours';

  @override
  String get aDay => 'a day';
  @override
  String get days => '%i days';

  @override
  String get aMonth => 'a month';
  @override
  String get months => '%i months';

  @override
  String get aYear => 'a year';
  @override
  String get years => '%i years';

  @override
  String get futureIdentifier => 'in';
  @override
  String get pastIdentifier => 'ago';

  @override
  IdentifierPosition get futurePosition => IdentifierPosition.prepend;
  @override
  IdentifierPosition get pastPosition => IdentifierPosition.append;

  @override
  List<String> get weekdays =>
      ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
}

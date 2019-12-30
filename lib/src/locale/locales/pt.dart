part of tempus;

class LocalePT implements ILocale {
  @override
  String get seconds => 'alguns segundos';

  @override
  String get aMinute => 'um minuto';
  @override
  String get minutes => '%i minutos';

  @override
  String get anHour => 'uma hora';
  @override
  String get hours => '%i horas';

  @override
  String get aDay => 'um dia';
  @override
  String get days => '%i dias';

  @override
  String get aMonth => 'um mês';
  @override
  String get months => '%i meses';

  @override
  String get aYear => 'um ano';
  @override
  String get years => '%i anos';

  @override
  String get futureIdentifier => 'em';
  @override
  String get pastIdentifier => 'há';

  @override
  IdentifierPosition get futurePosition => IdentifierPosition.prepend;
  @override
  IdentifierPosition get pastPosition => IdentifierPosition.prepend;

  @override
  List<String> get weekdays =>
      ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
}

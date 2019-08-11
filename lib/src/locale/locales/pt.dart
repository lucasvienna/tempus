import 'package:tempus/src/locale/locales.dart';

class LocalePT implements ILocale {
  String get seconds => 'alguns segundos';

  String get aMinute => 'um minuto';
  String get minutes => '%i minutos';

  String get anHour => 'uma hora';
  String get hours => '%i horas';

  String get aDay => 'um dia';
  String get days => '%i dias';

  String get aMonth => 'um mês';
  String get months => '%i meses';

  String get aYear => 'um ano';
  String get years => '%i anos';

  String get futureIdentifier => 'em';
  String get pastIdentifier => 'há';

  IdentifierPosition get futurePosition => IdentifierPosition.prepend;
  IdentifierPosition get pastPosition => IdentifierPosition.prepend;

  List<String> get weekdays =>
      ['Dom', 'Seg', 'Ter', 'Qua', 'Qui', 'Sex', 'Sáb'];
}

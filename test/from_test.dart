import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Difference:', () {
    test('instance.from(tempus) returns a valid string', () {
      final tempusAfter = Tempus.fromDate(DateTime(2018, 09, 25, 16, 25, 30));
      var tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 16, 26, 05));
      var from = tempusBefore.from(tempusAfter);
      expect(from, contains(LocaleEN().seconds));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 16, 27, 00));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aMinute));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().minutes.replaceFirst('%i', '15')));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 17, 40, 00));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().anHour));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 21, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().hours.replaceFirst('%i', '5')));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 26, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aDay));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 09, 30, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().days.replaceFirst('%i', '5')));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 10, 25, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aMonth));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2018, 12, 25, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().months.replaceFirst('%i', '3')));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2019, 09, 25, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aYear));
      expect(from, contains(LocaleEN().pastIdentifier));

      tempusBefore = Tempus.fromDate(DateTime(2048, 09, 25, 16, 40, 30));
      from =
          tempusBefore.from(tempusAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().years.replaceFirst('%i', '30')));
      expect(from, contains(LocaleEN().pastIdentifier));
    });
    test('instance.from(tempus, true) has no identifier', () {
      final tempusAfter = Tempus.fromDate(DateTime(2018, 09, 25, 16, 25, 30));
      var tempusBefore = Tempus.fromDate(DateTime(2018, 09, 25, 16, 26, 05));
      var from = tempusBefore.from(tempusAfter, true);
      expect(from, contains(LocaleEN().seconds));
      expect(from, isNot(contains(LocaleEN().pastIdentifier)));

      tempusBefore = Tempus.fromDate(DateTime(2019, 09, 25, 16, 40, 30));
      from = tempusBefore.from(
          tempusAfter, true); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aYear));
      expect(from, isNot(contains(LocaleEN().pastIdentifier)));
    });
    test('instance.fromNow() returns a valid string', () {
      var tempus = Tempus.fromDate(DateTime(2008, 09, 25, 16, 26, 05));
      var from = tempus.fromNow();
      expect(
          from,
          anyOf(
            anyOf(
              contains(LocaleEN().minutes.substring(4)),
              contains(LocaleEN().hours.substring(4)),
              contains(LocaleEN().days.substring(4)),
              contains(LocaleEN().months.substring(4)),
              contains(LocaleEN().years.substring(4)),
            ),
            anyOf(
              contains(LocaleEN().aMinute),
              contains(LocaleEN().anHour),
              contains(LocaleEN().aDay),
              contains(LocaleEN().aMonth),
              contains(LocaleEN().aYear),
            ),
            contains(LocaleEN().seconds),
          ));
      expect(from, anyOf(contains(LocaleEN().pastIdentifier)));

      tempus = Tempus.fromDate(DateTime(2189, 09, 25, 16, 26, 05));
      from = tempus.fromNow();
      expect(
          from,
          anyOf(
            anyOf(
              contains(LocaleEN().minutes.substring(4)),
              contains(LocaleEN().hours.substring(4)),
              contains(LocaleEN().days.substring(4)),
              contains(LocaleEN().months.substring(4)),
              contains(LocaleEN().years.substring(4)),
            ),
            anyOf(
              contains(LocaleEN().aMinute),
              contains(LocaleEN().anHour),
              contains(LocaleEN().aDay),
              contains(LocaleEN().aMonth),
              contains(LocaleEN().aYear),
            ),
            contains(LocaleEN().seconds),
          ));
      expect(from, anyOf(contains(LocaleEN().futureIdentifier)));
    });
    test('instance.fromNow(true) has no identifier', () {
      final tempus = Tempus.fromDate(DateTime(2018, 09, 25, 16, 26, 05));
      final from = tempus.fromNow(true);
      expect(
          from,
          anyOf(
            anyOf(
              contains(LocaleEN().minutes.substring(4)),
              contains(LocaleEN().hours.substring(4)),
              contains(LocaleEN().days.substring(4)),
              contains(LocaleEN().months.substring(4)),
              contains(LocaleEN().years.substring(4)),
            ),
            anyOf(
              contains(LocaleEN().aMinute),
              contains(LocaleEN().anHour),
              contains(LocaleEN().aDay),
              contains(LocaleEN().aMonth),
              contains(LocaleEN().aYear),
            ),
            contains(LocaleEN().seconds),
          ));
      expect(from, isNot(contains(LocaleEN().futureIdentifier)));
      expect(from, isNot(contains(LocaleEN().pastIdentifier)));
    });
  });
}

import 'package:test/test.dart';
import 'package:better_moment/better_moment.dart';

void main() {
  group('Difference', () {
    test('instance.from(moment) returns a valid string', () {
      Moment momentAfter = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 25, 30));
      Moment momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 26, 05));
      String from = momentBefore.from(momentAfter);
      expect(from, contains(LocaleEN().seconds));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 27, 00));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aMinute));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().minutes.replaceFirst('%i', '15')));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 17, 40, 00));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().anHour));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 21, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().hours.replaceFirst('%i', '5')));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 26, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aDay));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 09, 30, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().days.replaceFirst('%i', '5')));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 10, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aMonth));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2018, 12, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().months.replaceFirst('%i', '3')));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2019, 09, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aYear));
      expect(from, contains(LocaleEN().pastIdentifier));

      momentBefore = new Moment.fromDate(new DateTime(2048, 09, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().years.replaceFirst('%i', '30')));
      expect(from, contains(LocaleEN().pastIdentifier));
    });
    test('instance.from(moment, true) has no identifier', () {
      Moment momentAfter = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 25, 30));
      Moment momentBefore = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 26, 05));
      String from = momentBefore.from(momentAfter, true);
      expect(from, contains(LocaleEN().seconds));
      expect(from, isNot(contains(LocaleEN().pastIdentifier)));

      momentBefore = new Moment.fromDate(new DateTime(2019, 09, 25, 16, 40, 30));
      from = momentBefore.from(momentAfter, true); // DateTime(2018, 09, 25, 16, 25, 30)
      expect(from, contains(LocaleEN().aYear));
      expect(from, isNot(contains(LocaleEN().pastIdentifier)));
    });
    test('instance.fromNow() returns a valid string', () {
      Moment moment = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 26, 05));
      String from = moment.fromNow();
      expect(
          from,
          anyOf(
              anyOf(
                contains(LocaleEN().minutes),
                contains(LocaleEN().hours),
                contains(LocaleEN().days),
                contains(LocaleEN().months),
                contains(LocaleEN().years),
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
      expect(from, contains(LocaleEN().futureIdentifier));
    });
    test('instance.fromNow(true) has no identifier', () {
      Moment moment = new Moment.fromDate(new DateTime(2018, 09, 25, 16, 26, 05));
      String from = moment.fromNow(true);
      expect(
          from,
          anyOf(
              anyOf(
                contains(LocaleEN().minutes),
                contains(LocaleEN().hours),
                contains(LocaleEN().days),
                contains(LocaleEN().months),
                contains(LocaleEN().years),
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
    });
  });
}

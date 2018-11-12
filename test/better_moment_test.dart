import 'package:test/test.dart';
import 'package:better_moment/better_moment.dart';

void main() {
  group('Constructors:', () {
    test('Moment() generates a Moment', () {
      Moment moment = new Moment();
      expect(moment, new TypeMatcher<Moment>());
    });
    test('Moment.now() generates a Moment', () {
      Moment moment = new Moment.now();
      expect(moment, new TypeMatcher<Moment>());
    });
    test('Moment.fromDate(date) generates a Moment', () {
      DateTime dDay = new DateTime(1944, 06, 06);
      Moment moment = new Moment.fromDate(dDay);
      expect(moment, new TypeMatcher<Moment>());
      expect(moment.date(), allOf(isNotNull, equals(dDay)));
    });
    test(
        'Moment.fromMilisecondsSinceEpoch(ms, isUtc: true/false) generates an UTC Moment',
        () {
      DateTime dDay = new DateTime(1944, 06, 06);
      Moment moment = new Moment.fromMillisecondsSinceEpoch(
          dDay.millisecondsSinceEpoch,
          isUtc: false);
      expect(moment, new TypeMatcher<Moment>());
      expect(moment.date().millisecondsSinceEpoch,
          allOf(isNotNull, equals(dDay.millisecondsSinceEpoch)));

      DateTime dDayUtc = new DateTime(1944, 06, 06).toUtc();
      Moment momentUtc = new Moment.fromMillisecondsSinceEpoch(
          dDayUtc.millisecondsSinceEpoch,
          isUtc: true);
      expect(momentUtc, new TypeMatcher<Moment>());
      expect(momentUtc.date().millisecondsSinceEpoch,
          allOf(isNotNull, equals(dDayUtc.millisecondsSinceEpoch)));

      expect(moment.date().isUtc, isFalse);
      expect(momentUtc.date().isUtc, isTrue);
    });
    test('Moment.parse(string) generates a Moment', () {
      Moment moment = Moment.parse('2018-10-25');
      expect(moment, allOf(isNotNull, new TypeMatcher<Moment>()));
      expect(moment.date().day, equals(25));
      expect(moment.date().month, equals(10));
      expect(moment.date().year, equals(2018));
    });
  });
}

import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Constructors:', () {
    test('Tempus() generates a Tempus', () {
      Tempus tempus = new Tempus();
      expect(tempus, new TypeMatcher<Tempus>());
    });
    test('Tempus.fromDate(date) generates a Tempus', () {
      DateTime dDay = new DateTime(1944, 06, 06);
      Tempus tempus = new Tempus.fromDate(dDay);
      expect(tempus, new TypeMatcher<Tempus>());
      expect(tempus.date(), allOf(isNotNull, equals(dDay)));
    });
    test('Tempus.parse(string) generates a Tempus', () {
      Tempus tempus = Tempus.parse('2018-10-25');
      expect(tempus, allOf(isNotNull, new TypeMatcher<Tempus>()));
      expect(tempus.date().day, equals(25));
      expect(tempus.date().month, equals(10));
      expect(tempus.date().year, equals(2018));
    });
  });
}

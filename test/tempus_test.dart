import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Constructors:', () {
    test('Tempus() generates a Tempus', () {
      final tempus = Tempus();
      expect(tempus, TypeMatcher<Tempus>());
    });
    test('Tempus.fromDate(date) generates a Tempus', () {
      final dDay = DateTime(1944, 06, 06);
      final tempus = Tempus.fromDate(dDay);
      expect(tempus, TypeMatcher<Tempus>());
      expect(tempus.date(), allOf(isNotNull, equals(dDay)));
    });
    test('Tempus.parse(string) generates a Tempus', () {
      final tempus = Tempus.parse('2018-10-25');
      expect(tempus, allOf(isNotNull, TypeMatcher<Tempus>()));
      expect(tempus.date().day, equals(25));
      expect(tempus.date().month, equals(10));
      expect(tempus.date().year, equals(2018));
    });
  });
}

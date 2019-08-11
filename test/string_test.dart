import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('String converter:', () {
    test('instance.toString() should return a valid string', () {
      Tempus tempus = new Tempus.fromDate(new DateTime(2018, 06, 05, 01, 33));
      String string = tempus.toString();
      expect(string, equals('2018-06-05 01:33:00.000'));
    });
  });
}

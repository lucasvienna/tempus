import 'package:test/test.dart';
import 'package:better_moment/better_moment.dart';

void main() {
group('String converter:', () {
  test('instance.toString() should return a valid string', () {
    Moment moment = new Moment.fromDate(new DateTime(2018, 06, 05, 01, 33));
    String string = moment.toString();
    expect(string, equals('2018-06-05 01:33:00.000'));
  });
});
}
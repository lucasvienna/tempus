import 'package:flutter_test/flutter_test.dart';

import 'package:better_moment/better_moment.dart';

void main() {
  test('from', () {
    var berlinWallFell = Moment.parse('19891109');
    var dDay = Moment.parse('19440606');
    String difference = berlinWallFell.from(dDay);
    expect(difference, equals('46 years ago'));
  });
}

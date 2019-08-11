import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Comparatives:', () {
    test('Tempus.isSameDay(dateA, dateB) should return true when days match',
        () {
      DateTime dateA = new DateTime(2018, 06, 22, 12, 45);
      DateTime dateB = new DateTime(2018, 06, 22, 18, 20);
      expect(Tempus.isSameDay(dateA, dateB), isTrue);

      DateTime dateC = new DateTime(2019, 06, 22, 12, 45);
      expect(Tempus.isSameDay(dateA, dateC), isFalse);
    });
    test(
        'Tempus.isSameWeek(dateA, dateB) should return true when days are in the same week',
        () {
      DateTime dateA = new DateTime(2018, 06, 18);
      DateTime dateB = new DateTime(2018, 06, 22);
      expect(Tempus.isSameWeek(dateA, dateB), isTrue);

      DateTime dateC = new DateTime(2019, 06, 12);
      expect(Tempus.isSameWeek(dateA, dateC), isFalse);
    });
    test('Tempus.isFirstDayOfMonth(date) should return a valid boolean', () {
      DateTime date = new DateTime(2018, 06, 1);
      expect(Tempus.isFirstDayOfMonth(date), isTrue);

      // Days that overflow past the last day of a month goes into next one
      date = new DateTime(2018, 06, 31);
      expect(Tempus.isFirstDayOfMonth(date), isTrue);

      date = new DateTime(2018, 06, 05);
      expect(Tempus.isFirstDayOfMonth(date), isFalse);
    });
    test('Tempus.isLastDayOfMonth(date) should return a valid boolean', () {
      DateTime date = new DateTime(2018, 06, 30);
      expect(Tempus.isLastDayOfMonth(date), isTrue);

      // Days that overflow past the last day of a month goes into next one
      date = new DateTime(2018, 06, 61);
      expect(Tempus.isLastDayOfMonth(date), isTrue);

      date = new DateTime(2018, 06, 28);
      expect(Tempus.isLastDayOfMonth(date), isFalse);
    });
  });
  group('Ordinals:', () {
    test('Tempus.firstDayOfWeek(date, startOnMonday) returns a valid date', () {
      DateTime date = new DateTime(2018, 10, 4);
      DateTime firstDay = Tempus.firstDayOfWeek(date);
      expect(firstDay, allOf(isNotNull, new TypeMatcher<DateTime>()));
      expect(firstDay.day, equals(30));
      expect(firstDay.weekday, equals(7));
      expect(firstDay.month, equals(09));

      date = new DateTime(2018, 10, 4);
      firstDay = Tempus.firstDayOfWeek(date, true);
      expect(firstDay, allOf(isNotNull, new TypeMatcher<DateTime>()));
      expect(firstDay.day, equals(1));
      expect(firstDay.weekday, equals(1));
      expect(firstDay.month, equals(10));
    });
    test('Tempus.lastDayOfWeek(date, startOnMonday) returns a valid date', () {
      DateTime date = new DateTime(2018, 10, 4);
      DateTime firstDay = Tempus.lastDayOfWeek(date);
      expect(firstDay, allOf(isNotNull, new TypeMatcher<DateTime>()));
      expect(firstDay.day, equals(7));
      expect(firstDay.weekday, equals(7));
      expect(firstDay.month, equals(10));

      date = new DateTime(2018, 10, 4);
      firstDay = Tempus.lastDayOfWeek(date, true);
      expect(firstDay, allOf(isNotNull, new TypeMatcher<DateTime>()));
      expect(firstDay.day, equals(6));
      expect(firstDay.weekday, equals(6));
      expect(firstDay.month, equals(10));
    });
    test('Tempus.firstDayOfMonth(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 12, 5);
      expect(Tempus.firstDayOfMonth(date).day, equals(1));
      expect(Tempus.firstDayOfMonth(date).month, equals(12));
      expect(Tempus.firstDayOfMonth(date).year, equals(2018));
    });
    test('Tempus.lastDayOfMonth(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 12, 5);
      expect(Tempus.lastDayOfMonth(date).day, equals(31));
      expect(Tempus.lastDayOfMonth(date).month, equals(12));
      expect(Tempus.lastDayOfMonth(date).year, equals(2018));

      date = new DateTime(2016, 02, 12);
      expect(Tempus.lastDayOfMonth(date).day, equals(29));
      expect(Tempus.lastDayOfMonth(date).month, equals(02));
      expect(Tempus.lastDayOfMonth(date).year, equals(2016));
    });
    test('Tempus.previousMonth(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 01, 5);
      expect(Tempus.previousMonth(date).day, equals(1));
      expect(Tempus.previousMonth(date).month, equals(12));
      expect(Tempus.previousMonth(date).year, equals(2017));

      date = new DateTime(2016, 02, 12);
      expect(Tempus.previousMonth(date).day, equals(1));
      expect(Tempus.previousMonth(date).month, equals(01));
      expect(Tempus.previousMonth(date).year, equals(2016));
    });
    test('Tempus.nextMonth(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 01, 5);
      expect(Tempus.nextMonth(date).day, equals(01));
      expect(Tempus.nextMonth(date).month, equals(02));
      expect(Tempus.nextMonth(date).year, equals(2018));

      date = new DateTime(2018, 12, 06);
      expect(Tempus.nextMonth(date).day, equals(01));
      expect(Tempus.nextMonth(date).month, equals(01));
      expect(Tempus.nextMonth(date).year, equals(2019));
    });
    test('Tempus.previousWeek(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 01, 5);
      expect(Tempus.previousWeek(date).day, equals(29));
      expect(Tempus.previousWeek(date).month, equals(12));
      expect(Tempus.previousWeek(date).year, equals(2017));

      date = new DateTime(2016, 02, 12);
      expect(Tempus.previousWeek(date).day, equals(05));
      expect(Tempus.previousWeek(date).month, equals(02));
      expect(Tempus.previousWeek(date).year, equals(2016));
    });
    test('Tempus.nextWeek(date) returns a valid date', () {
      DateTime date = new DateTime(2018, 01, 5);
      expect(Tempus.nextWeek(date).day, equals(12));
      expect(Tempus.nextWeek(date).month, equals(01));
      expect(Tempus.nextWeek(date).year, equals(2018));

      date = new DateTime(2018, 12, 06);
      expect(Tempus.nextWeek(date).day, equals(13));
      expect(Tempus.nextWeek(date).month, equals(012));
      expect(Tempus.nextWeek(date).year, equals(2018));
    });
  });
  group('Ranges', () {
    test(
        'Tempus.datesInRange(dateA, dateB) should return a valid List<DateTime>',
        () {});
    test(
        'Tempus.datesInMonthGrid(dateA, dateB) should return a valid List<DateTime>',
        () {
      List<DateTime> grid = Tempus.datesInMonthGrid(new DateTime(2018, 10));
      expect(grid, allOf(isNotNull, new TypeMatcher<List<DateTime>>()));
      expect(grid.length, anyOf(equals(35), equals(42)));

      grid = Tempus.datesInMonthGrid(new DateTime(2018, 10), true, true);
      expect(grid, allOf(isNotNull, new TypeMatcher<List<DateTime>>()));
      expect(grid.length, equals(42));
      expect(grid.first.day, equals(1));
      expect(grid.first.month, equals(10));
      expect(grid.last.day, equals(11));
      expect(grid.last.month, equals(11));
    });
  });
}

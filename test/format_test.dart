import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Formatting:', () {
    group('Class properties:', () {
      test('instance.format() returns the instance\'s format', () {
        Tempus tempus = new Tempus();
        expect(tempus.format(), new TypeMatcher<FormatEN>());
      });
      test('instance.format(format) sets the format and returns the new value',
          () {
        Tempus tempus = new Tempus();
        IFormat format = tempus.format(new FormatDE());
        expect(format, allOf(isNotNull, new TypeMatcher<FormatDE>()));
      });
      test('tempus.globalFormat() returns the global format', () {
        Tempus tempus = new Tempus();
        IFormat gLocale = Tempus.globalFormat();
        IFormat format = tempus.format();
        expect(gLocale, allOf(isNotNull, new TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, new TypeMatcher<FormatEN>()));
        expect(format, equals(gLocale));
      });
      test(
          'tempus.globalFormat(gLocale) sets the global format and returns the new global format',
          () {
        Tempus tempus = new Tempus();
        IFormat gLocale = Tempus.globalFormat(new FormatDE());
        IFormat format = tempus.format();
        expect(gLocale, allOf(isNotNull, new TypeMatcher<FormatDE>()));
        expect(format, allOf(isNotNull, new TypeMatcher<FormatDE>()));
        expect(format, equals(gLocale));

        Tempus.globalFormat(new FormatEN());
        gLocale = Tempus.globalFormat();
        expect(gLocale, allOf(isNotNull, new TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, new TypeMatcher<FormatDE>()));
        expect(format, isNot(gLocale));
      });
      test('instance.format(format) should override the global format', () {
        Tempus tempus = new Tempus();
        IFormat gLocale = Tempus.globalFormat();
        IFormat format = tempus.format(new FormatDE());
        expect(gLocale, allOf(isNotNull, new TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, new TypeMatcher<FormatDE>()));
        expect(format, isNot(gLocale));
      });
    });
    group('Static formatters:', () {
      group('Getters:', () {
        test('Tempus.dayFormat returns the default "dd"', () {
          expect(Tempus.dayFormat,
              allOf(isNotNull, new TypeMatcher<String>(), equals('dd')));
        });
        test('Tempus.weekDayFormat returns the default "EEE MMM dd"', () {
          expect(
              Tempus.weekDayFormat,
              allOf(
                  isNotNull, new TypeMatcher<String>(), equals('EEE MMM dd')));
        });
        test('Tempus.apiDayFormat returns the default "yyyy-MM-dd"', () {
          expect(
              Tempus.apiDayFormat,
              allOf(
                  isNotNull, new TypeMatcher<String>(), equals('yyyy-MM-dd')));
        });
        test('Tempus.monthFormat returns the default "MMMM yyyy"', () {
          expect(Tempus.monthFormat,
              allOf(isNotNull, new TypeMatcher<String>(), equals('MMMM yyyy')));
        });
        test('Tempus.dayOfMonthFormat returns the default "MMM dd"', () {
          expect(Tempus.dayOfMonthFormat,
              allOf(isNotNull, new TypeMatcher<String>(), equals('MMM dd')));
        });
      });
      group('Setters:', () {
        test(
            'Tempus.setDayFormat(format) correctly assigns "format" to "dayFormat"',
            () {
          String orig = Tempus.dayFormat;
          Tempus.setDayFormat('dd-MM');
          expect(Tempus.dayFormat,
              allOf(isNotNull, new TypeMatcher<String>(), equals('dd-MM')));
          Tempus.setDayFormat(orig);
        });
        test(
            'Tempus.setWeekDayFormat(format) correctly assigns "format" to "weekDayFormat"',
            () {
          String orig = Tempus.weekDayFormat;
          Tempus.setWeekDayFormat('EEE MMM dd yyyy');
          expect(
              Tempus.weekDayFormat,
              allOf(isNotNull, new TypeMatcher<String>(),
                  equals('EEE MMM dd yyyy')));
          Tempus.setWeekDayFormat(orig);
        });
        test(
            'Tempus.setApiDayFormat(format) correctly assigns "format" to "apiDayFormat"',
            () {
          String orig = Tempus.apiDayFormat;
          Tempus.setApiDayFormat('yyyy-MM-dd HH:mm');
          expect(
              Tempus.apiDayFormat,
              allOf(isNotNull, new TypeMatcher<String>(),
                  equals('yyyy-MM-dd HH:mm')));
          Tempus.setApiDayFormat(orig);
        });
        test(
            'Tempus.setMonthFormat(format) correctly assigns "format" to "monthFormat"',
            () {
          String orig = Tempus.monthFormat;
          Tempus.setMonthFormat('dd MMMM yyyy');
          expect(
              Tempus.monthFormat,
              allOf(isNotNull, new TypeMatcher<String>(),
                  equals('dd MMMM yyyy')));
          Tempus.setMonthFormat(orig);
        });
        test(
            'Tempus.setDayOfMonthFormat(format) correctly assigns "format" to "dayOfMonthFormat"',
            () {
          String orig = Tempus.dayOfMonthFormat;
          Tempus.setDayOfMonthFormat('yyyy MMM dd');
          expect(
              Tempus.dayOfMonthFormat,
              allOf(
                  isNotNull, new TypeMatcher<String>(), equals('yyyy MMM dd')));
          Tempus.setDayOfMonthFormat(orig);
        });
      });
    });
  });
}

import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Formatting:', () {
    group('Class properties:', () {
      test('instance.format() returns the instance\'s format', () {
        final tempus = Tempus();
        expect(tempus.format(), TypeMatcher<FormatEN>());
      });
      test('instance.format(format) sets the format and returns the new value',
          () {
        final tempus = Tempus();
        final format = tempus.format(FormatDE());
        expect(format, allOf(isNotNull, TypeMatcher<FormatDE>()));
      });
      test('tempus.globalFormat() returns the global format', () {
        final tempus = Tempus();
        final gLocale = Tempus.globalFormat();
        final format = tempus.format();
        expect(gLocale, allOf(isNotNull, TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, TypeMatcher<FormatEN>()));
        expect(format, equals(gLocale));
      });
      test(
          'tempus.globalFormat(gLocale) sets the global format and returns the new global format',
          () {
        final tempus = Tempus();
        var gLocale = Tempus.globalFormat(FormatDE());
        final format = tempus.format();
        expect(gLocale, allOf(isNotNull, TypeMatcher<FormatDE>()));
        expect(format, allOf(isNotNull, TypeMatcher<FormatDE>()));
        expect(format, equals(gLocale));

        Tempus.globalFormat(FormatEN());
        gLocale = Tempus.globalFormat();
        expect(gLocale, allOf(isNotNull, TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, TypeMatcher<FormatDE>()));
        expect(format, isNot(gLocale));
      });
      test('instance.format(format) should override the global format', () {
        final tempus = Tempus();
        final gLocale = Tempus.globalFormat();
        final format = tempus.format(FormatDE());
        expect(gLocale, allOf(isNotNull, TypeMatcher<FormatEN>()));
        expect(format, allOf(isNotNull, TypeMatcher<FormatDE>()));
        expect(format, isNot(gLocale));
      });
    });
    group('Static formatters:', () {
      group('Getters:', () {
        test('Tempus.dayFormat returns the default "dd"', () {
          expect(Tempus.dayFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('dd')));
        });
        test('Tempus.weekDayFormat returns the default "EEE MMM dd"', () {
          expect(Tempus.weekDayFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('EEE MMM dd')));
        });
        test('Tempus.apiDayFormat returns the default "yyyy-MM-dd"', () {
          expect(Tempus.apiDayFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('yyyy-MM-dd')));
        });
        test('Tempus.monthFormat returns the default "MMMM yyyy"', () {
          expect(Tempus.monthFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('MMMM yyyy')));
        });
        test('Tempus.dayOfMonthFormat returns the default "MMM dd"', () {
          expect(Tempus.dayOfMonthFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('MMM dd')));
        });
      });
      group('Setters:', () {
        test(
            'Tempus.setDayFormat(format) correctly assigns "format" to "dayFormat"',
            () {
          final orig = Tempus.dayFormat;
          Tempus.setDayFormat('dd-MM');
          expect(Tempus.dayFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('dd-MM')));
          Tempus.setDayFormat(orig);
        });
        test(
            'Tempus.setWeekDayFormat(format) correctly assigns "format" to "weekDayFormat"',
            () {
          final orig = Tempus.weekDayFormat;
          Tempus.setWeekDayFormat('EEE MMM dd yyyy');
          expect(
              Tempus.weekDayFormat,
              allOf(
                  isNotNull, TypeMatcher<String>(), equals('EEE MMM dd yyyy')));
          Tempus.setWeekDayFormat(orig);
        });
        test(
            'Tempus.setApiDayFormat(format) correctly assigns "format" to "apiDayFormat"',
            () {
          final orig = Tempus.apiDayFormat;
          Tempus.setApiDayFormat('yyyy-MM-dd HH:mm');
          expect(
              Tempus.apiDayFormat,
              allOf(isNotNull, TypeMatcher<String>(),
                  equals('yyyy-MM-dd HH:mm')));
          Tempus.setApiDayFormat(orig);
        });
        test(
            'Tempus.setMonthFormat(format) correctly assigns "format" to "monthFormat"',
            () {
          final orig = Tempus.monthFormat;
          Tempus.setMonthFormat('dd MMMM yyyy');
          expect(Tempus.monthFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('dd MMMM yyyy')));
          Tempus.setMonthFormat(orig);
        });
        test(
            'Tempus.setDayOfMonthFormat(format) correctly assigns "format" to "dayOfMonthFormat"',
            () {
          final orig = Tempus.dayOfMonthFormat;
          Tempus.setDayOfMonthFormat('yyyy MMM dd');
          expect(Tempus.dayOfMonthFormat,
              allOf(isNotNull, TypeMatcher<String>(), equals('yyyy MMM dd')));
          Tempus.setDayOfMonthFormat(orig);
        });
      });
    });
  });
}

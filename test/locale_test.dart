import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Locale:', () {
    test('instance.locale() returns the instance\'s locale', () {
      final tempus = Tempus();
      expect(tempus.locale(), TypeMatcher<LocaleEN>());
    });
    test('instance.locale(locale) sets the locale and returns the new value',
        () {
      final tempus = Tempus();
      final locale = tempus.locale(LocaleDE());
      expect(locale, allOf(isNotNull, TypeMatcher<LocaleDE>()));
    });
    test('tempus.globalLocale() returns the global locale', () {
      final tempus = Tempus();
      final gLocale = Tempus.globalLocale();
      final locale = tempus.locale();
      expect(gLocale, allOf(isNotNull, TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, TypeMatcher<LocaleEN>()));
      expect(locale, equals(gLocale));
    });
    test(
        'tempus.globalLocale(gLocale) sets the global locale and returns the new global locale',
        () {
      final tempus = Tempus();
      var gLocale = Tempus.globalLocale(LocaleDE());
      final locale = tempus.locale();
      expect(gLocale, allOf(isNotNull, TypeMatcher<LocaleDE>()));
      expect(locale, allOf(isNotNull, TypeMatcher<LocaleDE>()));
      expect(locale, equals(gLocale));

      Tempus.globalLocale(LocaleEN());
      gLocale = Tempus.globalLocale();
      expect(gLocale, allOf(isNotNull, TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
    test('instance.locale(locale) should override the global locale', () {
      final tempus = Tempus();
      final gLocale = Tempus.globalLocale();
      final locale = tempus.locale(LocaleDE());
      expect(gLocale, allOf(isNotNull, TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
  });
}

import 'package:test/test.dart';
import 'package:tempus/tempus.dart';

void main() {
  group('Locale:', () {
    test('instance.locale() returns the instance\'s locale', () {
      Tempus tempus = new Tempus();
      expect(tempus.locale(), new TypeMatcher<LocaleEN>());
    });
    test('instance.locale(locale) sets the locale and returns the new value', () {
      Tempus tempus = new Tempus();
      ILocale locale = tempus.locale(new LocaleDE());
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
    });
    test('tempus.globalLocale() returns the global locale', () {
      Tempus tempus = new Tempus();
      ILocale gLocale = Tempus.globalLocale();
      ILocale locale = tempus.locale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, equals(gLocale));
    });
    test('tempus.globalLocale(gLocale) sets the global locale and returns the new global locale',
        () {
      Tempus tempus = new Tempus();
      ILocale gLocale = Tempus.globalLocale(new LocaleDE());
      ILocale locale = tempus.locale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, equals(gLocale));

      Tempus.globalLocale(new LocaleEN());
      gLocale = Tempus.globalLocale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
    test('instance.locale(locale) should override the global locale', () {
      Tempus tempus = new Tempus();
      ILocale gLocale = Tempus.globalLocale();
      ILocale locale = tempus.locale(new LocaleDE());
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
  });
}

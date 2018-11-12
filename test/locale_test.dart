import 'package:test/test.dart';
import 'package:better_moment/better_moment.dart';

void main() {
    group('Locale:', () {
    test('instance.locale() returns the instance\'s locale', () {
      Moment moment = new Moment();
      expect(moment.locale(), new TypeMatcher<LocaleEN>());
    });
    test('instance.locale(locale) sets the locale and returns the new value',
        () {
      Moment moment = new Moment();
      ILocale locale = moment.locale(new LocaleDE());
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
    });
    test('Moment.globalLocale() returns the global locale', () {
      Moment moment = new Moment();
      ILocale gLocale = Moment.globalLocale();
      ILocale locale = moment.locale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, equals(gLocale));
    });
    test(
        'Moment.globalLocale(gLocale) sets the global locale and returns the new global locale',
        () {
      Moment moment = new Moment();
      ILocale gLocale = Moment.globalLocale(new LocaleDE());
      ILocale locale = moment.locale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, equals(gLocale));

      Moment.globalLocale(new LocaleEN());
      gLocale = Moment.globalLocale();
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
    test('instance.locale(locale) should override the global locale', () {
      Moment moment = new Moment();
      ILocale gLocale = Moment.globalLocale();
      ILocale locale = moment.locale(new LocaleDE());
      expect(gLocale, allOf(isNotNull, new TypeMatcher<LocaleEN>()));
      expect(locale, allOf(isNotNull, new TypeMatcher<LocaleDE>()));
      expect(locale, isNot(gLocale));
    });
  });
}
# better_moment [![Build Status](https://travis-ci.org/Avyiel/better_moment.svg?branch=master)](https://travis-ci.org/Avyiel/better_moment)
An implementation of some Moment.js features for parsing, manipulates and displaying dates in Dart.

## Usage

A simple usage example:

```dart
import 'package:better_moment/better_moment.dart';

main() {
    var secondsToAdd = new Duration(seconds: 10);
    var dateForComparison = new DateTime.now().add(secondsToAdd);
    var moment = new Moment.now();

    // should print "in a few seconds"
    print(moment.from(dateForComparison));
}
```

## Locales

### Set the locale for all usages of `Moment`:

```dart
Moment.globalLocale(new LocaleDE());
```

### Set the locale only for the current instance of `Moment`:

```dart
var moment = new Moment.now().locale(new LocaleDE());
```

### Adding your own locale:

Just create a class that implements `ILocale` and assign that to your `Moment` instance or set it globally.


### Overwriting existing locales:

```dart
class ShortLocaleEn extends LocaleEn {
  String get seconds => '%is';

  String get aMinute => '%im';
  String get minutes => '%im';

  String get anHour => '%ih';
  String get hours => '%ih';

  String get aDay => '%id';
  String get days => '%id';
}
```

## Features and bugs

Please file feature requests and bugs at the [issue tracker][tracker].

[tracker]: https://github.com/Avyiel/better_moment/issues

## Notes

This package uses source code from [rinukkusu/simple_moment](https://github.com/rinukkusu/simple_moment) and [apptreesoftware/date_utils](https://github.com/apptreesoftware/date_utils). Any code forked from these repositories is released under their respective licenses.
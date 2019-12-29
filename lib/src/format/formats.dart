import 'package:intl/intl.dart';

export 'formats/de.dart';
export 'formats/en.dart';

abstract class IFormat {
  DateFormat get LTS;
  DateFormat get LT;
  DateFormat get L;
  DateFormat get LL;
  DateFormat get LLL;
  DateFormat get LLLL;
}

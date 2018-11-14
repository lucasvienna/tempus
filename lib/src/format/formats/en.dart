import 'package:intl/intl.dart';
import 'package:tempus/src/format/formats.dart';

class FormatEN implements IFormat {
  DateFormat get LTS => new DateFormat('h:mm:ss A');
  DateFormat get LT => new DateFormat('h:mm A');
  DateFormat get L => new DateFormat('MM/DD/YYYY');
  DateFormat get LL => new DateFormat('MMMM D, YYYY');
  DateFormat get LLL => new DateFormat('MMMM D, YYYY h:mm A');
  DateFormat get LLLL => new DateFormat('dddd, MMMM D, YYYY h:mm A');
}

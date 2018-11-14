import 'package:intl/intl.dart';
import 'package:tempus/src/format/formats.dart';

class FormatDE implements IFormat {
  DateFormat get LTS => new DateFormat('HH:mm:ss');
  DateFormat get LT => new DateFormat('HH:mm');
  DateFormat get L => new DateFormat('MM.DD.YYYY');
  DateFormat get LL => new DateFormat('D. MMMM YYYY');
  DateFormat get LLL => new DateFormat('D. MMMM YYYY HH:mm');
  DateFormat get LLLL => new DateFormat('dddd, D. MMMM YYYY HH:mm');
}

import 'package:intl/intl.dart';
import 'package:tempus/src/format/formats.dart';

class FormatEN implements IFormat {
  @override
  DateFormat get LTS => DateFormat('h:mm:ss A');
  @override
  DateFormat get LT => DateFormat('h:mm A');
  @override
  DateFormat get L => DateFormat('MM/DD/YYYY');
  @override
  DateFormat get LL => DateFormat('MMMM D, YYYY');
  @override
  DateFormat get LLL => DateFormat('MMMM D, YYYY h:mm A');
  @override
  DateFormat get LLLL => DateFormat('dddd, MMMM D, YYYY h:mm A');
}

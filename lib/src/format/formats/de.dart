part of tempus;

class FormatDE implements IFormat {
  @override
  DateFormat get LTS => DateFormat('HH:mm:ss');

  @override
  DateFormat get LT => DateFormat('HH:mm');

  @override
  DateFormat get L => DateFormat('MM.DD.YYYY');

  @override
  DateFormat get LL => DateFormat('D. MMMM YYYY');

  @override
  DateFormat get LLL => DateFormat('D. MMMM YYYY HH:mm');

  @override
  DateFormat get LLLL => DateFormat('dddd, D. MMMM YYYY HH:mm');
}

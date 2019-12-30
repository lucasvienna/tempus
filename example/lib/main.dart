import 'package:tempus/tempus.dart';

void main() {
  const secondsToAdd = Duration(seconds: 10);
  final dateForComparison = DateTime.now().add(secondsToAdd);
  final tempus = Tempus();

  // Will print "in a few seconds"
  print(tempus.from(Tempus.fromDate(dateForComparison)));

  // Will generate a list with 35 DateTimes, perfect for creating
  // calendar grids. By default starts on Sunday, can be Monday.
  final randomDate = DateTime(2020, 01);
  final dateGrid = Tempus.daysInMonth(randomDate, startOnMonday: true);

  // Will print something like:
  // [2019-12-30 12:00:00.000Z, 2019-12-31 12:00:00.000Z, 2020-01-01 12:00:00.000Z, [...]]
  print(dateGrid);
}

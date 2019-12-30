part of tempus;

/// Available day of week formats.
///
/// * [DayOfWeek.monday]: Monday - Sunday
/// * [DayOfWeek.tuesday]: Tuesday - Monday
/// * [DayOfWeek.wednesday]: Wednesday - Tuesday
/// * [DayOfWeek.thursday]: Thursday - Wednesday
/// * [DayOfWeek.friday]: Friday - Thursday
/// * [DayOfWeek.saturday]: Saturday - Friday
/// * [DayOfWeek.sunday]: Sunday - Saturday
enum DayOfWeek {
  monday,
  tuesday,
  wednesday,
  thursday,
  friday,
  saturday,
  sunday
}

int _getWeekdayNumber(DayOfWeek weekday) {
  return DayOfWeek.values.indexOf(weekday) + 1;
}

int _getDaysBefore(DateTime firstDay, DayOfWeek startingWeekDay) {
  return (firstDay.weekday + 7 - _getWeekdayNumber(startingWeekDay)) % 7;
}

int _getDaysAfter(DateTime lastDay, DayOfWeek startingWeekDay) {
  final invertedStartingWeekday = 8 - _getWeekdayNumber(startingWeekDay);

  var daysAfter = 7 - ((lastDay.weekday + invertedStartingWeekday) % 7) + 1;
  if (daysAfter == 8) {
    daysAfter = 1;
  }

  return daysAfter;
}

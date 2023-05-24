String labelSecond(int value) => value > 1 ? 'seconds' : 'second';

String labelMinute(int value) => value > 1 ? 'minutes' : 'minute';

String labelHour(int value) => value > 1 ? 'hours' : 'hour';

String labelDays(int value) => value > 1 ? 'days' : 'day';

String labelWeeks(int value) => value > 1 ? 'weeks' : 'week';

String labelMonth(int value) => value > 1 ? 'months' : 'month';

String labelYears(int value) => value > 1 ? 'years' : 'year';

/// parse seconds to minutes
int _secondsToMinutes(int seconds) {
  var minutes = (seconds / 60);
  return (minutes >= 1) ? minutes.toInt() : 0;
}

/// parse minutes to hours
int _minutesToHours(int minutes) {
  var hours = (minutes / 60);
  return (hours >= 1) ? hours.toInt() : 0;
}

/// parse hour to days
int _hoursToDays(int hour) {
  var days = (hour / 24);
  return (days >= 1) ? days.toInt() : 0;
}

/// parse days to week
int _daysToWeek(int days) {
  var week = (days / 7);
  return (week >= 1) ? week.toInt() : 0;
}

/// parse weeks to month
int _weekToMonth(int weeks) {
  var month = (weeks / 4);
  return (month >= 1) ? month.toInt() : 0;
}

/// parse month to years
int _monthToYear(int months) {
  var year = (months / 12);
  return (year >= 1) ? year.toInt() : 0;
}

Map<String, dynamic> _getMap(String key, dynamic value) => {key: value};

/// [_validate] Returns the estimated time in seconds, minutes, days, weeks, months, or years between dates.
/// Note: when [from] is not set it assumes the current system date
Map<String, dynamic> _validate(
    {required DateTime to, DateTime? from, required int annualLimit}) {
  assert(annualLimit >= 1 && annualLimit <= 99);

  DateTime now = from ?? DateTime.now();

  var difference = now.difference(to);
  var seconds = difference.inSeconds;
  var minutes = _secondsToMinutes(seconds);
  var hours = _minutesToHours(minutes);
  var days = _hoursToDays(hours);
  var weeks = _daysToWeek(days);
  var months = _weekToMonth(weeks);
  var years = _monthToYear(months);

  if (seconds < 0) return _getMap('date', to.toIso8601String());

  if (seconds == 0) return _getMap('now', seconds);

  if (minutes == 0) {
    return _getMap(labelSecond(seconds), seconds);
  } else if (minutes > 0 && minutes <= 59) {
    return _getMap(labelMinute(minutes), minutes);
  }

  if (hours >= 1 && hours < 24) {
    return _getMap(labelHour(hours), hours);
  } else if (hours == 24) {
    return _getMap(labelHour(1), 1);
  }

  if (days >= 1 && days < 7) return _getMap(labelDays(days), days);

  if (weeks >= 1 && weeks < 4) {
    return _getMap(labelWeeks(weeks), weeks);
  } else if (weeks == 4) {
    return _getMap(labelWeeks(1), 1);
  }

  if (months >= 1 && months < 12) {
    return _getMap(labelMonth(months), months);
  } else if (months == 12) {
    return _getMap(labelYears(1), 1);
  }

  if (years >= 1 && years <= annualLimit) return _getMap(labelYears(years), years);

  return _getMap('date', to.toIso8601String());
}

/// [Timed] Calculates the time interval between two dates in seconds, minutes, days, weeks, months, or years.
class Timed {
  Timed._();

  /// [get] Returns the estimated time in seconds, minutes, days, weeks, months, or years between dates.
  /// [annualLimit] If the calculation between the dates entered is more than 2 years it returns the value of [to]
  /// Unless you specify the [annualLimit] of years and it must not be more than 99 years
  /// Note: when [from] is not set it assumes the current system date
  static Map<String, dynamic> get(
          {required DateTime to, DateTime? from, int annualLimit = 2}) =>
      _validate(to: to, from: from, annualLimit: annualLimit);
}

extension TimedExtension on DateTime {
  /// [toTimed] Calculates the time interval between two dates in seconds, minutes, days, weeks, months, or years.
  Map<String, dynamic> get toTimed => Timed.get(to: this);
}

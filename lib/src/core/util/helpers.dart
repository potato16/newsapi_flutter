import 'package:intl/intl.dart';

const String datePattern = 'yyyy-MM-dd';
const String timePattern = 'HH:mm:ss';

/// input format: 2021-07-22T21:06:57Z
/// return format: 19 Sep 2018 if time is pass 24h
/// return format: 1 hours ago if time not pass 24h
/// return format: now if time is not pass 1h
String convertDateTimeFormat(String input) {
  DateTime date;
  try {
    date = DateTime.parse(input);
  } catch (e) {
    return '';
  }
  final now = DateTime.now();

  if (now.subtract(Duration(hours: 24)).isAfter(date)) {
    return DateFormat('dd MMM yyyy').format(date);
  } else {
    final hoursAgo = now.difference(date).inHours;

    if (hoursAgo > 1) {
      return '$hoursAgo hours ago';
    } else {
      return 'now';
    }
  }
}

/// output format:2021-07-22T21:06:57Z
String dateTimeToString(DateTime input) {
  final dt = input.toUtc();
  final d = DateFormat(datePattern).format(dt);
  final t = DateFormat(timePattern).format(dt);
  return '${d}T${t}Z';
}

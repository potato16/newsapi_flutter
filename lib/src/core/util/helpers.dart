import 'package:intl/intl.dart';

// const String dateTimePattern = 'EEE, dd MMM yyyy HH:mm:ss Z';
// Remove timezone for now because intl does not implement it yet
// So we assume all time zone value will be +0000
const String dateTimePattern = 'EEE, dd MMM yyyy HH:mm:ss';

/// input format: Wed, 19 Sep 2018 09:30:55 +0000
/// return format: 19 Sep 2018 if time is pass 24h
/// return format: 1 hours ago if time not pass 24h
/// return format: now if time is not pass 1h
String convertDateTimeFormat(String input) {
  if (input.endsWith('+0000')) {
    input = input.substring(0, input.length - 5);
  }
  final date = stringToDateTime(input);
  if (date == null) {
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

/// input format: Wed, 19 Sep 2018 09:30:55 +0000
DateTime? stringToDateTime(String input) {
  if (input.endsWith('+0000')) {
    input = input.substring(0, input.length - 5);
  }
  DateFormat format = DateFormat(dateTimePattern);
  try {
    return format.parse(input);
  } catch (e) {
    return null;
  }
}

/// output format: Wed, 19 Sep 2018 09:30:55 +0000
String dateTimeToString(DateTime input) {
  return DateFormat(dateTimePattern).format(input);
}

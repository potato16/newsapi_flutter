import 'package:flutter_test/flutter_test.dart';

import 'package:newsapi_flutter/src/core/util/helpers.dart';

void main() {
  test('convert 2021-07-22T21:06:57Z to 22 Jul 2021', () {
    final input = '2021-07-22T21:06:57Z';
    final want = '22 Jul 2021';
    final got = convertDateTimeFormat(input);
    expect(got, want);
  });
  test('convert time pass fews hours ago', () {
    final time = DateTime.now().subtract(Duration(minutes: 30, hours: 2));
    final input = dateTimeToString(time);
    final want = '2 hours ago';
    final got = convertDateTimeFormat(input);
    expect(got, want);
  });
  test('convert time pass just now', () {
    final time = DateTime.now().subtract(Duration(
      minutes: 30,
    ));
    final input = dateTimeToString(time);
    final want = 'now';
    final got = convertDateTimeFormat(input);
    expect(got, want);
  });
  test('convert convertDateTimeFormat with invalid input', () {
    final input = 'Wed, 19 Sep 2018 09:30';
    final want = '';
    final got = convertDateTimeFormat(input);
    expect(got, want);
  });
}

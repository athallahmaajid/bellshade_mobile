import 'dart:core';

DateTime dateParse(String rawDate) {
  return DateTime.parse(rawDate.replaceAll("T", " "));
}

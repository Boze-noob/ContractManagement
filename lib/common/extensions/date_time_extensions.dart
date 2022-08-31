import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

//Locale is hardcoded to en
extension DateTimeExtensions on DateTime {
  DateTime copyWith(TimeOfDay timeOfDay) => DateTime(year, month, day, timeOfDay.hour, timeOfDay.minute);
  bool isEqualDate(DateTime other) => year == other.year && month == other.month && day == other.day;
  String toISO() => '$year$month$day$hour$minute$second';
  String format() => DateFormat.yMMMMd(Locale('en', '').languageCode).format(this).toString();
  String formatMMMMEEEEd() => DateFormat.yMMMMEEEEd(Locale('en', '').languageCode).format(this).toString();
  String formatMMMd() => DateFormat.MMMd(Locale('en', '').languageCode).format(this).toString();
  String formatMMMdEEE() => DateFormat('MMM, d EEE').format(this).toString();
  String formatYY() => DateFormat('y').format(this).toString();

  String formatDDMMYY() => DateFormat('dd-MM-yyyy').format(this);
  String formatDDMMYYHHMMSS() => DateFormat('yyyy-MM-dd hh:mm:ss').format(this);
}

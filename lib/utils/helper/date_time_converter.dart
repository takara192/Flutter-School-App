import 'package:intl/intl.dart';

class DateTimeConverter{
  static String toIso8601DateOnly(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }
}
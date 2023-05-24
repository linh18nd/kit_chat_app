import 'package:intl/intl.dart';

class DateTimeConvert {
  static String convertDateTimeToString(DateTime dateTime) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day} ${dateTime.hour}:${dateTime.minute}:${dateTime.second}';
  }

  static DateTime convertStringToDateTime(String dateTime) {
    return DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateTime);
  }
}

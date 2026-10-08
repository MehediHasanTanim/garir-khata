import 'package:intl/intl.dart';

class DateFormatter {
  DateFormatter({this.locale = 'en'});

  final String locale;

  String formatDate(DateTime date) {
    return DateFormat.yMMMd(locale).format(date);
  }

  String formatDateTime(DateTime dateTime) {
    return DateFormat.yMMMd(locale).add_jm().format(dateTime);
  }

  String formatMonthYear(DateTime date) {
    return DateFormat.yMMMM(locale).format(date);
  }
}

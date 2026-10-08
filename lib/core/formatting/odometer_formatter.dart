import 'package:intl/intl.dart';

class OdometerFormatter {
  OdometerFormatter({String locale = 'en'})
    : _number = NumberFormat.decimalPattern(locale);

  final NumberFormat _number;

  String format(int kilometers) => '${_number.format(kilometers)} km';
}

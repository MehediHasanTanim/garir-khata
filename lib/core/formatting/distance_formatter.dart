import 'package:intl/intl.dart';

class DistanceFormatter {
  DistanceFormatter({String locale = 'en'})
    : _number = NumberFormat.decimalPattern(locale);

  final NumberFormat _number;

  String formatKm(num kilometers) => '${_number.format(kilometers)} km';
}

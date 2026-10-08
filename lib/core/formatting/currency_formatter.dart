import 'package:intl/intl.dart';

/// Formats BDT amounts. Store money as integer paisa in persistence layers.
class CurrencyFormatter {
  CurrencyFormatter({String locale = 'en_BD'})
    : _formatter = NumberFormat.currency(
        locale: locale,
        symbol: '৳',
        decimalDigits: 2,
      );

  final NumberFormat _formatter;

  String formatMajor(num amount) => _formatter.format(amount);

  String formatPaisa(int paisa) => formatMajor(paisa / 100);
}

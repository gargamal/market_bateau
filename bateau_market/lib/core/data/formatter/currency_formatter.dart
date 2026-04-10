import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';

extension DecimalFormatter on Decimal {
  String toCurrency() {
    final formatter = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '€',
      decimalDigits: 2,
    );
    return formatter.format(toDouble());
  }
}
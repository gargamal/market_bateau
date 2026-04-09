import 'package:intl/intl.dart';

class NumberFormatter {
  final formatter = NumberFormat('#,###', 'fr_FR');

  String format(int number) {
    return formatter.format(number).replaceAll(',', ' ');
  }
}
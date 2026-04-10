import 'package:intl/intl.dart';

class NumberFormatter {
  final _formatter = NumberFormat('#,###', 'fr_FR');

  String format(int number) {
    return _formatter.format(number).replaceAll(',', ' ');
  }
}
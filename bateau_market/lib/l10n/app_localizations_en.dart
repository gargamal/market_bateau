// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'My beautiful ships';

  @override
  String error(String message) {
    return 'Error: $message';
  }

  @override
  String get findYourShip => 'Find your ship';

  @override
  String get chooseTheCity => 'Choose the city';

  @override
  String maxPower(int power) {
    return 'Max Power: $power';
  }

  @override
  String get reinitialize => 'Reinitialize';

  @override
  String get apply => 'Apply';
}

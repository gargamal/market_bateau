// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Mes beaux bateaux';

  @override
  String error(String message) {
    return 'Erreur : $message';
  }

  @override
  String get findYourShip => 'Trouvez votre bateau';

  @override
  String get chooseTheCity => 'Choisissez la ville';

  @override
  String maxPower(int power) {
    return 'Puissance Max : $power';
  }

  @override
  String get reinitialize => 'Réinitialiser';

  @override
  String get apply => 'Appliquer';
}

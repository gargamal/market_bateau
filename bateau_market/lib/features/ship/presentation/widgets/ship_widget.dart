import 'package:flutter/material.dart';
import 'package:select_bateau/core/data/formatter/currency_formatter.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/core/data/formatter/number_formatter.dart';
import 'package:select_bateau/features/ship/presentation/widgets/detail_ship_widget.dart';

class ShipWidget extends StatelessWidget {
  final Ship _ship;
  final String _powerFormatted;
  final DetailShipWidget _detailShip = DetailShipWidget();

  ShipWidget({
    super.key,
    required Ship ship,
  }) : _ship = ship, _powerFormatted = NumberFormatter().format(ship.power);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Container(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () => _detailShip.show(context, _ship, _powerFormatted),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    // Utilise la couleur de surface du thème (s'adapte au dark/light)
                    color: colorScheme.surfaceContainerHigh),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      child: Text(_ship.name.substring(0, 1).toUpperCase() + _ship.name.substring(1, 2).toLowerCase())
                  ),
                  title: Container(
                      padding: const EdgeInsets.all(8),
                      child: Center(child: Text(
                          style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary, fontSize: 18),
                          _ship.name))
                  ),
                  subtitle: Text("${_ship.price.toCurrency()}\n$_powerFormatted CV\n${_ship.nbHourOfAutonomy} hours of autonomy\n${_ship.nbPeopleMax} people max"),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        _ship.marketPlace,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Icon(
                        Icons.location_on,
                        color: colorScheme.error, // Rouge standard du thème
                        size: 24,
                      ),
                    ],
                  ),
                )
            )
        )
    );
  }
}

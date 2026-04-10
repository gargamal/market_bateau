import 'package:flutter/material.dart';
import 'package:select_bateau/core/data/formatter/currency_formatter.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/core/data/formatter/number_formatter.dart';
import 'package:select_bateau/features/ship/presentation/widgets/detail_ship_widget.dart';

class ShipWidget extends StatelessWidget {
  final Color _backColor;
  final Color _circleBackColor;
  final Color _circleTextColor;
  final Ship _ship;
  final String _powerFormatted;
  final DetailShip _detailShip = DetailShip();

  ShipWidget({
    super.key,
    required Ship ship,
    Color backColor = const Color(0xFFC4D3E8),
    Color circleBackColor = const Color(0xFF083360),
    Color circleTextColor = const Color(0xFFB8C6CC)
  }) : _ship = ship, _circleTextColor = circleTextColor, _circleBackColor = circleBackColor, _backColor = backColor, _powerFormatted = NumberFormatter().format(ship.power);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () => _detailShip.show(context, _ship, _powerFormatted),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withValues(alpha: 0.75),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    color: _backColor),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: _circleBackColor,
                      foregroundColor: _circleTextColor,
                      child: Text(_ship.name.substring(0, 1).toUpperCase() + _ship.name.substring(1, 2).toLowerCase())
                  ),
                  title: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(child: Text(
                          style: TextStyle(fontWeight: FontWeight.bold, color: _circleBackColor, fontSize: 18),
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
                      const SizedBox(height: 4), // Petit espace entre le texte et l'icône
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
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

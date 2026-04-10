import 'package:flutter/material.dart';
import 'package:select_bateau/core/utils/currency_formatter.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/core/utils/number_formatter.dart';
import 'package:select_bateau/features/ship/presentation/widgets/detail_ship_widget.dart';

class ShipWidget extends StatelessWidget {
  final Color backColor;
  final Color circleBackColor;
  final Color circleTextColor;
  final Ship ship;
  final String powerFormatted;
  final DetailShip detailOneShip = DetailShip();

  ShipWidget({
    super.key,
    required this.ship,
    this.backColor = const Color(0xFFC4D3E8),
    this.circleBackColor = const Color(0xFF083360),
    this.circleTextColor = const Color(0xFFB8C6CC)
  }) : powerFormatted = NumberFormatter().format(ship.power);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
            onTap: () => detailOneShip.show(context, ship, powerFormatted),
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
                    color: backColor),
                child: ListTile(
                  leading: CircleAvatar(
                      backgroundColor: circleBackColor,
                      foregroundColor: circleTextColor,
                      child: Text(ship.name.substring(0, 1).toUpperCase() + ship.name.substring(1, 2).toLowerCase())
                  ),
                  title: Container(
                      padding: EdgeInsets.all(8),
                      child: Center(child: Text(
                          style: TextStyle(fontWeight: FontWeight.bold, color: circleBackColor, fontSize: 18),
                          ship.name))
                  ),
                  subtitle: Text("${ship.price.toCurrency()}\n$powerFormatted CV\n${ship.nbHourOfAutonomy} hours of autonomy\n${ship.nbPeopleMax} people max"),
                  trailing: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        ship.marketPlace,
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

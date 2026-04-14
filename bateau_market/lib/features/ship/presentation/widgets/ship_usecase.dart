import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/widgets/ship_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Default State',
  type: ShipWidget,
)Widget buildShipWidgetUseCase(BuildContext context) {
  final mockShip = Ship(
      name: 'Yacht Deluxe',
      power: 500,
      nbHourOfAutonomy: 10,
      nbPeopleMax: 12,
      price: Decimal.parse('250000.00'),
      marketPlace: 'Saint-Tropez',
      lat: 48.8566,
      lng: 2.3522
  );

  return Center(
    child: SizedBox(
      width: 400,
      child: ShipWidget(ship: mockShip),
    ),
  );
}
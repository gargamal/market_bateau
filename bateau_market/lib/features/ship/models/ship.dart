import 'package:decimal/decimal.dart';

class Ship {
  final String name;
  final int power;
  final int nbHourOfAutonomy;
  final int nbPeopleMax;
  final String marketPlace;
  final Decimal price;
  final double lat;
  final double lng;

  Ship({required this.name,
    required this.power,
    required this.nbHourOfAutonomy,
    required this.nbPeopleMax,
    required this.marketPlace,
    required this.price,
    required this.lat,
    required this.lng});

  factory Ship.fromJson(Map<String, dynamic> json) {
    return Ship(
      name: json['name'] ?? '',
      power: json['power'] ?? 0,
      nbHourOfAutonomy: json['nbHourOfAutonomy'] ?? 0,
      nbPeopleMax: json['nbPeopleMax'] ?? 0,
      marketPlace: json['marketPlace'] ?? '',
      price: Decimal.parse(json['price'].toString()),
      lat: json['lat'] ?? 0.0,
      lng: json['lng'] ?? 0.0,
    );
  }
}
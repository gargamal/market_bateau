import 'package:decimal/decimal.dart';
import 'package:hive_ce/hive_ce.dart';

part 'ship.g.dart';

@HiveType(typeId: 1)
class Ship {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final int power;
  @HiveField(2)
  final int nbHourOfAutonomy;
  @HiveField(3)
  final int nbPeopleMax;
  @HiveField(4)
  final String marketPlace;
  @HiveField(5)
  final Decimal price;
  @HiveField(6)
  final double lat;
  @HiveField(7)
  final double lng;

  const Ship({required this.name,
    required this.power,
    required this.nbHourOfAutonomy,
    required this.nbPeopleMax,
    required this.marketPlace,
    required this.price,
    required this.lat,
    required this.lng});

  factory Ship.fromJson(Map<String, dynamic> json) => Ship(
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
import 'package:hive_ce/hive_ce.dart';

part 'city.g.dart';

@HiveType(typeId: 2)
class City {
  @HiveField(0)
  final String name;

  const City({required this.name});

  factory City.fromJson(Map<String, dynamic> json) => City(name: json['name'] ?? '');
}
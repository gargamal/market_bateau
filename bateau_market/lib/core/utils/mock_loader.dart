import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:select_bateau/features/ship/models/ship.dart';

class MockLoader {
  static Future<List<Ship>> loadShips() async {
    final String response = await rootBundle.loadString('assets/mocks/ships.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Ship.fromJson(json)).toList();
  }
}
import 'package:flutter_test/flutter_test.dart';
import 'package:select_bateau/core/utils/mock_loader.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('MockLoader Tests', () {
    test('loadShips should return a list of Ships from JSON', () async {
      const String mockJson = '[{"name": "Test Ship", "power": 100, "nbHourOfAutonomy": 10, "nbPeopleMax": 5, "marketPlace": "Brest", "price": "50000", "lat": 48.0, "lng": -4.0}]';
      
      TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMessageHandler(
        'flutter/assets',
        (message) async {
          final ByteData data = ByteData.view(Uint8List.fromList(utf8.encode(mockJson)).buffer);
          return data;
        },
      );

      final ships = await MockLoader.loadShips();

      expect(ships, isA<List<Ship>>());
      expect(ships.length, 1);
      expect(ships.first.name, 'Test Ship');
    });
  });
}

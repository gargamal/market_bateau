import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:select_bateau/core/network/ship_url_provider.dart';

// 2. Utilisation du baseUrlProvider dans le shipsProvider
final shipsProvider = FutureProvider<List<String>>((ref) async {
  final baseUrl = ref.watch(baseUrlProvider);
  
  final response = await http.get(
      Uri.parse('$baseUrl/getAll'),
      headers: {
        'Accept': 'application/json',
      });

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((ship) => ship['name'] as String).toList();
  } else {
    throw Exception('Erreur de chargement: ${response.statusCode}');
  }
});

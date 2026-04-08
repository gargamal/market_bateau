import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/models/ship_state.dart';

class ShipPaginationNotifier extends AsyncNotifier<ShipsState> {
  @override
  FutureOr<ShipsState> build() async {
    // Chargement initial (Page 1)
    final initialShips = await _fetchShips(page: 1);
    return ShipsState(ships: initialShips);
  }

  Future<List<Ship>> _fetchShips({required int page}) async {
    final response = await http.get(Uri.parse('$baseUrl/get?page=$page&limit=$limitShipsPagination'));

    if (response.statusCode == 200) {
      return (json.decode(response.body) as List).map((u) => Ship.fromJson(u)).toList();
    } else {
      throw Exception('Erreur de chargement');
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore) return;

    // 1. On passe en mode "chargement" sans effacer les données actuelles
    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final newShips = await _fetchShips(page: nextPage);

      // 2. On ajoute les nouveaux utilisateurs à la suite des anciens
      state = AsyncData(currentState.copyWith(
          ships: [...currentState.ships, ...newShips],
          currentPage: nextPage,
          isLoadingMore: false));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}

// Le provider pour exposer notre Notifier
final shipPaginationProvider = AsyncNotifierProvider<ShipPaginationNotifier, ShipsState>(() {
  return ShipPaginationNotifier();
});

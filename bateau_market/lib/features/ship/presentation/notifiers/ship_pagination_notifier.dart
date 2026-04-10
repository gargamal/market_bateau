import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/models/ship_filters.dart';
import 'package:select_bateau/features/ship/models/ship_state.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';

class ShipPaginationNotifier extends AsyncNotifier<ShipsState> {
  static const boxName = 'ships_box';
  CancelToken? _cancelToken;

  @override
  FutureOr<ShipsState> build() async {
    final filters = ref.watch(shipFilterProvider);
    
    List<Ship> initialShips = [];
    if (_isFilterEmpty(filters)) {
      initialShips = _getLocalShips();
    } else {
      initialShips = _getLocalShips();
      initialShips.retainWhere((ship) {
        if (filters.power != null && ship.power < filters.power!) return false;
        if (filters.marketPlace != null && ship.marketPlace != filters.marketPlace) return false;
        if (filters.nbPeopleMax != null && ship.nbPeopleMax < filters.nbPeopleMax!) return false;
        return true;
      });
    }

    _refreshShipsInBackground(filters);

    return ShipsState(ships: initialShips);
  }

  bool _isFilterEmpty(ShipFilters filters) {
    return (filters.power ?? 0) == 0 && 
           (filters.marketPlace?.isEmpty ?? true) && 
           (filters.nbPeopleMax ?? 0) == 0;
  }

  List<Ship> _getLocalShips() {
    final box = Hive.box<Ship>(boxName);
    return box.values.toList();
  }

  Future<void> _refreshShipsInBackground(ShipFilters filters) async {
    try {
      final remoteShips = await _fetchShips(page: 1, filters: filters);

      if (_isFilterEmpty(filters)) {
        final box = Hive.box<Ship>(boxName);
        await box.clear();
        await box.addAll(remoteShips);
      }

      state = AsyncData(ShipsState(ships: remoteShips, currentPage: 1));
    } catch (e, stack) {
      if (state.value?.ships.isEmpty ?? true) {
        state = AsyncError(e, stack);
      }
    }
  }

  Future<List<Ship>> _fetchShips({required int page, required ShipFilters filters}) async {
    try {
      _cancelToken?.cancel("New request");
      _cancelToken = CancelToken();

      final queryParams = {
        'page': page,
        'limit': limitShipsPagination,
        if ((filters.power ?? 0) > 0) 'power': filters.power,
        if (filters.marketPlace?.isNotEmpty ?? false) 'marketPlace': filters.marketPlace,
        if ((filters.nbPeopleMax ?? 0) > 0) 'nbPeopleMax': filters.nbPeopleMax,
      };

      final dio = ref.read(dioProvider);
      final response = await dio.get(
        '$baseUrl/ship/get',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((u) => Ship.fromJson(u)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) return [];
      rethrow;
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final filters = ref.read(shipFilterProvider);
      final newShips = await _fetchShips(page: nextPage, filters: filters);

      state = AsyncData(currentState.copyWith(
          ships: [...currentState.ships, ...newShips],
          currentPage: nextPage,
          isLoadingMore: false));
    } catch (e, st) {
      if (state.value != null) {
        state = AsyncData(state.value!.copyWith(isLoadingMore: false));
      }
    }
  }
}

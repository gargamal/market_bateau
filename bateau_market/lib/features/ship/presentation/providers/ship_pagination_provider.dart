import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';

class ShipsState {
  final List<Ship> ships;
  final bool isLoadingMore;
  final int currentPage;

  ShipsState({required this.ships, this.isLoadingMore = false, this.currentPage = 1});

  ShipsState copyWith({List<Ship>? ships, bool? isLoadingMore, int? currentPage}) {
    return ShipsState(
        ships: ships ?? this.ships,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore,
        currentPage: currentPage ?? this.currentPage);
  }
}

class ShipPaginationNotifier extends AsyncNotifier<ShipsState> {
  CancelToken? _cancelToken;

  @override
  FutureOr<ShipsState> build() async {
    final filters = getFilters();

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

  bool _isFilterEmpty(ShipFiltersState filters) {
    return (filters.power ?? 0) == 0 &&
        (filters.marketPlace?.isEmpty ?? true) &&
        (filters.nbPeopleMax ?? 0) == 0;
  }

  List<Ship> _getLocalShips() {
    final box = Hive.box<Ship>(shipsBoxName);
    return box.values.toList();
  }

  Future<void> _refreshShipsInBackground(ShipFiltersState filters) async {
    try {
      final remoteShips = await _fetchShips(page: 1, filters: filters);

      if (_isFilterEmpty(filters)) {
        final box = Hive.box<Ship>(shipsBoxName);
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

  Future<List<Ship>> _fetchShips({required int page, required ShipFiltersState filters}) async {
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
      final filters = getFilters();
      final newShips = await _fetchShips(page: nextPage, filters: filters);

      state = AsyncData(currentState.copyWith(
          ships: [...currentState.ships, ...newShips],
          currentPage: nextPage,
          isLoadingMore: false));
    } catch (e) {
      if (state.value != null) {
        state = AsyncData(state.value!.copyWith(isLoadingMore: false));
      }
    }
  }

  ShipFiltersState getFilters() {
    return ref.watch(shipFilterProvider);
  }
}

final shipPaginationProvider = AsyncNotifierProvider<ShipPaginationNotifier, ShipsState>(() {
  return ShipPaginationNotifier();
});

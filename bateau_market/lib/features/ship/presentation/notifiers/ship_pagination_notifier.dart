import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/models/ship_filters.dart';
import 'package:select_bateau/features/ship/models/ship_state.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';

class ShipPaginationNotifier extends AsyncNotifier<ShipsState> {
  CancelToken? cancelToken;

  @override
  FutureOr<ShipsState> build() async {
    final filters = ref.watch(shipFilterProvider);
    final initialShips = await fetchShips(page: 1, filters: filters);
    return ShipsState(ships: initialShips);
  }

  Future<List<Ship>> fetchShips({required int page, required ShipFilters filters}) async {
    try {
      cancelToken?.cancel("New filter apply");
      cancelToken = CancelToken();

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
      throw Exception('Network error : ${e.message}');
    }
  }

  Future<void> loadNextPage() async {
    final currentState = state.value;
    if (currentState == null || currentState.isLoadingMore) return;

    state = AsyncData(currentState.copyWith(isLoadingMore: true));

    try {
      final nextPage = currentState.currentPage + 1;
      final filters = ref.read(shipFilterProvider);
      final newShips = await fetchShips(page: nextPage, filters: filters);

      state = AsyncData(currentState.copyWith(
          ships: [...currentState.ships, ...newShips],
          currentPage: nextPage,
          isLoadingMore: false));
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
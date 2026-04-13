import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/city.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';

class CitiesState {
  final List<City> cities;
  final bool isLoadingMore;

  CitiesState({required this.cities, this.isLoadingMore = false});

  CitiesState copyWith({List<City>? cities, bool? isLoadingMore}) {
    return CitiesState(
        cities: cities ?? this.cities,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }
}

class CityNotifier extends AsyncNotifier<CitiesState> {
  CancelToken? _cancelToken;

  @override
  FutureOr<CitiesState> build() async {
    final localCities = _getLocalCities();
    _refreshCitiesInBackground();
    return CitiesState(cities: localCities);
  }

  List<City> _getLocalCities() {
    final box = Hive.box<City>(citiesBoxName);
    return box.values.toList();
  }

  Future<void> _refreshCitiesInBackground() async {
    try {
      final remoteCities = await _fetchCitiesFromNetwork();

      final box = Hive.box<City>(citiesBoxName);
      await box.clear();
      await box.addAll(remoteCities);

      state = AsyncData(CitiesState(cities: remoteCities));
    } catch (e, stack) {
      if (_getLocalCities().isEmpty) {
        state = AsyncError(e, stack);
      }
    }
  }

  Future<List<City>> _fetchCitiesFromNetwork() async {
    try {
      _cancelToken?.cancel("New request");
      _cancelToken = CancelToken();

      final dio = ref.read(dioProvider);
      final response = await dio.get('$baseUrl/city/getAll');

      if (response.statusCode == 200) {
        final List data = response.data;
        return data.map((u) => City.fromJson(u)).toList();
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) return [];
      rethrow;
    }
  }
}

final cityProvider = AsyncNotifierProvider<CityNotifier, CitiesState>(() {
  return CityNotifier();
});
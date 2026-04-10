import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/city.dart';
import 'package:select_bateau/features/ship/models/city_state.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';

class CityNotifier extends AsyncNotifier<CitiesState> {
  static const boxName = 'cities_box';
  CancelToken? _cancelToken;

  @override
  FutureOr<CitiesState> build() async {
    final localCities = _getLocalCities();
    _refreshCitiesInBackground();
    return CitiesState(cities: localCities);
  }

  List<City> _getLocalCities() {
    final box = Hive.box<City>(boxName);
    return box.values.toList();
  }

  Future<void> _refreshCitiesInBackground() async {
    try {
      final remoteCities = await _fetchCitiesFromNetwork();
      
      final box = Hive.box<City>(boxName);
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

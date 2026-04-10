import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/city_state.dart';
import 'package:select_bateau/features/ship/presentation/providers/dio_provider.dart';

class CityNotifier extends AsyncNotifier<CitiesState> {
  CancelToken? cancelToken;

  @override
  FutureOr<CitiesState> build() async {
    final initialCities = await fetchCities();
    return CitiesState(cities: initialCities);
  }

  Future<List<String>> fetchCities() async {
    try {
      cancelToken?.cancel("New filter apply");
      cancelToken = CancelToken();

      final dio = ref.read(dioProvider);
      final response = await dio.get('$baseUrl/city/getAll');

      if (response.statusCode == 200) {
        return List.from(response.data);
      } else {
        throw Exception('Server error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) return [];
      throw Exception('Network error : ${e.message}');
    }
  }
}
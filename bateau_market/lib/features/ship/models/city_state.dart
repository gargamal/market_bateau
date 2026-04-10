import 'package:select_bateau/features/ship/models/city.dart';

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
class CitiesState {
  final List<String> cities;
  final bool isLoadingMore;

  CitiesState({required this.cities, this.isLoadingMore = false});

  CitiesState copyWith({List<String>? cities, bool? isLoadingMore}) {
    return CitiesState(
        cities: cities ?? this.cities,
        isLoadingMore: isLoadingMore ?? this.isLoadingMore);
  }
}
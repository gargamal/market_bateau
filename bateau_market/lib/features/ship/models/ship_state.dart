import 'package:select_bateau/features/ship/models/ship.dart';

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

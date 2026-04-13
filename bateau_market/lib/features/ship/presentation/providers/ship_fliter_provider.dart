import 'package:flutter_riverpod/legacy.dart';

class ShipFiltersState {
  final int? power;
  final String? marketPlace;
  final int? nbPeopleMax;

  ShipFiltersState({this.power, this.marketPlace, this.nbPeopleMax});

  ShipFiltersState copyWith({int? power, String? marketPlace, int? nbPeopleMax}) {
    return ShipFiltersState(
      power: power ?? this.power,
      marketPlace: marketPlace ?? this.marketPlace,
      nbPeopleMax: nbPeopleMax ?? this.nbPeopleMax,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (power != null) 'power': power,
      if (marketPlace != null) 'marketPlace': marketPlace,
      if (nbPeopleMax != null) 'nbPeopleMax': nbPeopleMax,
    };
  }
}

final shipFilterProvider = StateProvider<ShipFiltersState>((ref) => ShipFiltersState());
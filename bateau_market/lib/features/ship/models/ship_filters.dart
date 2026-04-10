class ShipFilters {
  final int? power;
  final String? marketPlace;
  final int? nbPeopleMax;

  ShipFilters({this.power, this.marketPlace, this.nbPeopleMax});

  ShipFilters copyWith({int? power, String? marketPlace, int? nbPeopleMax}) {
    return ShipFilters(
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

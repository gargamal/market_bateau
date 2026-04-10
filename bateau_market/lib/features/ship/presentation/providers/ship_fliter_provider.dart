import 'package:flutter_riverpod/legacy.dart';
import 'package:select_bateau/features/ship/models/ship_filters.dart';

final shipFilterProvider = StateProvider<ShipFilters>((ref) => ShipFilters());
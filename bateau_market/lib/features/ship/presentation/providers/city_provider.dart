import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/features/ship/models/city_state.dart';
import 'package:select_bateau/features/ship/presentation/notifiers/city_notifier.dart';

final cityProvider = AsyncNotifierProvider<CityNotifier, CitiesState>(() {
  return CityNotifier();
});
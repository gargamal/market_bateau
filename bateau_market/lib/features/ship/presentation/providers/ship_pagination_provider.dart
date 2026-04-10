import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/features/ship/models/ship_state.dart';
import 'package:select_bateau/features/ship/presentation/notifiers/ship_pagination_notifier.dart';

final shipPaginationProvider = AsyncNotifierProvider<ShipPaginationNotifier, ShipsState>(() {
  return ShipPaginationNotifier();
});

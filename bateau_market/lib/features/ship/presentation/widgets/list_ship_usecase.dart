import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/theme/provider/theme_provider.dart';
import 'package:select_bateau/core/utils/mock_loader.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_widget.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class WidgetbookShipPaginationNotifier extends ShipPaginationNotifier {
  final ShipsState? initialState;
  final bool isInfiniteLoading;

  WidgetbookShipPaginationNotifier({this.initialState, this.isInfiniteLoading = false});

  @override
  ShipFiltersState getFilters() {
    return ShipFiltersState();
  }

  @override
  FutureOr<ShipsState> build() async {
    if (isInfiniteLoading) {
      return Completer<ShipsState>().future;
    }
    return initialState ?? ShipsState(ships: []);
  }

  @override
  Future<void> loadNextPage() async {
  }
}

class WidgetbookThemeNotifier extends ThemeNotifier {
  WidgetbookThemeNotifier() : super();

  @override
  void loadTheme() {
    state = ThemeMode.light;
  }

  @override
  void toggleTheme() {
    state = state == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
  }
}

@widgetbook.UseCase(
  name: 'Loading State',
  type: ListShipWidget,
)
Widget buildListShipLoading(BuildContext context) {
  return ProviderScope(
    overrides: [
      shipPaginationProvider.overrideWith(() => WidgetbookShipPaginationNotifier(isInfiniteLoading: true)),
      themeProvider.overrideWith((ref) => WidgetbookThemeNotifier()),
      shipFilterProvider.overrideWith((ref) => ShipFiltersState()),
    ],
    child: const ListShipWidget(),
  );
}

@widgetbook.UseCase(
  name: 'Data Loaded (10 ships)',
  type: ListShipWidget,
)
Widget buildListShipData(BuildContext context) {
  // On utilise un FutureBuilder ou on passe par un provider qui charge le JSON
  return FutureBuilder<List<Ship>>(
    future: MockLoader.loadShips(),
    builder: (context, snapshot) {
      if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());

      return ProviderScope(
        overrides: [
          shipPaginationProvider.overrideWith(() => WidgetbookShipPaginationNotifier(
            initialState: ShipsState(
              ships: snapshot.data!,
              currentPage: 1,
              isLoadingMore: false,
            ),
          )),
          themeProvider.overrideWith((ref) => WidgetbookThemeNotifier()),
          shipFilterProvider.overrideWith((ref) => ShipFiltersState()),
        ],
        child: const ListShipWidget(),
      );
    },
  );
}
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/theme/provider/theme_provider.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_widget.dart';

class TestShipPaginationNotifier extends ShipPaginationNotifier {
  final ShipsState initialState;
  TestShipPaginationNotifier(this.initialState);

  @override
  ShipFiltersState getFilters() => ShipFiltersState();

  @override
  Future<ShipsState> build() async => initialState;

  @override
  Future<void> loadNextPage() async {}
}

class TestThemeNotifier extends ThemeNotifier {
  @override
  void loadTheme() { state = ThemeMode.light; }
}

void main() {
  testWidgets('ListShipWidget should display mock ships', (WidgetTester tester) async {
    final mockShips = [
      Ship(
        name: 'Titanic Test',
        power: 1000,
        nbHourOfAutonomy: 10,
        nbPeopleMax: 100,
        marketPlace: 'Brest',
        price: Decimal.parse('500000'),
        lat: 0,
        lng: 0,
      ),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          shipPaginationProvider.overrideWith(() => TestShipPaginationNotifier(
            ShipsState(ships: mockShips),
          )),
          themeProvider.overrideWith((ref) => TestThemeNotifier()),
        ],
        child: const MaterialApp(
          home: ListShipWidget(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Titanic Test'), findsOneWidget);
    expect(find.text('Brest'), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_notifier.dart';
import 'package:select_bateau/features/ship/presentation/widgets/one_ship_widget.dart';

class ShipListInfiniteScrollWidget extends ConsumerStatefulWidget {
  const ShipListInfiniteScrollWidget({super.key});

  @override
  ConsumerState<ShipListInfiniteScrollWidget> createState() => _ShipListInfiniteScrollScreen();
}

class _ShipListInfiniteScrollScreen extends ConsumerState<ShipListInfiniteScrollWidget> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {
      // Si on arrive à 90% du bas de la liste, on charge la suite
      if (scrollController.position.pixels >= scrollController.position.maxScrollExtent * limitShipsRefresh) {
        ref.read(shipPaginationProvider.notifier).loadNextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(shipPaginationProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Mes beaux bateaux")),
      body: asyncState.when(
        data: (state) => ListView.builder(
          controller: scrollController,
          itemCount: state.ships.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < state.ships.length) {
              final ship = state.ships[index];
              return OneShipWidget(ship: ship);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
    );
  }
}

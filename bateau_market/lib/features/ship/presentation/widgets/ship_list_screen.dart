import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_notifier.dart';

class ShipListInfiniteScrollScreen extends ConsumerStatefulWidget {
  const ShipListInfiniteScrollScreen({super.key});

  @override
  ConsumerState<ShipListInfiniteScrollScreen> createState() => _ShipListInfiniteScrollScreen();
}

class _ShipListInfiniteScrollScreen extends ConsumerState<ShipListInfiniteScrollScreen> {
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
              return ListTile(
                  leading: CircleAvatar(child: Text(ship.name.substring(0, 1).toUpperCase() + ship.name.substring(1, 2).toLowerCase())),
                  title: Text(ship.name),
                  subtitle: Text(ship.price.toString()));
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

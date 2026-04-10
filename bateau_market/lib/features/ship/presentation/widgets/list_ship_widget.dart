import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_provider.dart';
import 'package:select_bateau/features/ship/presentation/widgets/filter_ship_widget.dart';
import 'package:select_bateau/features/ship/presentation/widgets/ship_widget.dart';

class ListShipInfiniteScrollWidget extends ConsumerStatefulWidget {
  const ListShipInfiniteScrollWidget({super.key});

  @override
  ConsumerState<ListShipInfiniteScrollWidget> createState() => ListShipInfiniteScrollScreen();
}

class ListShipInfiniteScrollScreen extends ConsumerState<ListShipInfiniteScrollWidget> {
  bool onFirstPageIsVisible = false;
  final ScrollController scrollController = ScrollController();
  final FilterShip showFilterDialog = FilterShip();

  void onFirstPage() {
    scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    scrollController.addListener(onScroll);
  }

  void onScroll() {
    final notifier = ref.read(shipPaginationProvider.notifier);

    final threshold = scrollController.position.maxScrollExtent * limitShipsRefresh;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= threshold) {
      notifier.loadNextPage();
    }

    final showButton = scrollController.offset > 200;
    if (showButton != onFirstPageIsVisible) {
      setState(() => onFirstPageIsVisible = showButton);
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(onScroll);
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final asyncState = ref.watch(shipPaginationProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Mes beaux bateaux"),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () => showFilterDialog.show(context, ref),
          ),
        ],
      ),
      body: asyncState.when(
        data: (state) => ListView.builder(
          controller: scrollController,
          itemCount: state.ships.length + (state.isLoadingMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < state.ships.length) {
              final ship = state.ships[index];
              return ShipWidget(ship: ship);
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      floatingActionButton: !onFirstPageIsVisible ? null : FloatingActionButton(
        onPressed: onFirstPage,
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}

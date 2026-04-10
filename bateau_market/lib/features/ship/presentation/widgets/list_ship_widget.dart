import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_pagination_provider.dart';
import 'package:select_bateau/features/ship/presentation/widgets/filter_ship_widget.dart';
import 'package:select_bateau/features/ship/presentation/widgets/ship_widget.dart';

class ListShipInfiniteScrollWidget extends ConsumerStatefulWidget {
  const ListShipInfiniteScrollWidget({super.key});

  @override
  ConsumerState<ListShipInfiniteScrollWidget> createState() => _ListShipInfiniteScrollScreen();
}

class _ListShipInfiniteScrollScreen extends ConsumerState<ListShipInfiniteScrollWidget> {
  bool _onFirstPageIsVisible = false;
  final ScrollController _scrollController = ScrollController();
  final FilterShipWidget _showFilterDialog = FilterShipWidget();

  void _onFirstPage() {
    _scrollController.animateTo(
      0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final notifier = ref.read(shipPaginationProvider.notifier);

    final threshold = _scrollController.position.maxScrollExtent * limitShipsRefresh;
    final currentScroll = _scrollController.position.pixels;

    if (currentScroll >= threshold) {
      notifier.loadNextPage();
    }

    final showButton = _scrollController.offset > 200;
    if (showButton != _onFirstPageIsVisible) {
      setState(() => _onFirstPageIsVisible = showButton);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
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
            onPressed: () => _showFilterDialog.show(context, ref),
          ),
        ],
      ),
      body: asyncState.when(
        data: (state) => ListView.builder(
          controller: _scrollController,
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
      floatingActionButton: !_onFirstPageIsVisible ? null : FloatingActionButton(
        onPressed: _onFirstPage,
        child: Icon(Icons.arrow_upward),
      ),
    );
  }
}

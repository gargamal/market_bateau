import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/city.dart';
import 'package:select_bateau/features/ship/models/ship_filters.dart';
import 'package:select_bateau/features/ship/presentation/providers/city_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';

class FilterShipWidget {
  void show(BuildContext context, WidgetRef ref) {
    ref.invalidate(cityProvider);

    showDialog(
      context: context,
      builder: (context) => const _FilterDialogContent(),
    );
  }
}

class _FilterDialogContent extends ConsumerStatefulWidget {
  const _FilterDialogContent();

  @override
  ConsumerState<_FilterDialogContent> createState() => FilterDialogContentState();
}

class FilterDialogContentState extends ConsumerState<_FilterDialogContent> {
  Timer? _debounce;
  double? _localPower;
  String? _localMarketPlace;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cityState = ref.watch(cityProvider);
    final shipFilterState = ref.watch(shipFilterProvider);

    _localPower ??= (shipFilterState.power ?? 0).toDouble();
    _localMarketPlace ??= shipFilterState.marketPlace;

    final colorScheme = Theme.of(context).colorScheme;

    return AlertDialog(
      title: Center(
        child: Text(
          "Find your ship",
          style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.primary, fontSize: 22),
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filtrer par puissance
          Text("Max Power : ${_localPower!.toInt()}"),
          Slider(
            value: _localPower!,
            max: 10000,
            activeColor: colorScheme.primary,
            inactiveColor: colorScheme.primary.withValues(alpha: 0.3),
            onChanged: (val) {
              setState(() => _localPower = val);
              debouncing(() {
                ref.read(shipFilterProvider.notifier).update((state) => state.copyWith(power: val.toInt())
                );
              });
            },
          ),
          // Marketplace
          cityState.when(
              data: (state) =>
                  DropdownButton<String>(
                      value: _localMarketPlace,
                      hint: const Text("Choose the city"),
                      items: state.cities.map((City value) {
                        return DropdownMenuItem(value: value.name, child: Text(value.name));
                      }).toList(),
                      onChanged: (val) {
                        setState(() => _localMarketPlace = val);
                        debouncing(() {
                          ref.read(shipFilterProvider.notifier).update((state) => state.copyWith(marketPlace: val)
                          );
                        });
                      }),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Erreur: $err'))
          )
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            ref.read(shipFilterProvider.notifier).state = ShipFilters();
            Navigator.pop(context);
          },
          child: Text(
            "Reinitialize",
            style: TextStyle(fontWeight: FontWeight.bold, color: colorScheme.secondary, fontSize: 14),
          ),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: colorScheme.primaryContainer,
            foregroundColor: colorScheme.onPrimaryContainer,
          ),
          child: const Text(
            "Apply",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
        ),
      ],
    );
  }

  void debouncing(void Function() callback) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: lapTimeCallBackend), callback);
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/ship_filters.dart';
import 'package:select_bateau/features/ship/presentation/providers/city_provider.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter_provider.dart';

class FilterShip {
  void show(BuildContext context, WidgetRef ref) {
    ref.invalidate(cityProvider);

    showDialog(
      context: context,
      builder: (context) => const FilterDialogContent(),
    );
  }
}

class FilterDialogContent extends ConsumerStatefulWidget {
  const FilterDialogContent({super.key});

  @override
  ConsumerState<FilterDialogContent> createState() => FilterDialogContentState();
}

class FilterDialogContentState extends ConsumerState<FilterDialogContent> {
  Timer? debounce;
  double? localPower;
  String? localMarketPlace;

  @override
  void dispose() {
    debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cityState = ref.watch(cityProvider);
    final shipFilterState = ref.watch(shipFilterProvider);

    localPower ??= (shipFilterState.power ?? 0).toDouble();
    localMarketPlace ??= shipFilterState.marketPlace;

    return AlertDialog(
      title: const Center(
        child: Text(
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 22),
          "Find your ship"
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Filtrer par puissance
          Text("Max Power : ${localPower!.toInt()}"),
          Slider(
            value: localPower!,
            max: 10000,
            onChanged: (val) {
              setState(() => localPower = val);
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
                      value: localMarketPlace,
                      hint: const Text("Choose the city"),
                      items: state.cities.map((String value) {
                        return DropdownMenuItem(value: value, child: Text(value));
                      }).toList(),
                      onChanged: (val) {
                        setState(() => localMarketPlace = val);
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
          child: const Text("Reinitialize", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue, fontSize: 14)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Apply", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 18)),
        ),
      ],
    );
  }

  void debouncing(void Function() callback) {
    if (debounce?.isActive ?? false) debounce!.cancel();
    debounce = Timer(const Duration(milliseconds: lapTimeCallBackend), callback);
  }
}
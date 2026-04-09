import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/features/ship/presentation/providers/ship_fliter.dart';

class FilterShip {
  void show(BuildContext context, ShipFilters filters) {
    showDialog(
      context: context,
      builder: (context) {
        return Consumer(
          builder: (context, ref, child) {
            final currentFilters = ref.watch(shipFilterProvider);

            return AlertDialog(
              title: Center(
                child: Text(
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent, fontSize: 22),
                  "Find your ship",
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Filtrer par puissance
                  Text("Max Power : ${currentFilters.power ?? 0}"),
                  Slider(
                    value: (currentFilters.power ?? 0).toDouble(),
                    max: 10000,
                    onChanged: (val) {
                      ref.read(shipFilterProvider.notifier).update((state) => state.copyWith(power: val.toInt()));
                    },
                  ),
                  // Marketplace
                  DropdownButton<String>(
                    value: currentFilters.marketPlace,
                    hint: const Text("Choose the city"),
                    items: ["Marseille", "Calais", "Brest"].map((String value) {
                      return DropdownMenuItem(value: value, child: Text(value));
                    }).toList(),
                    onChanged: (val) {
                      ref.read(shipFilterProvider.notifier).update((state) => state.copyWith(marketPlace: val));
                    },
                  ),
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
          },
        );
      },
    );
  }
}
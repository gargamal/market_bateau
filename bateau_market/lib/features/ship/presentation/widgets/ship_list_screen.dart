import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/ships_provider.dart';

class ShipListScreen extends ConsumerWidget {
  const ShipListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // On observe le FutureProvider
    final asyncUsers = ref.watch(shipsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Nom bateau')),
      body: asyncUsers.when(
        // État : Données prêtes
        data: (users) => ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => ListTile(title: Text(users[index])),
        ),
        // État : Chargement en cours
        loading: () => const Center(child: CircularProgressIndicator()),
        // État : Une erreur est survenue
        error: (err, stack) => Center(child: Text('Erreur: $err')),
      ),
      floatingActionButton: FloatingActionButton(
        // Bonus : Pour rafraîchir les données manuellement
        onPressed: () => ref.refresh(shipsProvider),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
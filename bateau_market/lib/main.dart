import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/features/ship/presentation/widgets/ship_list_screen.dart';

void main() {
  runApp(const ProviderScope(child: SelectBateau()));
}

class SelectBateau extends StatelessWidget {
  const SelectBateau({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Une application bateau',
        debugShowCheckedModeBanner: false,
        home: ShipListScreen()
    );
  }
}

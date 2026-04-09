import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_widget.dart';

void main() {
  runApp(const ProviderScope(child: SelectBateau()));
}

class SelectBateau extends StatelessWidget {
  const SelectBateau({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();

    return MaterialApp(
        title: 'Une application bateau',
        debugShowCheckedModeBanner: false,
        home: ListShipInfiniteScrollWidget()
    );
  }
}

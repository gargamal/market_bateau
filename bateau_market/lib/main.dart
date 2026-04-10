import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:select_bateau/core/data/adapter/decimal_adapter.dart';
import 'package:select_bateau/features/ship/models/city.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/notifiers/city_notifier.dart';
import 'package:select_bateau/features/ship/presentation/notifiers/ship_pagination_notifier.dart';
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_widget.dart';
import 'package:select_bateau/hive_registrar.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DecimalAdapter());
  Hive.registerAdapters();

  await Hive.openBox<Ship>(ShipPaginationNotifier.boxName);
  await Hive.openBox<City>(CityNotifier.boxName);

  runApp(const ProviderScope(child: SelectBateau()));
}

class SelectBateau extends StatelessWidget {
  const SelectBateau({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Une application bateau',
        debugShowCheckedModeBanner: false,
        home: ListShipInfiniteScrollWidget()
    );
  }
}

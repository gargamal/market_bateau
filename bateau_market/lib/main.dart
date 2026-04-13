import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:select_bateau/core/data/adapter/decimal_adapter.dart';
import 'package:select_bateau/core/theme/provider/theme_provider.dart';
import 'package:select_bateau/core/utils/constants.dart';
import 'package:select_bateau/features/ship/models/city.dart';
import 'package:select_bateau/features/ship/models/ship.dart';
import 'package:select_bateau/features/ship/presentation/widgets/list_ship_widget.dart';
import 'package:select_bateau/hive_registrar.g.dart';
import 'package:select_bateau/core/theme/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  Hive.registerAdapter(DecimalAdapter());
  Hive.registerAdapters();

  await Hive.openBox<Ship>(shipsBoxName);
  await Hive.openBox<City>(citiesBoxName);
  await Hive.openBox(settingsBoxName);

  runApp(const ProviderScope(child: SelectBateau()));
}
class SelectBateau extends ConsumerWidget {
  const SelectBateau({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'Une application bateau',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: const ListShipInfiniteScrollWidget(),
    );
  }
}

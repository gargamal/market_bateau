import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const boxName = 'settings_box';
  static const _key = 'isDarkMode';

  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  void _loadTheme() {
    final box = Hive.box(boxName);
    final isDark = box.get(_key);
    if (isDark != null) {
      state = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    final box = Hive.box(boxName);
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      box.put(_key, false);
    } else {
      state = ThemeMode.dark;
      box.put(_key, true);
    }
  }
}

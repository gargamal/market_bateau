import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:select_bateau/core/utils/constants.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  static const _key = 'isDarkMode';

  ThemeNotifier() : super(ThemeMode.system) {
    loadTheme();
  }

  void loadTheme() {
    final box = Hive.box(settingsBoxName);
    final isDark = box.get(_key);
    if (isDark != null) {
      state = isDark ? ThemeMode.dark : ThemeMode.light;
    }
  }

  void toggleTheme() {
    final box = Hive.box(settingsBoxName);
    if (state == ThemeMode.dark) {
      state = ThemeMode.light;
      box.put(_key, false);
    } else {
      state = ThemeMode.dark;
      box.put(_key, true);
    }
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});

import 'package:flutter/material.dart';

class AppTheme {
  // --- Light ---
  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF083360), // origin color
      brightness: Brightness.light,
      primary: const Color(0xFF083360),
      onPrimary: Colors.white,
      secondary: const Color(0xFF263D5E),
      // backcolor on card (ShipWidget)
      surfaceContainerHigh: const Color(0xFFF1F5F9), 
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF083360),
      foregroundColor: Colors.white,
      centerTitle: true,
      elevation: 2,
    ),
  );

  // --- Dark ---
  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF083360),
      brightness: Brightness.dark,
      primary: const Color(0xFF60A5FA),
      secondary: const Color(0xFFC4D3E8),
      // backcolor on card (ShipWidget)
      surfaceContainerHigh: const Color(0xFF1E293B),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0F172A),
      foregroundColor: Colors.white,
      centerTitle: true,
    ),
  );
}

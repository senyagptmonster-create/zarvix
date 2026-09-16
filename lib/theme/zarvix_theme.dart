import 'package:flutter/material.dart';

class ZarvixTheme {
  static const bg = Color(0xFF0D0E13);
  static const surface = Color(0xFF151720);
  static const edge = Color(0xFF212431);
  static const accent = Color(0xFFA855F7);
  static const accentLight = Color(0xFFC084FC);
  static const ink = Color(0xFFFAF5FF);
  static const muted = Color(0xFF948D9E);

  static ThemeData get themeData {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: bg,
      fontFamily: 'AppFont',
      primaryColor: accent,
      colorScheme: const ColorScheme.dark(
        primary: accent,
        surface: surface,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: bg,
        elevation: 0,
        foregroundColor: ink,
      ),
      cardTheme: CardThemeData(
        color: surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: edge, width: 1.5),
        ),
      ),
    );
  }
}

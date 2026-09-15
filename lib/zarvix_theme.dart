import 'package:flutter/material.dart';

class ZarvixTheme {
  static const Color darkParchment = Color(0xFF161513);
  static const Color cardSurface = Color(0xFF24221F);
  static const Color amberAccent = Color(0xFFD4A373);
  static const Color creamText = Color(0xFFFAEDCD);
  static const Color borderSubtle = Color(0xFF383531);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'AppFont',
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkParchment,
      colorScheme: const ColorScheme.dark(
        primary: amberAccent,
        surface: cardSurface,
        onSurface: creamText,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkParchment,
        foregroundColor: creamText,
        elevation: 0,
      ),
    );
  }
}

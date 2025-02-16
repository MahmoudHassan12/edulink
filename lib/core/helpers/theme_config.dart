import 'package:flutter/material.dart'
    show Brightness, Color, ColorScheme, Colors, ThemeData;

class ThemeConfig {
  const ThemeConfig();
  ThemeData _themeData({
    Color? surface,
    Brightness brightness = Brightness.light,
  }) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      surface: surface,
      seedColor: Colors.blue,
      brightness: brightness,
    ),
  );
  ThemeData get lightTheme => _themeData(surface: Colors.white);
  ThemeData get darkTheme =>
      _themeData(surface: Colors.black, brightness: Brightness.dark);
}

import 'package:flutter/material.dart'
    show
        AppBarTheme,
        Brightness,
        Color,
        ColorScheme,
        Colors,
        DynamicSchemeVariant,
        ThemeData;

class ThemeConfig {
  const ThemeConfig();
  ThemeData _themeData({
    Color? surface,
    Brightness brightness = Brightness.light,
  }) => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.blueGrey,
      brightness: brightness,
      dynamicSchemeVariant: DynamicSchemeVariant.content, // content, fidelity
      surface: surface,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
    ),
  );
  ThemeData get lightTheme => _themeData(surface: Colors.white);
  ThemeData get darkTheme =>
      _themeData(brightness: Brightness.dark, surface: Colors.black);
}

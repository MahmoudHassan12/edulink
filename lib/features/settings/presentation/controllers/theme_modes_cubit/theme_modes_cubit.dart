import 'dart:async' show unawaited;

import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:flutter/material.dart'
    show Colors, MaterialColor, ThemeMode, immutable;
import 'package:flutter_bloc/flutter_bloc.dart' show Cubit;
part 'theme_modes_state.dart';

final class ThemeModesCubit extends Cubit<ThemeMode> {
  ThemeModesCubit() : super(ThemeMode.system) {
    unawaited(_init);
  }
  final String kThemeMode = 'theme_mode';
  Future<void> get _init => _getThemeFromPreferences().then(emit);
  Future<ThemeMode> _getThemeFromPreferences() async =>
      _themeModeFromString(SharedPrefSingleton.getString(kThemeMode));
  ThemeMode _themeModeFromString(final String themeModeString) =>
      ThemeMode.values.firstWhere(
        (final ThemeMode themeMode) => themeMode.toString() == themeModeString,
        orElse: () => ThemeMode.system,
      );
  Future<void> _saveThemeToPreferences(final ThemeMode themeMode) =>
      SharedPrefSingleton.setString(kThemeMode, themeMode.toString());
  Future<void> setLightTheme() {
    emit(ThemeMode.light);
    return _saveThemeToPreferences(ThemeMode.light);
  }

  Future<void> setDarkTheme() {
    emit(ThemeMode.dark);
    return _saveThemeToPreferences(ThemeMode.dark);
  }

  Future<void> setSystemTheme() {
    emit(ThemeMode.system);
    return _saveThemeToPreferences(ThemeMode.system);
  }
}

final class SeedColorsCubit extends Cubit<SeedColorsState> {
  SeedColorsCubit() : super(_SeedColorsInitial()) {
    unawaited(_initialize());
  }

  Future<void> _initialize() async {
    emit(_init);
  }

  static const List<MaterialColor> _primaryColors = Colors.primaries;
  final String _kSeedColors = 'seed_colors';
  final String _kIsAmoled = 'is_amoled';
  final String _kIsAppleDevice = 'is_apple_device';
  static final MaterialColor defaultColor = _primaryColors[3];
  SeedColorsState get _init => SeedColorsState(
    color: _getColorFromPreferences,
    isAmoledSelected: _getContrastFromPreferences,
    isAppleDevice: _getAppleFromPreferences,
  );

  MaterialColor? get _getColorFromPreferences => _parseColor(
    _primaryColors.firstWhere(
      (color) =>
          color.toString() == SharedPrefSingleton.getString(_kSeedColors),
      orElse: () => defaultColor,
    ),
  );

  bool get _getContrastFromPreferences =>
      SharedPrefSingleton.getBool(_kIsAmoled);
  bool get _getAppleFromPreferences =>
      SharedPrefSingleton.getBool(_kIsAppleDevice);
  MaterialColor? _parseColor(final MaterialColor? color) =>
      _primaryColors.firstWhere(
        (final MaterialColor e) => e == color,
        orElse: () => defaultColor,
      );

  Future<void> _saveColorToPreferences(final MaterialColor color) =>
      SharedPrefSingleton.setString(
        _kSeedColors,
        _primaryColors
            .firstWhere((final e) => e == color, orElse: () => defaultColor)
            .toString(),
      );
  Future<void> setColor(final MaterialColor color) {
    emit(state.setColor(color));
    return _saveColorToPreferences(color);
  }

  bool isColorSelected(final MaterialColor color) => state.color == color;

  Future<bool> toggleAmoled({required final bool value}) {
    emit(state.toggleAmoled(value: value));
    return SharedPrefSingleton.setBool(_kIsAmoled, value: value);
  }

  Future<bool> toggleAppleDevice({required final bool value}) {
    emit(state.toggleAppleDevice(value: value));
    return SharedPrefSingleton.setBool(_kIsAppleDevice, value: value);
  }
}

import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show
        AppBarTheme,
        Brightness,
        ColorScheme,
        Colors,
        DynamicSchemeVariant,
        TextTheme,
        ThemeData,
        ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart';

// class ThemeConfig {
//   const ThemeConfig(this.context);
//   final BuildContext context;
//   ThemeData _themeData({
//     Color? surface,
//     Brightness brightness = Brightness.light,
//   }) => ThemeData(
//     colorScheme: ColorScheme.fromSeed(
//     seedColor: context.watch<SeedColorsCubit>().state.color ?? Colors.purple,
//       brightness: brightness,
//       dynamicSchemeVariant: DynamicSchemeVariant.vibrant, // content, fidelity
//       surface: surface,
//     ),
//     appBarTheme: AppBarTheme(
//       backgroundColor: surface,
//       elevation: 0,
//       surfaceTintColor: Colors.transparent,
//     ),
//   );
//   ThemeData get lightTheme => _themeData(surface: Colors.white);
//   ThemeData get darkTheme =>
//       _themeData(brightness: Brightness.dark, surface: Colors.black);
// }

final class ThemeConfig {
  const ThemeConfig(this._context);
  final BuildContext _context;
  ThemeData? get light => _themeData();
  ThemeData? get dark => _themeData(Brightness.dark);
  ThemeMode? get mode => _context.watch<ThemeModesCubit>().state;
  ThemeData? _themeData([final Brightness brightness = Brightness.light]) {
    final SeedColorsState state = _context.watch<SeedColorsCubit>().state;
    final bool isAppleDevice = state.isAppleDevice ?? false;
    final CupertinoTextThemeData textTheme =
        const CupertinoThemeData().textTheme;
    final TextStyle navLargeTitleTextStyle = textTheme.navLargeTitleTextStyle;
    final TextStyle navTitleTextStyle = textTheme.navTitleTextStyle;
    return ThemeData(
      platform: isAppleDevice ? TargetPlatform.iOS : null,
      colorScheme: ColorScheme.fromSeed(
        seedColor: state.color!,
        brightness: brightness,
        dynamicSchemeVariant: DynamicSchemeVariant.content,
        surface: (state.isAmoledSelected ?? false)
            ? brightness == Brightness.dark
                  ? Colors.black
                  : Colors.white
            : null,
      ),

      appBarTheme: isAppleDevice
          ? const AppBarTheme(
              shadowColor: CupertinoColors.darkBackgroundGray,
              surfaceTintColor: Colors.transparent,
              scrolledUnderElevation: .1,
              toolbarHeight: 44,
            )
          : null,
      textTheme: isAppleDevice
          ? TextTheme(
              headlineMedium: navLargeTitleTextStyle.copyWith(
                letterSpacing: -1.5,
              ),
              titleLarge: navTitleTextStyle.copyWith(),
            )
          : null,
    );
  }
}

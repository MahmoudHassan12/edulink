import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart'
    show ThemeModesCubit;
import 'package:edu_link/features/settings/presentation/view/widgets/theme/switch_theme_list_tile.dart'
    show SwitchThemeListTile;
import 'package:flutter/material.dart'
    show
        AnimatedCrossFade,
        Brightness,
        BuildContext,
        CrossFadeState,
        Icons,
        StatelessWidget,
        Theme,
        ThemeMode;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;

final class SwitchThemeMode extends StatelessWidget {
  const SwitchThemeMode({super.key});
  @override
  AnimatedCrossFade build(final BuildContext context) {
    final ThemeModesCubit cubit = context.read<ThemeModesCubit>();
    return AnimatedCrossFade(
      firstChild: SwitchThemeListTile(
        icon: Icons.light_mode_outlined,
        title: 'Switch to Light Mode',
        onTap: cubit.setLightTheme,
      ),
      secondChild: SwitchThemeListTile(
        icon: Icons.dark_mode_outlined,
        title: 'Switch to Dark Mode',
        onTap: cubit.setDarkTheme,
      ),
      crossFadeState:
          context.watch<ThemeModesCubit>().state == ThemeMode.light ||
              Theme.of(context).brightness == Brightness.light
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 300),
    );
  }
}

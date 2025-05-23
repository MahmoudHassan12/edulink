import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart'
    show SeedColorsCubit, ThemeModesCubit;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Builder,
        Icon,
        IconData,
        ListTile,
        StatelessWidget,
        TextButton,
        ThemeMode,
        VoidCallback;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;

final class SwitchThemeListTile extends StatelessWidget {
  const SwitchThemeListTile({
    required this.icon,
    required this.title,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String title;
  final VoidCallback onTap;
  @override
  ListTile build(final BuildContext context) {
    final bool isAppleDevice =
        context.read<SeedColorsCubit>().state.isAppleDevice ?? false;
    return ListTile(
      leading: Icon(icon),
      title: EText(title),
      onTap: onTap,
      enabled: !isAppleDevice,
      trailing: Builder(
        builder: (final BuildContext context) => TextButton(
          onPressed:
              context.watch<ThemeModesCubit>().state == ThemeMode.system ||
                  isAppleDevice
              ? null
              : context.read<ThemeModesCubit>().setSystemTheme,
          child: const EText('Default'),
        ),
      ),
    );
  }
}

import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart';
import 'package:edu_link/features/settings/presentation/view/widgets/theme/seed_color_carousel_view.dart'
    show SeedColorCarouselView;
import 'package:edu_link/features/settings/presentation/view/widgets/theme/seed_color_theme.dart'
    show SeedColorTheme;
import 'package:edu_link/features/settings/presentation/view/widgets/theme/switch_theme_mode.dart'
    show SwitchThemeMode;
import 'package:flutter/cupertino.dart' show MediaQuery, showCupertinoSheet;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Builder,
        Colors,
        EdgeInsets,
        Icon,
        Icons,
        ListBody,
        ListTile,
        MaterialColor,
        Padding,
        Scaffold,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        SwitchListTile,
        TextButton,
        Widget,
        Wrap,
        WrapCrossAlignment;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocBuilder, ReadContext, WatchContext;

final class ThemeManager extends StatelessWidget {
  const ThemeManager({super.key});
  @override
  Widget build(final BuildContext context) =>
      BlocBuilder<SeedColorsCubit, SeedColorsState>(
        builder: (context, state) {
          final SeedColorsCubit cubit = context.read<SeedColorsCubit>();
          final MaterialColor defaultColor = SeedColorsCubit.defaultColor;
          return ListBody(
            children: <Widget>[
              ListTile(
                title: const EText('Theme'),
                trailing: Builder(
                  builder: (final BuildContext context) => TextButton(
                    onPressed:
                        context.watch<SeedColorsCubit>().state.color ==
                            defaultColor
                        ? null
                        : () async {
                            await cubit.setColor(defaultColor);
                          },
                    child: const EText('Default'),
                  ),
                ),
              ),
              const SeedColorCarouselView(),
              const SizedBox(height: 8),
              ListTile(
                title: const EText('Color theme'),
                trailing: Icon(Icons.adaptive.arrow_forward_rounded),
                onTap: () async {
                  await showCupertinoSheet<SingleChildScrollView>(
                    context: context,
                    pageBuilder: (_) {
                      const double spacing = 16;
                      return Scaffold(
                        body: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(spacing * 1.5),
                            child: Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: spacing * 1.5,
                              runSpacing: spacing * 1.5,
                              children: Colors.primaries.map((
                                final MaterialColor color,
                              ) {
                                final double width =
                                    MediaQuery.sizeOf(context).width / 3 -
                                    2 * spacing;
                                return SizedBox(
                                  width: width,
                                  height: width,
                                  child: SeedColorTheme(
                                    color: color,
                                    isSelected: cubit.isColorSelected(color),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile.adaptive(
                title: const EText('High Contrast Mode'),
                value: state.isAmoledSelected ?? false,
                onChanged: (final bool value) async {
                  await cubit.toggleAmoled(value: value);
                },
              ),
              const SizedBox(height: 8),
              SwitchListTile.adaptive(
                title: const EText('Change to Cupertino Theme'),
                value: state.isAppleDevice ?? false,
                onChanged: (final bool value) async {
                  await context.read<ThemeModesCubit>().setLightTheme();
                  await cubit.toggleAppleDevice(value: value);
                },
              ),
              const SizedBox(height: 8),
              const SwitchThemeMode(),
            ],
          );
        },
      );
}

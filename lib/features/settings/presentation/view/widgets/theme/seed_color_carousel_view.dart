import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart'
    show SeedColorsCubit;
import 'package:edu_link/features/settings/presentation/view/widgets/theme/seed_color_theme.dart'
    show SeedColorTheme;
import 'package:flutter/material.dart'
    show
        BuildContext,
        CarouselController,
        CarouselView,
        CircleBorder,
        Colors,
        MaterialColor,
        MediaQuery,
        SizedBox,
        StatelessWidget;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext, WatchContext;

final class SeedColorCarouselView extends StatelessWidget {
  const SeedColorCarouselView({super.key});
  @override
  SizedBox build(final BuildContext context) => SizedBox(
    height: MediaQuery.sizeOf(context).width * 0.3,
    child: CarouselView.weighted(
      controller: CarouselController(
        initialItem: Colors.primaries.indexOf(
          context.watch<SeedColorsCubit>().state.color ??
              SeedColorsCubit.defaultColor,
        ),
      ),
      itemSnapping: true,
      shape: const CircleBorder(),
      flexWeights: const <int>[2, 6, 6, 9, 6, 6, 2],
      enableSplash: false,
      children: List<SeedColorTheme>.generate(Colors.primaries.length, (
        final int index,
      ) {
        final MaterialColor color = Colors.primaries[index];
        return SeedColorTheme(
          color: color,
          isSelected: context.read<SeedColorsCubit>().isColorSelected(color),
        );
      }),
    ),
  );
}

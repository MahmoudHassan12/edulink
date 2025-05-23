import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart'
    show SeedColorsCubit;
import 'package:flutter/material.dart'
    show
        BoxDecoration,
        BoxShape,
        BuildContext,
        Color,
        Colors,
        DecoratedBox,
        GestureDetector,
        Icon,
        Icons,
        MaterialColor,
        RadialGradient,
        StatelessWidget;
import 'package:flutter_bloc/flutter_bloc.dart' show ReadContext;

final class SeedColorTheme extends StatelessWidget {
  const SeedColorTheme({
    required this.color,
    this.isSelected = false,
    super.key,
  });
  final MaterialColor color;
  final bool isSelected;
  @override
  GestureDetector build(final BuildContext context) => GestureDetector(
    onTap: () async {
      await context.read<SeedColorsCubit>().setColor(color);
    },
    child: DecoratedBox(
      decoration: BoxDecoration(
        gradient: isSelected
            ? RadialGradient(
                colors: <Color>[
                  color,
                  Colors.transparent,
                  Colors.transparent,
                  color,
                ],
                stops: const <double>[0.82, 0, 0.92, 0.92],
              )
            : null,
        color: isSelected ? null : color,
        shape: BoxShape.circle,
      ),
      child: isSelected
          ? const Icon(Icons.check_rounded, color: Colors.white, size: 32)
          : null,
    ),
  );
}

import 'package:edu_link/features/profile/presentation/views/widgets/first_panal.dart';
import 'package:flutter/material.dart';

class FirstPanalWithDecoration extends StatelessWidget {
  const FirstPanalWithDecoration({super.key});

  @override
  Widget build(BuildContext context) => SliverToBoxAdapter(
    child: Stack(
      fit: StackFit.passthrough,
      children: [
        SizedBox(
          height: 240,
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(40),
              ),
            ),
          ),
        ),
        const Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 32),
            child: Column(children: [SizedBox(height: 160), FirstPanal()]),
          ),
        ),
      ],
    ),
  );
}

import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/first_panal.dart';
import 'package:flutter/material.dart';

class FirstPanalWithDecoration extends StatelessWidget {
  const FirstPanalWithDecoration({required this.user, super.key});
  final UserEntity user;
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
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [const SizedBox(height: 160), FirstPanal(user: user)],
            ),
          ),
        ),
      ],
    ),
  );
}

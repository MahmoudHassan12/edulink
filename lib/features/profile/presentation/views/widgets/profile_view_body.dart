import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/first_panal.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/second_panal.dart';
import 'package:flutter/material.dart';

class ProfileViewBody extends StatelessWidget {
  const ProfileViewBody({super.key});
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      SliverToBoxAdapter(
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
      ),
      SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        sliver: SliverList.list(
          children: const [
            ListTile(
              minVerticalPadding: 0,
              contentPadding: EdgeInsets.zero,
              title: EText(
                'Contact Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SecondPanal(),
          ],
        ),
      ),
    ],
  );
}

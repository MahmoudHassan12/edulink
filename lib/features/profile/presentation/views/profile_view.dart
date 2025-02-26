import 'package:edu_link/core/widgets/e_text.dart' show EText;
import 'package:edu_link/features/profile/presentation/views/widgets/profile_view_body.dart'
    show ProfileViewBody;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  @override
  Scaffold build(BuildContext context) => Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      leading: BackButton(color: Theme.of(context).colorScheme.onPrimary),
      title: EText(
        'Profile',
        style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
      ),
      centerTitle: true,
      forceMaterialTransparency: true,
      elevation: 0,
      actions: [
        IconButton(
          icon: const Icon(Icons.edit_rounded),
          onPressed: () {},
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        const SizedBox(width: 8),
      ],
    ),
    body: const ProfileViewBody(),
    bottomNavigationBar: BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(FontAwesomeIcons.linkedinIn),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.facebookF),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(FontAwesomeIcons.github),
            onPressed: () {},
          ),
        ],
      ),
    ),
  );
}

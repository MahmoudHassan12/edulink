import 'dart:developer';

import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBottomAppBar extends StatelessWidget {
  const ProfileBottomAppBar({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => BottomAppBar(
    color: Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(FontAwesomeIcons.linkedinIn),
          onPressed: () async {
            await _launchUrl('https://www.linkedin.com/');
          },
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.facebookF),
          onPressed: () async {
            await _launchUrl('https://www.facebook.com/');
          },
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.github),
          onPressed: () async {
            await _launchUrl('https://www.github.com/');
          },
        ),
      ],
    ),
  );
}

Future<void> _launchUrl(url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    log('Url Lanched');
    await launchUrl(uri);
  } else {
    log("Can't Launch URL");
  }
}

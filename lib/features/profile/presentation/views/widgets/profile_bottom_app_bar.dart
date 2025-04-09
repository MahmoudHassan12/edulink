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
          onPressed: () async => _launchUrl('https://www.linkedin.com/'),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.facebookF),
          onPressed: () async => _launchUrl('https://www.facebook.com/'),
        ),
        IconButton(
          icon: const Icon(FontAwesomeIcons.github),
          onPressed: () async => _launchUrl('https://www.github.com/'),
        ),
      ],
    ),
  );
}

Future<void> _launchUrl(String url) {
  final uri = Uri.parse(url);
  return canLaunchUrl(uri).then(
    (canLaunch) =>
        canLaunch
            ? launchUrl(
              uri,
              mode: LaunchMode.externalNonBrowserApplication,
              webOnlyWindowName: '_blank',
              webViewConfiguration: const WebViewConfiguration(
                headers: <String, String>{'my_header_key': 'my_header_value'},
              ),
              browserConfiguration: const BrowserConfiguration(showTitle: true),
            )
            : null,
  );
}

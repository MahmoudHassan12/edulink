import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBottomAppBar extends StatelessWidget {
  const ProfileBottomAppBar({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final linkedInLink = user.linkedInLink;
    final gitHubLink = user.gitHubLink;

    final hasLinkedIn = _isValidUserLink(linkedInLink, 'linkedin.com');
    final hasGitHub = _isValidUserLink(gitHubLink, 'github.com');

    if (!hasLinkedIn && !hasGitHub) {
      return const SizedBox.shrink();
    }

    return BottomAppBar(
      color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (hasLinkedIn)
            IconButton(
              icon: const Icon(FontAwesomeIcons.linkedinIn),
              onPressed: () async => _launchUrl(linkedInLink!),
            ),
          if (hasGitHub)
            IconButton(
              icon: const Icon(FontAwesomeIcons.github),
              onPressed: () async => _launchUrl(gitHubLink!),
            ),
        ],
      ),
    );
  }

  bool _isValidUserLink(String? url, String expectedHost) {
    if (url == null || url.trim().isEmpty) return false;
    final uri = Uri.tryParse(url.trim());
    return uri != null &&
        uri.hasScheme &&
        uri.hasAuthority &&
        uri.host.contains(expectedHost);
  }

  Future<void> _launchUrl(String url) async {
    var fixedUrl = url.trim();
    if (!fixedUrl.startsWith('http')) {
      fixedUrl = 'https://$fixedUrl';
    }
    final uri = Uri.parse(fixedUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $fixedUrl');
    }
  }
}

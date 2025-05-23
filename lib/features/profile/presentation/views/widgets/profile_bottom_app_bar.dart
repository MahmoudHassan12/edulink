import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileBottomAppBar extends StatelessWidget {
  const ProfileBottomAppBar({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final String? linkedInLink = user.linkedInLink;
    final String? gitHubLink = user.gitHubLink;

    final bool hasLinkedIn = _isValidUserLink(linkedInLink, 'linkedin.com');
    final bool hasGitHub = _isValidUserLink(gitHubLink, 'github.com');

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
              onPressed: () => _launchUrl(linkedInLink!),
            ),
          if (hasGitHub)
            IconButton(
              icon: const Icon(FontAwesomeIcons.github),
              onPressed: () => _launchUrl(gitHubLink!),
            ),
        ],
      ),
    );
  }

  bool _isValidUserLink(String? url, String expectedHost) {
    if (url == null || url.trim().isEmpty) {
      return false;
    }
    final Uri? uri = Uri.tryParse(url.trim());
    return uri != null &&
        uri.hasScheme &&
        uri.hasAuthority &&
        uri.host.contains(expectedHost);
  }

  Future<void> _launchUrl(String url) async {
    String fixedUrl = url.trim();
    if (!fixedUrl.startsWith('http')) {
      fixedUrl = 'https://$fixedUrl';
    }
    final Uri uri = Uri.parse(fixedUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint('Could not launch $fixedUrl');
    }
  }
}

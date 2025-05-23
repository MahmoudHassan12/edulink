import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ExternalVideoScreen extends StatelessWidget {
  const ExternalVideoScreen({required this.videoUrl, super.key});
  final String videoUrl;

  Future<void> _openExternalPlayer(BuildContext context) async {
    final url = Uri.parse(videoUrl);

    if (!await launchUrl(url, mode: LaunchMode.externalApplication) &&
        context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Could not launch video')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('External Video Player')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _openExternalPlayer(context),
          child: const Text('Play Video Externally'),
        ),
      ),
    );
  }
}

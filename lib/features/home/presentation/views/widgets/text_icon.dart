import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  const TextIcon({required this.icon, required this.title, super.key});
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: Text.rich(
      overflow: TextOverflow.fade,
      softWrap: false,
      TextSpan(
        children: [
          WidgetSpan(child: Icon(icon), alignment: PlaceholderAlignment.middle),
          TextSpan(text: ' $title', style: const TextStyle(fontSize: 12)),
        ],
      ),
    ),
  );
}

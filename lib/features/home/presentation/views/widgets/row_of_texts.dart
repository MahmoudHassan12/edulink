import 'package:flutter/material.dart';

class RowOfTexts extends StatelessWidget {
  const RowOfTexts({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: colorScheme.onSurface.withAlpha(128),
            ),
          ),
          Text(
            'See All',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: colorScheme.primary.withAlpha(128),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class RowOfTexts extends StatelessWidget {
  const RowOfTexts({required this.title, super.key});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.all(16),
    child: EText(
      title,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(128),
      ),
    ),
  );
}

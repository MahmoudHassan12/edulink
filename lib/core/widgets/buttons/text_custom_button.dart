import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart'
    show BuildContext, FontWeight, StatelessWidget, TextStyle;

class TextCustomButton extends StatelessWidget {
  const TextCustomButton({required this.label, super.key});
  final String label;
  @override
  EText build(BuildContext context) => EText(
    label,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}

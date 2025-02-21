import 'package:flutter/material.dart'
    show BuildContext, FontWeight, StatelessWidget, Text, TextStyle;

class TextCustomButton extends StatelessWidget {
  const TextCustomButton({required this.label, super.key});
  final String label;
  @override
  Text build(BuildContext context) => Text(
    label,
    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
  );
}

import 'package:edu_link/core/widgets/buttons/style_custom_button.dart'
    show styleCustomElevatedButton;
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart'
    show TextCustomButton;
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({required this.label, this.onPressed, super.key});
  factory CustomElevatedButton.icon({
    required String label,
    VoidCallback? onPressed,
    IconData? icon,
  }) =>
      _CustomElevatedButtonIcon(label: label, onPressed: onPressed, icon: icon);
  final VoidCallback? onPressed;
  final String label;
  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: styleCustomElevatedButton(context),
    child: TextCustomButton(label: label),
  );
}

class _CustomElevatedButtonIcon extends CustomElevatedButton {
  const _CustomElevatedButtonIcon({
    required super.label,
    super.onPressed,
    this.icon,
  });
  final IconData? icon;
  @override
  Widget build(BuildContext context) => ElevatedButton.icon(
    onPressed: onPressed,
    style: styleCustomElevatedButton(context),
    label: TextCustomButton(label: label),
    icon: Icon(icon),
    iconAlignment: IconAlignment.end,
  );
}

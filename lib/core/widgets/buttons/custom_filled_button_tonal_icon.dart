import 'package:edu_link/core/widgets/buttons/style_custom_button.dart';
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        FilledButton,
        Icon,
        IconData,
        StatelessWidget,
        VoidCallback,
        WidgetStatePropertyAll;


class CustomFilledButtonTonalIcon extends StatelessWidget {
  const CustomFilledButtonTonalIcon({
    required this.onPressed,
    required this.label,
    this.icon,
    this.backgroundColor,
    super.key,
  });
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  final Color? backgroundColor;
  @override
  FilledButton build(BuildContext context) => FilledButton.tonalIcon(
    onPressed: onPressed,
    style: styleCustomFilledButton(context).copyWith(
      backgroundColor:
          backgroundColor != null
              ? WidgetStatePropertyAll(backgroundColor)
              : null,
    ),
    label: TextCustomButton(label: label),
    icon: Icon(icon),
  );
}

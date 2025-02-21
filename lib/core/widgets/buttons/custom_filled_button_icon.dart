import 'package:edu_link/core/widgets/buttons/style_custom_filled_button.dart';
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        FilledButton,
        Icon,
        IconData,
        StatelessWidget,
        VoidCallback;


class CustomFilledButtonIcon extends StatelessWidget {
  const CustomFilledButtonIcon({
    required this.onPressed,
    required this.label,
    this.icon,
    super.key,
  });
  final VoidCallback? onPressed;
  final String label;
  final IconData? icon;
  @override
  FilledButton build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    style: styleCustomFilledButton(context),
    label: TextCustomButton(label: label),
    icon: Icon(icon),
  );
}

import 'package:edu_link/core/widgets/buttons/style_custom_button.dart';
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        FilledButton,
        Icon,
        IconData,
        StatelessWidget,
        VoidCallback;

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    required this.onPressed,
    required this.label,
    super.key,
  });
  factory CustomFilledButton.icon({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
  }) => _CustomFilledButtonIcon(onPressed: onPressed, label: label, icon: icon);
  final VoidCallback? onPressed;
  final String label;
  @override
  FilledButton build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    style: styleCustomFilledButton(context),
    child: TextCustomButton(label: label),
  );
}

class _CustomFilledButtonIcon extends CustomFilledButton {
  const _CustomFilledButtonIcon({
    required super.onPressed,
    required super.label,
    this.icon,
  });
  final IconData? icon;
  @override
  FilledButton build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    style: styleCustomFilledButton(context),
    label: TextCustomButton(label: label),
    icon: Icon(icon),
  );
}

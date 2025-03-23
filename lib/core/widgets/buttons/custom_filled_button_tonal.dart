import 'package:edu_link/core/widgets/buttons/style_custom_button.dart';
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart';
import 'package:flutter/material.dart'
    show
        BuildContext,
        Color,
        FilledButton,
        Icon,
        IconAlignment,
        IconData,
        StatelessWidget,
        VoidCallback,
        WidgetStatePropertyAll;

class CustomFilledButtonTonal extends StatelessWidget {
  const CustomFilledButtonTonal({
    required this.onPressed,
    required this.label,
    super.key,
  });
  factory CustomFilledButtonTonal.icon({
    required VoidCallback? onPressed,
    required String label,
    IconData? icon,
    Color? backgroundColor,
  }) => _CustomFilledButtonTonalIcon(
    onPressed: onPressed,
    label: label,
    icon: icon,
    backgroundColor: backgroundColor,
  );
  final VoidCallback? onPressed;
  final String label;
  @override
  FilledButton build(BuildContext context) => FilledButton.tonal(
    onPressed: onPressed,
    style: styleCustomFilledButton(context),
    child: TextCustomButton(label: label),
  );
}

class _CustomFilledButtonTonalIcon extends CustomFilledButtonTonal {
  const _CustomFilledButtonTonalIcon({
    required super.onPressed,
    required super.label,
    this.icon,
    this.backgroundColor,
  });

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
    iconAlignment: IconAlignment.end,
  );
}

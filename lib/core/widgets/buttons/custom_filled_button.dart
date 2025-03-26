import 'package:edu_link/core/widgets/buttons/style_custom_button.dart'
    show styleCustomFilledButton;
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart'
    show TextCustomButton;
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

class CustomFilledButton extends StatelessWidget {
  const CustomFilledButton({
    required this.onPressed,
    required this.label,
    this.hasMinimumSize = true,
    super.key,
  });
  factory CustomFilledButton.icon({
    required VoidCallback? onPressed,
    required String label,
    bool hasMinimumSize = true,
    IconData? icon,
  }) => _CustomFilledButtonIcon(
    onPressed: onPressed,
    label: label,
    icon: icon,
    hasMinimumSize: hasMinimumSize,
  );
  factory CustomFilledButton.tonal({
    required VoidCallback? onPressed,
    required String label,
    bool hasMinimumSize = true,
  }) => _CustomFilledButtonTonal(
    onPressed: onPressed,
    label: label,
    hasMinimumSize: hasMinimumSize,
  );
  factory CustomFilledButton.tonalIcon({
    required VoidCallback? onPressed,
    required String label,
    bool hasMinimumSize = true,
    IconData? icon,
    Color? backgroundColor,
  }) => _CustomFilledButtonTonalIcon(
    onPressed: onPressed,
    label: label,
    icon: icon,
    backgroundColor: backgroundColor,
    hasMinimumSize: hasMinimumSize,
  );

  final VoidCallback? onPressed;
  final String label;
  final bool hasMinimumSize;
  @override
  FilledButton build(BuildContext context) => FilledButton(
    onPressed: onPressed,
    style: styleCustomFilledButton(context, hasMinimumSize: hasMinimumSize),
    child: TextCustomButton(label: label),
  );
}

class _CustomFilledButtonIcon extends CustomFilledButton {
  const _CustomFilledButtonIcon({
    required super.onPressed,
    required super.label,
    super.hasMinimumSize,
    this.icon,
  });
  final IconData? icon;
  @override
  FilledButton build(BuildContext context) => FilledButton.icon(
    onPressed: onPressed,
    style: styleCustomFilledButton(context, hasMinimumSize: hasMinimumSize),
    label: TextCustomButton(label: label),
    icon: Icon(icon),
  );
}

class _CustomFilledButtonTonal extends CustomFilledButton {
  const _CustomFilledButtonTonal({
    required super.onPressed,
    required super.label,
    super.hasMinimumSize,
  });
  @override
  FilledButton build(BuildContext context) => FilledButton.tonal(
    onPressed: onPressed,
    style: styleCustomFilledButton(context, hasMinimumSize: hasMinimumSize),
    child: TextCustomButton(label: label),
  );
}

class _CustomFilledButtonTonalIcon extends _CustomFilledButtonTonal {
  const _CustomFilledButtonTonalIcon({
    required super.onPressed,
    required super.label,
    super.hasMinimumSize,
    this.icon,
    this.backgroundColor,
  });
  final IconData? icon;
  final Color? backgroundColor;
  @override
  FilledButton build(BuildContext context) => FilledButton.tonalIcon(
    onPressed: onPressed,
    style: styleCustomFilledButton(
      context,
      hasMinimumSize: hasMinimumSize,
    ).copyWith(
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

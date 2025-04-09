import 'package:edu_link/core/widgets/buttons/style_custom_button.dart'
    show styleCustomIconButton;
import 'package:flutter/material.dart'
    show
        BuildContext,
        Icon,
        IconButton,
        IconData,
        StatelessWidget,
        VoidCallback;

class CustomIconButtonFilledTonal extends StatelessWidget {
  const CustomIconButtonFilledTonal({
    required this.onPressed,
    required this.icon,
    this.iconSize,
    super.key,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  final double? iconSize;
  @override
  IconButton build(BuildContext context) => IconButton.filledTonal(
    onPressed: onPressed,
    iconSize: iconSize,
    icon: Icon(icon),
    style: styleCustomIconButton(),
  );
}

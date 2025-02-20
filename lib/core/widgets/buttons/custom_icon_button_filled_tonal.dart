import 'package:edu_link/core/widgets/buttons/style_custom_icon_button.dart';
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
    super.key,
  });
  final VoidCallback? onPressed;
  final IconData icon;
  @override
  IconButton build(BuildContext context) => IconButton.filledTonal(
    onPressed: onPressed,
    icon: Icon(icon),
    style: styleCustomIconButton(),
  );
}

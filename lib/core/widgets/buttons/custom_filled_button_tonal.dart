import 'package:edu_link/core/widgets/buttons/style_custom_filled_button.dart';
import 'package:edu_link/core/widgets/buttons/text_custom_button.dart';
import 'package:flutter/material.dart'
    show BuildContext, FilledButton, StatelessWidget, VoidCallback;

class CustomFilledButtonTonal extends StatelessWidget {
  const CustomFilledButtonTonal({
    required this.onPressed,
    required this.label,
    super.key,
  });
  final VoidCallback? onPressed;
  final String label;
  @override
  FilledButton build(BuildContext context) => FilledButton.tonal(
    onPressed: onPressed,
    style: styleCustomFilledButton(context),
    child: TextCustomButton(label: label),
  );
}

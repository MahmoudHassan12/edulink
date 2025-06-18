import 'package:edu_link/core/widgets/buttons/style_custom_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    required this.onPressed,
    required this.text,
    super.key,
  });
  final VoidCallback? onPressed;
  final String text;
  @override
  OutlinedButton build(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: styleCustomOutlinedButton(context),
    child: EText(text),
  );
}

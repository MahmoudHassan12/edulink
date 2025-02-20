import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class SignInWithProviderButton extends StatelessWidget {
  const SignInWithProviderButton({
    required this.onPressed,
    required this.label,
    required this.iconData,
    this.isLoading = false,
    super.key,
  });
  final bool isLoading;
  final VoidCallback? onPressed;
  final String label;
  final IconData iconData;
  @override
  CustomOutlinedButton build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;
    return CustomOutlinedButton(
      onPressed: isLoading ? null : onPressed,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(iconData, size: 24, color: onSurface),
          EText(label, style: TextStyle(color: onSurface, fontSize: 16)),
        ],
      ),
    );
  }
}

class CustomOutlinedButton extends StatelessWidget {
  const CustomOutlinedButton({
    required this.onPressed,
    required this.child,
    super.key,
  });
  final VoidCallback? onPressed;
  final Widget? child;
  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onPressed,
    style: OutlinedButton.styleFrom(
      minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
      shape: const RoundedRectangleBorder(borderRadius: xsBorder),
    ),
    child: child,
  );
}

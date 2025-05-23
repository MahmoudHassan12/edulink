import 'package:edu_link/core/constants/borders.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:flutter/material.dart';

class SignInWithProviderButton extends StatelessWidget {
  const SignInWithProviderButton({
    required this.onPressed,
    required this.label,
    this.iconData,
    this.isLoading = false,
    super.key,
  });
  final VoidCallback? onPressed;
  final String label;
  final IconData? iconData;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    final Color onSurface = Theme.of(context).colorScheme.onSurface;
    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size(MediaQuery.sizeOf(context).longestSide, 56),
        shape: const RoundedSuperellipseBorder(borderRadius: xsBorder),
      ),
      icon: Icon(iconData, size: 24, color: onSurface),
      label: EText(label, style: TextStyle(color: onSurface, fontSize: 16)),
    );
  }
}

import 'package:edu_link/core/constants/borders.dart';
import 'package:flutter/material.dart';

class ProfilePanal extends StatelessWidget {
  const ProfilePanal({required this.child, super.key});
  final Widget child;
  @override
  Widget build(BuildContext context) => Card.filled(
    margin: EdgeInsets.zero,
    elevation: 1,
    shape: const RoundedSuperellipseBorder(borderRadius: mBorder),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: child,
    ),
  );
}

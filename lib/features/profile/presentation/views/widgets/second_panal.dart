import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class SecondPanal extends StatelessWidget {
  const SecondPanal({super.key});
  @override
  Widget build(BuildContext context) => const ProfilePanal(
    child: Column(
      spacing: 8,
      children: [
        ListTile(
          minVerticalPadding: 0,
          minTileHeight: 0,
          leading: Icon(Icons.phone_rounded),
          title: EText('0123456789'),
        ),
        Divider(indent: 16, endIndent: 16),
        ListTile(
          minVerticalPadding: 0,
          minTileHeight: 0,
          leading: Icon(Icons.email_rounded),
          title: EText('30123456789123@sci.asu.edu.eg'),
        ),
      ],
    ),
  );
}

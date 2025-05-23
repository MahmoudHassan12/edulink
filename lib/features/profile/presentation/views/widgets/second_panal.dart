import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class SecondPanal extends StatelessWidget {
  const SecondPanal({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => ProfilePanal(
      child: Column(
        spacing: 8,
        children: [
          ListTile(
            minVerticalPadding: 0,
            minTileHeight: 0,
            leading: const Icon(Icons.phone_rounded),
            title: EText(user.phone ?? 'No Phone Number'),
          ),
          const Divider(indent: 16, endIndent: 16),
          ListTile(
            minVerticalPadding: 0,
            minTileHeight: 0,
            leading: const Icon(Icons.email_rounded),
            title: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: EText(user.email ?? 'No Email'),
            ),
          ),
        ],
      ),
    );
}

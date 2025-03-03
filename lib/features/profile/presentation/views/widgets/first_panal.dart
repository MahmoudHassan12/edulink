import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class FirstPanal extends StatelessWidget {
  const FirstPanal({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.primary;
    return ProfilePanal(
      child: Column(
        spacing: 8,
        children: [
          UserPhoto(
            radius: 48,
            imageUrl: user.imageUrl!,
          ),
          EText(
            user.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    EText(
                      'Credit Level',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    EText(
                      'Student ID',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    EText(
                      'Program',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ),
              const Column(
                spacing: 8,
                children: [EText('  :  '), EText('  :  '), EText('  :  ')],
              ),
              // const Spacer(),
              Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EText(user.level!),
                    EText(user.id!),
                    EText(user.program!),
                  ],
                ),
              ),
            ],
          ),
          const Divider(indent: 16, endIndent: 16),
          EText(
            'Faculty of Science',
            style: TextStyle(color: colorScheme.onSurface.withAlpha(200)),
          ),
        ],
      ),
    );
  }
}

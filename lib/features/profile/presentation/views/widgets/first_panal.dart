import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class FirstPanal extends StatelessWidget {
  const FirstPanal({required this.user, super.key});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => ProfilePanal(
    child: Column(
      spacing: 8,
      children: [
        UserPhoto(user: user, radius: 48, isHero: true, hasNavigation: false),
        _UserName(user: user),
        _UserInfoFirstPanal(user: user),
        const Divider(indent: 16, endIndent: 16),
        EText(
          'Faculty of Science',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
          ),
        ),
      ],
    ),
  );
}

class _UserName extends StatelessWidget {
  const _UserName({required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) => EText(
    user.isProfessor ?? false ? 'Dr. ${user.name}' : user.name ?? '',
    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  );
}

class _UserInfoFirstPanal extends StatelessWidget {
  const _UserInfoFirstPanal({required this.user});
  final UserEntity user;
  @override
  Widget build(BuildContext context) {
    final Map<String, String?> studentInfo = {
      'Credit Level': user.level,
      'Student ID': user.ssn?.substring(0, 8).toUpperCase(),
      'Program': user.program?.name,
    };
    final Map<String, String?> professorInfo = {
      'Academic title': user.academicTitle,
      'Department': user.department?.name,
    };
    final info = user.isProfessor ?? false ? professorInfo : studentInfo;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: info.entries
            .map(
              (e) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 100,
                      child: Text(
                        e.key,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      ":",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),

                    Expanded(
                      child: Text(
                        e.value ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ],
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

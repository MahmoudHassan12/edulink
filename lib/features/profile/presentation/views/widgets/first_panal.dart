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
      'Student ID': user.id,
      'Program': user.program?.name,
    };
    final Map<String, String?> professorInfo = {
      'Academic title': user.academicTitle,
      'Department': user.department?.name,
    };
    final info = user.isProfessor ?? false ? professorInfo : studentInfo;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.end,
            children:
                info.entries
                    .map(
                      (e) => EText(
                        e.key,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    )
                    .toList(),
          ),
        ),
        Column(
          spacing: 8,
          children: List<EText>.generate(
            info.length,
            (_) => const EText('  :  '),
          ),
        ),
        Expanded(
          child: Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: info.entries.map((e) => EText(e.value!)).toList(),
          ),
        ),
      ],
    );
  }
}

import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:edu_link/features/chat/widgets/chat_view_body.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class FirstPanal extends StatelessWidget {
  const FirstPanal({super.key});
  @override
  Widget build(BuildContext context) {
    var user = getUser;
    return ProfilePanal(
      child: Column(
        spacing: 8,
        children: [
          const UserPhoto(radius: 48, isHero: true),
          const _UserName(),
          const _UserInfoFirstPanal(),
          const Divider(indent: 16, endIndent: 16),
          InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) {
                    return ChatScreen(
                      userId1: "t3mEOIyVKxVfBtd25ZqLFHs7S8y2",
                      userId2: "OOB4fQNRgnbe08HkqgVkOuwItz52",
                      user1Name: "Hassan",
                      user2Name: "Hossam",
                      user1ImgUrl: "https://avatar.iran.liara.run/public/23",
                      user2ImgUrl: "${user?.imageUrl}",
                      currentUserId: "t3mEOIyVKxVfBtd25ZqLFHs7S8y2",
                    );
                  },
                ),
              );
            },
            child: EText(
              'Faculty of Science',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withAlpha(200),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _UserName extends StatelessWidget {
  const _UserName();
  @override
  Widget build(BuildContext context) {
    final user = getUser;
    return EText(
      user?.isProfessor ?? false ? 'Dr. ${user?.name}' : user?.name ?? '',
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }
}

class _UserInfoFirstPanal extends StatelessWidget {
  const _UserInfoFirstPanal();
  @override
  Widget build(BuildContext context) {
    final user = getUser;
    final studentInfo = {
      'Credit Level': user?.level,
      'Student ID': user?.id,
      'Program': user?.program?.name,
    };
    final professorInfo = {
      'Academic title': user?.academicTitle,
      'Department': user?.department?.name,
    };
    final info = user?.isProfessor ?? false ? professorInfo : studentInfo;
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

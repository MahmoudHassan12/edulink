import 'package:cached_network_image/cached_network_image.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/profile/presentation/views/widgets/profile_panal.dart';
import 'package:flutter/material.dart';

class FirstPanal extends StatelessWidget {
  const FirstPanal({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final color = colorScheme.primary;
    return ProfilePanal(
      child: Column(
        spacing: 8,
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundImage: CachedNetworkImageProvider(
              'https://i.pravatar.cc/300',
            ),
          ),
          const EText(
            'Hossam Hassan',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
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
              const Expanded(
                child: Column(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    EText('Level 4'),
                    EText('12345678'),
                    EText('Statistic & CS'),
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

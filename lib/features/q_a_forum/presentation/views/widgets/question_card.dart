import 'package:edu_link/core/constants/borders.dart' show xsBorder;
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/helpers/navigations.dart'
    show questionDetailsNavigation;
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/buttons/custom_icon_button_filled_tonal.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/favorite_button.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({required this.qa, super.key});
  final QuestionEntity qa;
  @override
  Widget build(BuildContext context) {
    final aLength = qa.answers?.length ?? 0;
    final user = qa.user;
    final date = DateFormat('MMMM dd, yyyy').format(qa.date ?? DateTime.now());
    final time = DateFormat('hh:mm a').format(qa.date ?? DateTime.now());
    return Hero(
      tag: qa.hashCode,
      child: Card.filled(
        shape: const RoundedRectangleBorder(borderRadius: xsBorder),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: () async => questionDetailsNavigation(context, extra: qa),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minTileHeight: 56,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: UserPhoto(imageUrl: user?.imageUrl),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EText(
                      user?.name ?? 'Anonymous',
                      style: const TextStyle(fontSize: 14),
                    ),
                    EText(
                      aLength == 1 ? '$aLength answer' : '$aLength answers',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                subtitle: EText(
                  '$date at $time',
                  style: const TextStyle(fontSize: 11, color: Colors.grey),
                ),
                trailing: CustomIconButtonFilledTonal(
                  onPressed: () {},
                  icon: Icons.edit_note_rounded,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 64, right: 8),
                child: EText(qa.question ?? 'No question', softWrap: true),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  spacing: 8,
                  children: [
                    CustomFilledButton(
                      onPressed: () {},
                      label: 'Answer',
                      hasMinimumSize: false,
                    ),
                    TextButton(onPressed: () {}, child: const Text('Delete')),
                    const Spacer(),
                    const FavoriteButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

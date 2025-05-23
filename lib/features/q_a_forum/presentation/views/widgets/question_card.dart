import 'package:edu_link/core/constants/borders.dart' show xsBorder;
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/get_user.dart' show getUser;
import 'package:edu_link/core/helpers/navigations.dart'
    show popNavigation, questionDetailsNavigation;
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/buttons/custom_icon_button_filled_tonal.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/core/widgets/favorite_button.dart';
import 'package:edu_link/core/widgets/user_photo.dart';
import 'package:edu_link/features/q_a_forum/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.qa,
    this.courseId,
    this.clickable = true,
    super.key,
  });
  final QuestionEntity qa;
  final String? courseId;
  final bool clickable;
  @override
  Widget build(BuildContext context) {
    final int aLength = qa.answers?.length ?? 0;
    final UserEntity? user = qa.user;
    final String date = DateFormat(
      'MMMM dd, yyyy',
    ).format(qa.date ?? DateTime.now());
    final String time = DateFormat('hh:mm a').format(qa.date ?? DateTime.now());
    return Hero(
      tag: qa.hashCode,
      child: Card.filled(
        shape: const RoundedSuperellipseBorder(borderRadius: xsBorder),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: clickable
              ? () => questionDetailsNavigation(
                  context,
                  extra: {'qa': qa, 'context': context, 'courseId': courseId},
                )
              : null,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                minTileHeight: 56,
                contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                leading: UserPhoto(user: user!),
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    EText(
                      user.name ?? 'Anonymous',
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
                    if (user.id == getUser?.id && clickable)
                      TextButton(
                        onPressed: () => showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            title: const Text('Delete question'),
                            content: const Text('Are you sure?'),
                            actions: [
                              TextButton(
                                onPressed: () => popNavigation(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  await context
                                      .read<QuestionManagerCubit>()
                                      .deleteQuestion(qa);
                                  if (context.mounted) {
                                    popNavigation(context);
                                  }
                                },
                                child: const Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                        child: const Text('Delete'),
                      ),
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

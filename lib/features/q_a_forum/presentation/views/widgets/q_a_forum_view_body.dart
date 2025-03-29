import 'package:edu_link/core/domain/entities/answer_entity.dart';
import 'package:edu_link/core/domain/entities/question_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/widgets/buttons/custom_filled_button.dart';
import 'package:edu_link/core/widgets/e_text.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_app_bar.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/question_card.dart';
import 'package:flutter/material.dart';

class QAForumViewBody extends StatelessWidget {
  const QAForumViewBody({super.key});
  @override
  CustomScrollView build(BuildContext context) => CustomScrollView(
    slivers: [
      const QAForumAppBar(),
      SliverToBoxAdapter(
        child: ListTile(
          minTileHeight: 64,
          title: const EText('Questions'),
          trailing: CustomFilledButton(
            onPressed: () {},
            label: 'Ask a question',
            hasMinimumSize: false,
          ),
        ),
      ),
      SliverList.builder(
        itemCount: _questions.length,
        itemBuilder: (context, index) => QuestionCard(qa: _questions[index]),
      ),
    ],
  );
}

List<QuestionEntity> _questions = [
  QuestionEntity(
    question: 'What is Flutter?',
    answers: [
      AnswerEntity(
        answer:
            'Flutter is a mobile app development framework created by Google.',
        user: const UserEntity(
          name: 'Hosam Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/30',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'Flutter is an open-source mobile app '
            'development framework created by Google.',
        user: const UserEntity(
          name: 'Mahmoud Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/31',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Yousef Saber',
      imageUrl: 'https://avatar.iran.liara.run/public/32',
    ),
    date: DateTime.now(),
  ),
  QuestionEntity(
    question: 'What is Dart?',
    answers: [
      AnswerEntity(
        answer:
            'Dart is a programming language '
            'created by Google that runs on Flutter.',
        user: const UserEntity(
          name: 'Yousef Saber',
          imageUrl: 'https://avatar.iran.liara.run/public/32',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'Dart is an open-source programming language '
            'created by Google that runs on Flutter.',
        user: const UserEntity(
          name: 'Mahmoud Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/31',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Hosam Hasan',
      imageUrl: 'https://avatar.iran.liara.run/public/30',
    ),
    date: DateTime.now(),
  ),
  QuestionEntity(
    question: 'What is a widget?',
    answers: [
      AnswerEntity(
        answer: 'A widget is a building block of user interface in Flutter.',
        user: const UserEntity(
          name: 'Yousef Saber',
          imageUrl: 'https://avatar.iran.liara.run/public/32',
        ),
        date: DateTime.now(),
      ),
      AnswerEntity(
        answer:
            'A widget is an abstract representation '
            'of a user interface in Flutter.',
        user: const UserEntity(
          name: 'Hosam Hasan',
          imageUrl: 'https://avatar.iran.liara.run/public/30',
        ),
        date: DateTime.now(),
      ),
    ],
    user: const UserEntity(
      name: 'Mahmoud Hasan',
      imageUrl: 'https://avatar.iran.liara.run/public/31',
    ),
    date: DateTime.now(),
  ),
];

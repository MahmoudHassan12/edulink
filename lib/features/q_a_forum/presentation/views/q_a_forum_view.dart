import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:edu_link/features/q_a_forum/presentation/views/widgets/q_a_forum_view_body.dart'
    show QAForumViewBody;
import 'package:edu_link/features/question_details/presentation/controllers/question_manager_cubit/question_manager_cubit.dart'
    show QuestionManagerCubit;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider, BlocSelector;

class QAForumView extends StatelessWidget {
  const QAForumView({required this.course, super.key});
  final CourseEntity course;
  @override
  Scaffold build(BuildContext context) => Scaffold(
    body: BlocSelector<HomeCubit, HomeState, CourseEntity?>(
      selector: (state) {
        if (state is HomeSuccess) {
          return state.courses?.firstWhere(
            (e) => e.id == course.copyWith().id,
            orElse: () => course,
          );
        }
        return null;
      },
      builder: (_, course) {
        return BlocProvider<QuestionManagerCubit>(
          create: (context) => QuestionManagerCubit(course.id!),
          child: QAForumViewBody(
            course: course!.copyWith(
              questions: course.questions?.reversed.toList(),
            ),
          ),
        );
      },
    ),
  );
}

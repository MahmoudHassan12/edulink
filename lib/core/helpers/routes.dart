import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/services/auth_service.dart' show AuthService;
import 'package:edu_link/features/about/presentation/views/about_view.dart'
    show AboutView;
import 'package:edu_link/features/auth/presentation/views/register_view.dart'
    show RegisterView;
import 'package:edu_link/features/auth/presentation/views/reset_password_view.dart'
    show ResetPasswordView;
import 'package:edu_link/features/auth/presentation/views/signin_view.dart'
    show SigninView;
import 'package:edu_link/features/chat/presentation/views/chat_view.dart'
    show ChatView;
import 'package:edu_link/features/content/content_view.dart';
import 'package:edu_link/features/course_details/presentation/views/course_details_view.dart'
    show CourseDetailsView;
import 'package:edu_link/features/course_details/presentation/views/registered_users_view.dart';
import 'package:edu_link/features/home/presentation/views/home_view.dart'
    show HomeView;
import 'package:edu_link/features/manage_course/presentation/views/manage_course_view.dart'
    show ManageCourseView;
import 'package:edu_link/features/manage_profile/presentation/views/manage_profile_view.dart';
import 'package:edu_link/features/profile/presentation/views/profile_view.dart'
    show ProfileView;
import 'package:edu_link/features/q_a_forum/presentation/views/q_a_forum_view.dart'
    show QAForumView;
import 'package:edu_link/features/question_details/presentation/views/question_details_view.dart'
    show QuestionDetailsView;
import 'package:edu_link/features/register_courses/presentation/views/register_courses_view.dart'
    show RegisterCoursesView;
import 'package:edu_link/features/settings/presentation/view/settings_view.dart'
    show SettingsView;
import 'package:flutter/material.dart'
    show BuildContext, GlobalKey, NavigatorState, RouterConfig, Widget;
import 'package:go_router/go_router.dart'
    show GoRoute, GoRouter, RouteMatchList;

abstract class Routes {
  const Routes();
  static const aboutView = '/about';
  static const chatView = '/chat';
  static const courseDetailsView = '/course-details';
  static const homeView = '/';
  static const manageCourseView = '/manage-course';
  static const manageProfileView = '/manage-profile';
  static const profileView = '/student-profile';
  static const qaForumView = '/qa-forum';
  static const questionDetailsView = '/question-details';
  static const registerCoursesView = '/register-courses';
  static const registeredUsersView = '/registered-users';
  static const registerView = '/register';
  static const resetPasswordView = '/reset-password';
  static const settingsView = '/settings';
  static const signinView = '/sign-in';
  static const contentView = '/content';
}

final Map<String, Widget Function(BuildContext, Object?)> _routes = {
  /// Routes with arguments
  Routes.chatView: (context, args) => ChatView(receiver: args! as UserEntity),
  Routes.courseDetailsView: (context, args) =>
      CourseDetailsView(course: args! as CourseEntity),
  Routes.manageCourseView: (context, args) =>
      ManageCourseView(course: args! as CourseEntity),
  Routes.profileView: (context, args) => ProfileView(user: args! as UserEntity),
  Routes.qaForumView: (context, args) =>
      QAForumView(course: args! as CourseEntity),
  Routes.questionDetailsView: (context, args) {
    final arg = args as Map<String, dynamic>?;
    return QuestionDetailsView(
      qa: arg!['qa'],
      qaContext: arg['context'],
      courseId: arg['courseId'],
    );
  },
  Routes.contentView: (context, args) => ContentView(courseId: args! as String),

  /// Routes without arguments
  Routes.aboutView: (context, args) => const AboutView(),
  Routes.homeView: (context, args) => const HomeView(),
  Routes.manageProfileView: (context, args) => const ManageProfileView(),
  Routes.registerCoursesView: (context, args) => const RegisterCoursesView(),
  Routes.registeredUsersView: (context, args) =>
      RegisteredUsersView(courseId: args! as String),
  Routes.registerView: (context, args) => const RegisterView(),
  Routes.resetPasswordView: (context, args) => const ResetPasswordView(),
  Routes.settingsView: (context, args) => const SettingsView(),
  Routes.signinView: (context, args) => const SigninView(),
};
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
RouterConfig<RouteMatchList> routerConfig = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: const AuthService().isSignedIn()
      ? (getUser?.isValid ?? false)
            ? Routes.homeView
            : Routes.manageProfileView
      : Routes.signinView,
  routes: _routes.entries
      .map(
        (entry) => GoRoute(
          path: entry.key,
          name: entry.key,
          builder: (context, state) => entry.value(context, state.extra),
        ),
      )
      .toList(),
);

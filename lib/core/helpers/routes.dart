import 'package:edu_link/core/domain/entities/course_entity.dart'
    show CourseEntity;
import 'package:edu_link/core/domain/entities/user_entity.dart' show UserEntity;
import 'package:edu_link/core/helpers/auth_service.dart' show AuthService;
import 'package:edu_link/features/about/presentation/views/about_view.dart'
    show AboutView;
import 'package:edu_link/features/add_course/presentation/views/add_course_view.dart'
    show AddCourseView;
import 'package:edu_link/features/auth/presentation/views/register_view.dart'
    show RegisterView;
import 'package:edu_link/features/auth/presentation/views/reset_password_view.dart'
    show ResetPasswordView;
import 'package:edu_link/features/auth/presentation/views/signin_view.dart'
    show SigninView;
import 'package:edu_link/features/course_details/presentation/views/course_details_view.dart'
    show CourseDetailsView;
import 'package:edu_link/features/home/presentation/views/home_view.dart'
    show HomeView;
import 'package:edu_link/features/profile/presentation/views/profile_view.dart'
    show ProfileView;
import 'package:edu_link/features/register_courses/presentation/views/register_courses_view.dart'
    show RegisterCoursesView;
import 'package:edu_link/features/settings/presentation/views/settings_view.dart'
    show SettingsView;
import 'package:flutter/material.dart' show BuildContext, RouterConfig, Widget;
import 'package:go_router/go_router.dart'
    show GoRoute, GoRouter, RouteMatchList;

abstract class Routes {
  const Routes();
  static const String aboutView = '/about';
  static const String addCourseView = '/add-course';
  static const String courseDetailsView = '/course-details';
  static const String homeView = '/';
  static const String profileView = '/student-profile';
  static const String registerCoursesView = '/register-courses';
  static const String registerView = '/register';
  static const String resetPasswordView = '/reset-password';
  static const String settingsView = '/settings';
  static const String signinView = '/sign-in';
}

final Map<String, Widget Function(BuildContext, Object?)> _routes = {
  /// Routes with arguments
  Routes.courseDetailsView:
      (context, args) => CourseDetailsView(course: args! as CourseEntity),
  Routes.profileView: (context, args) => ProfileView(user: args! as UserEntity),

  /// Routes without arguments
  Routes.aboutView: (context, args) => const AboutView(),
  Routes.addCourseView: (context, args) => const AddCourseView(),
  Routes.homeView: (context, args) => const HomeView(),
  Routes.registerCoursesView: (context, args) => const RegisterCoursesView(),
  Routes.registerView: (context, args) => const RegisterView(),
  Routes.resetPasswordView: (context, args) => const ResetPasswordView(),
  Routes.settingsView: (context, args) => const SettingsView(),
  Routes.signinView: (context, args) => const SigninView(),
};

RouterConfig<RouteMatchList> routerConfig = GoRouter(
  initialLocation:
      AuthService().isSignedIn() ? Routes.homeView : Routes.signinView,
  routes:
      _routes.entries
          .map(
            (entry) => GoRoute(
              path: entry.key,
              name: entry.key,
              builder: (context, state) => entry.value(context, state.extra),
            ),
          )
          .toList(),
);

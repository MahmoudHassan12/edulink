import 'package:edu_link/features/about/presentation/views/about_view.dart'
    show AboutView;
import 'package:edu_link/features/auth/presentation/views/register_view.dart';
import 'package:edu_link/features/auth/presentation/views/reset_password_view.dart';
import 'package:edu_link/features/auth/presentation/views/signin_view.dart';

import 'package:edu_link/features/home/presentation/views/home_view.dart'
    show HomeView;
import 'package:edu_link/features/profile/presentation/views/profile_view.dart'
    show ProfileView;
import 'package:edu_link/features/settings/presentation/views/settings_view.dart'
    show SettingsView;
import 'package:flutter/material.dart' show BuildContext, RouterConfig, Widget;
import 'package:go_router/go_router.dart'
    show GoRoute, GoRouter, RouteMatchList;

abstract class Routes {
  const Routes();
  static const String aboutView = '/about';
  static const String homeView = '/';
  static const String profileView = '/profile';
  static const String registerView = '/register';
  static const String resetPasswordView = '/reset-password';
  static const String settingsView = '/settings';
  static const String signinView = '/sign-in';
}

final Map<String, Widget Function(BuildContext, Object?)> _routes = {
  Routes.aboutView: (context, args) => const AboutView(),
  Routes.homeView: (context, args) => const HomeView(),
  Routes.profileView: (context, args) => const ProfileView(),
  Routes.registerView: (context, args) => const RegisterView(),
  Routes.resetPasswordView: (context, args) => const ResetPasswordView(),
  Routes.settingsView: (context, args) => const SettingsView(),
  Routes.signinView: (context, args) => const SigninView(),
};

RouterConfig<RouteMatchList> routerConfig = GoRouter(
  initialLocation: Routes.signinView,
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

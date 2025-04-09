import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/routes.dart' show Routes;
import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouter, RouteMatchList;

Future<void> _navigateTo(
  BuildContext context,
  String route, {
  bool clearStack = false,
  Object? extra,
}) async {
  final router = GoRouter.of(context);
  return clearStack
      ? router.go(route, extra: extra)
      : router.push<RouteMatchList?>(route, extra: extra);
}

void popNavigation(BuildContext context, [Object? result]) =>
    GoRouter.of(context).pop(result);

/// Navigations that clear the stack
Future<void> homeNavigation(BuildContext context) =>
    _navigateTo(context, Routes.homeView, clearStack: true);
Future<void> signinNavigation(BuildContext context) =>
    _navigateTo(context, Routes.signinView, clearStack: true);

/// Navigations with extra data
Future<void> chatNavigation(
  BuildContext context, {
  required UserEntity extra,
}) => _navigateTo(context, Routes.chatView, extra: extra);
Future<void> courseDetailsNavigation(
  BuildContext context, {
  required CourseEntity extra,
}) => _navigateTo(context, Routes.courseDetailsView, extra: extra);
Future<void> manageCourseNavigation(BuildContext context, {Object? extra}) =>
    _navigateTo(context, Routes.manageCourseView, extra: extra);
Future<void> profileNavigation(
  BuildContext context, {
  required UserEntity extra,
}) => _navigateTo(context, Routes.profileView, extra: extra);
Future<void> qAForumNavigation(
  BuildContext context, {
  required CourseEntity extra,
}) => _navigateTo(context, Routes.qaForumView, extra: extra);
Future<void> questionDetailsNavigation(BuildContext context, {Object? extra}) =>
    _navigateTo(context, Routes.questionDetailsView, extra: extra);

/// Normal Navigations
Future<void> aboutNavigation(BuildContext context) =>
    _navigateTo(context, Routes.aboutView);
Future<void> manageProfileNavigation(BuildContext context) =>
    _navigateTo(context, Routes.manageProfileView);
Future<void> registerCoursesNavigation(BuildContext context) =>
    _navigateTo(context, Routes.registerCoursesView);
Future<void> registerNavigation(BuildContext context) =>
    _navigateTo(context, Routes.registerView);
Future<void> resetPasswordNavigation(BuildContext context) =>
    _navigateTo(context, Routes.resetPasswordView);
Future<void> settingsNavigation(BuildContext context) =>
    _navigateTo(context, Routes.settingsView);

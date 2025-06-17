import 'package:edu_link/core/domain/entities/course_entity.dart';
import 'package:edu_link/core/domain/entities/user_entity.dart';
import 'package:edu_link/core/helpers/routes.dart' show Routes;
import 'package:flutter/material.dart' show BuildContext;
import 'package:go_router/go_router.dart' show GoRouter;

Future<T?> _push<T extends Object?>(
  BuildContext context,
  String route, {
  Object? extra,
}) => GoRouter.of(context).push<T?>(route, extra: extra);

void _go(BuildContext context, String route, {Object? extra}) =>
    GoRouter.of(context).go(route, extra: extra);

void popNavigation(BuildContext context, [Object? result]) =>
    GoRouter.of(context).pop(result);

/// Navigations that clear the stack
void homeNavigation(BuildContext context) => _go(context, Routes.homeView);
void signinNavigation(BuildContext context) => _go(context, Routes.signinView);

/// Navigations with extra data
Future<void> chatNavigation(
  BuildContext context, {
  required UserEntity extra,
}) => _push(context, Routes.chatView, extra: extra);
Future<void> courseDetailsNavigation(
  BuildContext context, {
  required CourseEntity extra,
}) => _push(context, Routes.courseDetailsView, extra: extra);
Future<void> manageCourseNavigation(BuildContext context, {Object? extra}) =>
    _push(context, Routes.manageCourseView, extra: extra);
Future<void> profileNavigation(
  BuildContext context, {
  required UserEntity extra,
}) => _push(context, Routes.profileView, extra: extra);
Future<void> qAForumNavigation(
  BuildContext context, {
  required CourseEntity extra,
}) => _push(context, Routes.qaForumView, extra: extra);
Future<void> questionDetailsNavigation(
  BuildContext context, {
  required Map<String, dynamic> extra,
}) => _push(context, Routes.questionDetailsView, extra: extra);
Future<void> registeredUsersNavigation(
  BuildContext context, {
  required String extra,
}) => _push(context, Routes.registeredUsersView, extra: extra);
Future<void> contentNavigation(BuildContext context, {Object? extra}) =>
    _push(context, Routes.contentView, extra: extra);

/// Normal Navigations
Future<void> aboutNavigation(BuildContext context) =>
    _push(context, Routes.aboutView);

Future<void> manageProfileNavigation(BuildContext context) =>
    _push(context, Routes.manageProfileView);
Future<void> registerCoursesNavigation(BuildContext context) =>
    _push(context, Routes.registerCoursesView);

Future<void> registerNavigation(BuildContext context) =>
    _push(context, Routes.registerView);
Future<void> resetPasswordNavigation(BuildContext context) =>
    _push(context, Routes.resetPasswordView);
Future<void> settingsNavigation(BuildContext context) =>
    _push(context, Routes.settingsView);

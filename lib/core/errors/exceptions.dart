import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuthException, FirebaseException;
import 'package:flutter/services.dart' show PlatformException;

sealed class _Exception implements Exception {
  const _Exception(this.exception, [this.stackTrace]);
  final dynamic exception;
  final StackTrace? stackTrace;
  @override
  String toString() =>
      exception == null ? 'Exception' : 'Exception: $exception';
}

final class AppException extends _Exception {
  const AppException(super.exception, [super.stackTrace]);
}

final class AuthException extends _Exception {
  const AuthException(
    FirebaseAuthException super.exception, [
    super.stackTrace,
  ]);
  @override
  FirebaseAuthException get exception =>
      super.exception as FirebaseAuthException;
  @override
  String toString() {
    final String? message = exception.message;
    return message == null ? 'Exception' : 'Exception: $message';
  }
}

final class DatabaseException extends _Exception {
  const DatabaseException(
    FirebaseException super.exception, [
    super.stackTrace,
  ]);
  @override
  FirebaseException get exception => super.exception as FirebaseException;
  @override
  String toString() {
    final String? message = exception.message;
    return message == null ? 'Exception' : 'Exception: $message';
  }
}

final class ProviderException extends _Exception {
  const ProviderException(
    PlatformException super.exception, [
    super.stackTrace,
  ]);
  @override
  PlatformException get exception => super.exception as PlatformException;
  @override
  String toString() {
    final String? message = exception.message;
    return message == null ? 'Exception' : 'Exception: $message';
  }
}

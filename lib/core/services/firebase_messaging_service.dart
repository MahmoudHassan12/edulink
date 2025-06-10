import 'dart:async';
import 'dart:convert' show jsonEncode;
import 'dart:developer' show log;

import 'package:edu_link/core/helpers/flutter_local_notifications.dart'
    show LocalNotificationsHelper;
import 'package:edu_link/core/helpers/get_user.dart';
import 'package:edu_link/core/repos/user_repo.dart' show UserRepo;
import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging, NotificationSettings, RemoteMessage;
import 'package:flutter/foundation.dart' show immutable;

@immutable
final class FirebaseMessagingService {
  const FirebaseMessagingService();
  static final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  void onBackgroundMessage() =>
      FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

  Future<void> get init async {
    // 1. Ask user for permissions (iOS/macOS)
    final NotificationSettings settings = await _fcm.requestPermission(
      carPlay: true,
    );
    log('Permission status: ${settings.authorizationStatus}');
    await _getToken().then(
      (final token) async => (getUser?.isValid ?? false)
          ? await const UserRepo().update(
              data: getUser!.copyWith(fcmToken: token).toMap(),
              documentId: getUser!.id!,
            )
          : await null,
    );

    // 2. Enable auto-init
    await _fcm.setAutoInitEnabled(true);

    // 3. Foreground display
    await _fcm.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // 4. Message handlers
    FirebaseMessaging.onMessage.listen(handleForegroundMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessageOpenedApp);

    final RemoteMessage? initial = await _fcm.getInitialMessage();
    if (initial != null) {
      _handleMessageOpenedApp(initial);
    }
  }

  StreamSubscription<RemoteMessage> onMessageListen() =>
      FirebaseMessaging.onMessage.listen((final RemoteMessage message) async {
        await LocalNotificationsHelper.show(
          id: message.hashCode,
          title: message.notification?.title ?? '',
          body: message.notification?.body ?? '',
          payload: jsonEncode(message.data),
        );
      });

  @pragma('vm:entry-point')
  Future<void> handleBackgroundMessage(final RemoteMessage message) =>
      LocalNotificationsHelper.show(
        id: message.hashCode,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: jsonEncode(message.data),
      );

  Future<void> handleForegroundMessage(final RemoteMessage message) =>
      LocalNotificationsHelper.show(
        id: message.hashCode,
        title: message.notification?.title ?? '',
        body: message.notification?.body ?? '',
        payload: jsonEncode(message.data),
      );

  void _handleMessageOpenedApp(final RemoteMessage message) {
    // Navigate or process the payload

    // final data = message.data;

    // e.g., NavigationService.navigateTo(data['screen']);
  }

  Future<String?> _getToken({final String? vapidKey}) =>
      _fcm.getToken(vapidKey: vapidKey);

  Future<void> deleteToken() => _fcm.deleteToken();

  Future<String?> getAPNSToken() => _fcm.getAPNSToken();

  Future<NotificationSettings> getNotificationSettings() =>
      _fcm.getNotificationSettings();

  bool get isAutoInitEnabled => _fcm.isAutoInitEnabled;

  Stream<String> get onTokenRefresh => _fcm.onTokenRefresh;

  Future<void> subscribeToTopic(final String topic) =>
      _fcm.subscribeToTopic(topic);

  Future<void> unsubscribeFromTopic(final String topic) =>
      _fcm.unsubscribeFromTopic(topic);

  Future<void> setDeliveryMetricsExportToBigQuery({
    required final bool enabled,
  }) => _fcm.setDeliveryMetricsExportToBigQuery(enabled);
}

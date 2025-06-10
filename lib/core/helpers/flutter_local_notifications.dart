import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show
        AndroidFlutterLocalNotificationsPlugin,
        AndroidInitializationSettings,
        AndroidNotificationChannel,
        AndroidNotificationDetails,
        AndroidScheduleMode,
        DarwinInitializationSettings,
        DarwinNotificationDetails,
        FlutterLocalNotificationsPlugin,
        Importance,
        InitializationSettings,
        LinuxInitializationSettings,
        LinuxNotificationDetails,
        NotificationDetails,
        NotificationResponse,
        Priority,
        RepeatInterval,
        WindowsInitializationSettings,
        WindowsNotificationDetails;
import 'package:timezone/timezone.dart' show TZDateTime, local;

@immutable
sealed class LocalNotificationsHelper {
  const LocalNotificationsHelper();
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static const AndroidNotificationChannel _androidChannel =
      AndroidNotificationChannel(
        'high_importance_channel',
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.max,
      );

  static Future<void> init() async {
    const settings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
      macOS: DarwinInitializationSettings(),
      linux: LinuxInitializationSettings(defaultActionName: 'Open'),
      windows: WindowsInitializationSettings(
        appName: 'BaytAlhalwani',
        appUserModelId: 'com.halwani.app',
        guid: '{00000000-0000-0000-0000-000000000000}',
      ),
    );
    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: _onSelectNotification,
      onDidReceiveBackgroundNotificationResponse: _onSelectNotification,
    );
    final AndroidFlutterLocalNotificationsPlugin? androidImpl = _plugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();
    if (androidImpl != null) {
      return androidImpl.createNotificationChannel(_androidChannel);
    }
  }

  static Future<void> show({
    required final int id,
    required final String? title,
    required final String? body,
    final String? payload,
  }) => _plugin.show(
    id,
    title,
    body,
    NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: const DarwinNotificationDetails(),
      macOS: const DarwinNotificationDetails(),
      linux: const LinuxNotificationDetails(),
      windows: const WindowsNotificationDetails(),
    ),
    payload: payload,
  );

  static void _onSelectNotification(final NotificationResponse resp) {
    final String? payload = resp.payload;
    if (payload != null) {
      // Navigate based on payload
    }
  }

  static Future<void> schedule({
    required final int id,
    required final String title,
    required final String body,
    required final DateTime scheduledDate,
    final String? payload,
  }) => _plugin.zonedSchedule(
    id,
    title,
    body,
    TZDateTime.from(scheduledDate, local),
    NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exact,
    payload: payload,
  );

  static Future<void> periodically({
    required final int id,
    required final String title,
    required final String body,
    required final RepeatInterval interval,
    final String? payload,
  }) => _plugin.periodicallyShow(
    id,
    title,
    body,
    interval,
    NotificationDetails(
      android: AndroidNotificationDetails(
        _androidChannel.id,
        _androidChannel.name,
        channelDescription: _androidChannel.description,
      ),
    ),
    androidScheduleMode: AndroidScheduleMode.exact,
    payload: payload,
  );
  static Future<void> cancel(final int id) => _plugin.cancel(id);
  static Future<void> cancelAll() => _plugin.cancelAll();
}

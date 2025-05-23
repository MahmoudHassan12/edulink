import 'dart:developer';

import 'package:edu_link/core/helpers/bloc_observe.dart' show BlocObserve;
import 'package:edu_link/core/helpers/notification_handler.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:edu_link/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:edu_link/main_app.dart' show MainApp;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:firebase_messaging/firebase_messaging.dart'
    show FirebaseMessaging, RemoteMessage;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:smart_notification_manager/core/models/config/local_notifier_config.dart'
    show LocalNotificationConfig;
import 'package:smart_notification_manager/core/models/config/push_notifier_config.dart'
    show PushNotificationConfig;
import 'package:smart_notification_manager/core/services/notifier_setup/local_notifier_setup.dart'
    show LocalNotifierSetup;
import 'package:smart_notification_manager/core/services/notifier_setup/push_notifier_setup.dart'
    show PushNotificationSetup;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  const BlocObserve().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefSingleton.init();
  await SupabaseService.init();
  //await NotificationService.init();

  await requestNotificationPermissions();
  await setupNotificationTapHandler();

  Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
    await Firebase.initializeApp();
    log('Handling a background message: ${message.messageId}');
  }

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  await LocalNotifierSetup().initialize(
    config: LocalNotificationConfig(
      isInDebugMode: true,
      onBgNotifResponse: (details) {
        log('Tapped notification in background: $details');
      },
      onNotifResponse: (details) {
        log(' Notification: $details');
      },
      onError: () {
        log('Error on Init');
      },
      onSucess: () {
        log('Success on Init');
      },
    ),
  );

  PushNotificationSetup().initialize(
    config: PushNotificationConfig(
      backgroundHandler: (message) async {
        log('BG: ${message.notification?.title}');
      },
      forgroundHandler: (message) {
        log('FG: ${message?.notification?.title}');
      },
    ),
  );
  runApp(
    BlocProvider(create: (context) => HomeCubit(), child: const MainApp()),
  );
}

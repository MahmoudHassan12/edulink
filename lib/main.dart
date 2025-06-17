import 'package:edu_link/core/helpers/bloc_observe.dart' show BlocObserve;
import 'package:edu_link/core/helpers/flutter_local_notifications.dart'
    show LocalNotificationsHelper;
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
import 'package:edu_link/features/chat/presentation/controllers/cubit/chat_list_cubit.dart';
import 'package:edu_link/features/home/presentation/controllers/home_cubit/home_cubit.dart';
import 'package:edu_link/features/settings/presentation/controllers/theme_modes_cubit/theme_modes_cubit.dart';
import 'package:edu_link/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:edu_link/main_app.dart' show MainApp;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart'
    show BlocProvider, MultiBlocProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefSingleton.init();
  await SupabaseService.init();
  const BlocObserve().init();

  await LocalNotificationsHelper.init();

  // await requestNotificationPermissions();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ChatListCubit>(create: (_) => ChatListCubit()),
        BlocProvider<ThemeModesCubit>(create: (_) => ThemeModesCubit()),
        BlocProvider<SeedColorsCubit>(create: (_) => SeedColorsCubit()),
        BlocProvider<HomeCubit>(create: (_) => HomeCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

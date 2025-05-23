import 'package:edu_link/core/helpers/bloc_observe.dart' show BlocObserve;
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/core/services/supabase_service.dart'
    show SupabaseService;
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
  const BlocObserve().init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefSingleton.init();
  await SupabaseService.init();
  //await NotificationService.init();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<ThemeModesCubit>(create: (context) => ThemeModesCubit()),
        BlocProvider<SeedColorsCubit>(create: (context) => SeedColorsCubit()),
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
      ],
      child: const MainApp(),
    ),
  );
}

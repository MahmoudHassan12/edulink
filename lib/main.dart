import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:edu_link/main_app.dart' show MainApp;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefSingleton.init();
  await Supabase.initialize(
    url: 'https://guzgfwwwkkmosmhdphzv.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imd1emdmd3d3a2ttb3NtaGRwaHp2Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDI2Nzc3ODEsImV4cCI6MjA1ODI1Mzc4MX0.y1-p_E38RHE717Yu-9MaIJ_VGEW6e5vxqCcIewoI1RY',
  );
  runApp(
    BlocProvider<CoursesCubit>(
      create: (context) => CoursesCubit(),
      child: const MainApp(),
    ),
  );
}

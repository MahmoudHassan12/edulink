import 'package:edu_link/core/controllers/cubits/courses_cubit.dart/courses_cubit.dart';
import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:edu_link/main_app.dart' show MainApp;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefSingleton.init();
  runApp(
    BlocProvider<CoursesCubit>(
      create: (context) => CoursesCubit(),
      child: const MainApp(),
    ),
  );
}

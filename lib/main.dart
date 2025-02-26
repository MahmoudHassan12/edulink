import 'package:edu_link/core/helpers/shared_pref.dart';
import 'package:edu_link/features/auth/presentation/cubits/auth_cubit/auth_cubit.dart';
import 'package:edu_link/firebase_options.dart' show DefaultFirebaseOptions;
import 'package:edu_link/main_app.dart' show MainApp;
// import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart' show WidgetsFlutterBinding, runApp;
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPrefHelper.init();
  // await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  runApp(
    BlocProvider(create: (context) => AuthCubit(), child: const MainApp()),
  );
}

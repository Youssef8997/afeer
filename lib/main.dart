// ignore_for_file: depend_on_referenced_packages

import 'package:afeer/splash/splash_screen.dart';
import 'package:afeer/utls/dio.dart';
import 'package:afeer/utls/notfi_handelr.dart';
import 'package:afeer/utls/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'cuibt/app_cuibt.dart';
import 'data/local_data.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreference.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  DioHelper.init();
  FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);

  NotificationsHandler.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: MaterialApp(
          title: 'afeer',
          theme: lightTheme(),
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              "ar",
            ),
          ],
          locale: const Locale(
            "ar",
          )),
    );
  }
}

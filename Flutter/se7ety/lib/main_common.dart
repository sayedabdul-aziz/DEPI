import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/shared/bloc_observer.dart';
import 'package:se7ety/core/utils/themes.dart';
import 'package:se7ety/firebase_options.dart';
import 'package:se7ety/flavor_config.dart';

Future<void> mainCommon(FlavorEnvironment environment) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = MyBlocObserver();
  await SharedPref.init();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      locale: Locale('ar'),
      supportedLocales: [Locale('ar')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      routerConfig: Routes.routes,
      theme: AppThemes.lightTheme,
    );
  }
}

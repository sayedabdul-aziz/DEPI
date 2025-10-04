import 'dart:io';

import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/api/dio_provider.dart';
import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/core/shared/bloc_observer.dart';
import 'package:bookia/core/utils/themes.dart';
import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// localization
// 1) translation (languages)
// 2) Widget Delegate (Direction)

//flutter pub run easy_localization:generate -f keys -o locale_keys.g.dart

//flutter pub run easy_localization:generate \
// -S assets/translations \
//  -f keys \
//  -o locale_keys.g.dart

var localeName = Platform.localeName.split('_')[0];

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  await Future.value([DioProvider.init(), LocalHelper.init()]);

  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => EasyLocalization(
        supportedLocales: [Locale('en'), Locale('ar')],
        startLocale: Locale(localeName), // ar or en
        path: 'assets/translations',
        fallbackLocale: Locale('en'),
        child: MainApp(),
      ),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: Routes.routes,
      theme: AppThemes.lightTheme,
    );
  }
}

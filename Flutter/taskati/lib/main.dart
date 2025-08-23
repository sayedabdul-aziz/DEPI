import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/themes.dart';
import 'package:taskati/features/splash/splash_screen.dart';

Future<void> main() async {
  await Hive.initFlutter();
  await LocalHelper.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: LocalHelper.userBox.listenable(),
      builder: (context, box, child) {
        bool isDark = LocalHelper.getData(LocalHelper.kIsDark) ?? false;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
          theme: AppThemes.lightTheme,
          darkTheme: AppThemes.darkTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}

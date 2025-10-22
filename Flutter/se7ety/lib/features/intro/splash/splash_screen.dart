import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:se7ety/core/constants/app_images.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    bool isOnBoardingShown = SharedPref.getIsOnBoardingShown() ?? false;
    String? userType =
        FirebaseAuth.instance.currentUser?.photoURL; // null or 1 or 2
    Future.delayed(const Duration(seconds: 2), () {
      if (userType != null) {
        if (userType == '1') {
          pushToBase(context, Routes.mainPatient);
        } else {
          // pushToBase(context, Routes.mainPatient);
        }
      } else if (isOnBoardingShown) {
        pushWithReplacement(context, Routes.welcome);
      } else {
        pushWithReplacement(context, Routes.onboarding);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Image.asset(AppImages.logo, width: 250)),
    );
  }
}

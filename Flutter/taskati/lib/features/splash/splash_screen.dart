import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lottie/lottie.dart';
import 'package:taskati/core/extentions/navigation.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/text_styles.dart';
import 'package:taskati/features/home/page/home_screen.dart';
import 'package:taskati/features/upload/upload_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    var isUpload = LocalHelper.getData(LocalHelper.kIsUpload) ?? false;
    Future.delayed(const Duration(seconds: 3), () {
      pushWithReplacement(context, isUpload ? HomeScreen() : UploadScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // spacing: 20,
          children: [
            // image
            Lottie.asset('assets/images/logo.json', width: 250),
            Text('Taskati', style: TextStyles.getTitle()),
            Gap(10),
            Text('It\'s time to be organized!', style: TextStyles.getBody()),
          ],
        ),
      ),
    );
  }
}

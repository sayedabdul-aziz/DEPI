import 'package:bookia/components/buttons/main_button.dart';
import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.welcomeBg,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
          ),

          Positioned(
            left: 22,
            right: 22,
            top: 0,
            bottom: 80,
            child: Column(
              children: [
                Spacer(),
                SvgPicture.asset(AppImages.logoSvg, width: 250),
                Gap(20),
                Text('Order Your Book Now!', style: TextStyles.getSize18()),
                Spacer(flex: 2),
                MainButton(
                  text: 'Login',
                  onPressed: () {
                    pushTo(context, Routes.login);
                  },
                ),
                Gap(15),
                MainButton(
                  text: 'Sign Up',
                  onPressed: () {
                    pushTo(context, Routes.register);
                  },
                  bgColor: AppColors.whiteColor,
                  textColor: AppColors.darkColor,
                  borderColor: AppColors.darkColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

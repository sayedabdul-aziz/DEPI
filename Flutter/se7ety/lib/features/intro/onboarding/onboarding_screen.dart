import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:se7ety/components/buttons/main_button.dart';
import 'package:se7ety/core/routes/navigation.dart';
import 'package:se7ety/core/routes/routes.dart';
import 'package:se7ety/core/services/local/shared_pref.dart';
import 'package:se7ety/core/utils/colors.dart';
import 'package:se7ety/core/utils/text_styles.dart';
import 'package:se7ety/features/intro/onboarding/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var controller = PageController();
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        actions: [
          if (currentPage != 2)
            TextButton(
              onPressed: () {
                SharedPref.isOnBoardingShown(true);
                pushWithReplacement(context, Routes.welcome);
              },
              child: Text(
                'تخطي',
                style: TextStyles.body.copyWith(color: AppColors.primaryColor),
              ),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (index) {
                  setState(() {
                    currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Spacer(),
                      SvgPicture.asset(onboardingList[index].image, width: 300),
                      Spacer(),
                      Text(
                        onboardingList[index].title,
                        style: TextStyles.title,
                      ),
                      Gap(20),
                      Text(
                        onboardingList[index].description,
                        style: TextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                      Spacer(flex: 3),
                    ],
                  );
                },
                itemCount: onboardingList.length,
              ),
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: onboardingList.length,
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                    effect: ExpandingDotsEffect(
                      activeDotColor: AppColors.primaryColor,
                      dotColor: AppColors.greyColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: 5,
                    ),
                  ),
                  if (currentPage == 2)
                    MainButton(
                      width: 100,
                      height: 45,
                      text: 'هيا بنا',
                      onPressed: () {
                        SharedPref.isOnBoardingShown(true);
                        pushWithReplacement(context, Routes.welcome);
                      },
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

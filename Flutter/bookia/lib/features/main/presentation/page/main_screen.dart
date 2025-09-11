import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: HomeScreen(), bottomNavigationBar: _buildNavBar());
  }

  BottomNavigationBar _buildNavBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.homeSvg),
          activeIcon: SvgPicture.asset(
            AppImages.homeSvg,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.wishlistSvg),
          activeIcon: SvgPicture.asset(
            AppImages.wishlistSvg,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: 'Wishlist',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.cartSvg),
          activeIcon: SvgPicture.asset(
            AppImages.cartSvg,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(AppImages.profileSvg),
          activeIcon: SvgPicture.asset(
            AppImages.profileSvg,
            colorFilter: ColorFilter.mode(
              AppColors.primaryColor,
              BlendMode.srcIn,
            ),
          ),
          label: 'Profile',
        ),
      ],
      currentIndex: currentIndex,
      onTap: (index) {
        setState(() {
          currentIndex = index;
        });
      },
    );
  }
}

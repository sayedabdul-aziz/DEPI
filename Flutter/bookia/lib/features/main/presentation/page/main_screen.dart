import 'dart:developer';

import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/features/cart/presentation/page/cart_screen.dart';
import 'package:bookia/features/home/presentation/home/page/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key, this.initialIndex});
  final int? initialIndex;

  @override
  State<MainAppScreen> createState() => _MainAppScreenState();
}

class _MainAppScreenState extends State<MainAppScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex ?? 0;
  }

  @override
  void didUpdateWidget(covariant MainAppScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    currentIndex = widget.initialIndex ?? 0;
  }

  List<Widget> screens = [
    HomeScreen(),
    WishlistScreen(),
    CartScreen(),
    HomeScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    log(LocalHelper.getUserData()?.token ?? "");
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: _buildNavBar(),
    );
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

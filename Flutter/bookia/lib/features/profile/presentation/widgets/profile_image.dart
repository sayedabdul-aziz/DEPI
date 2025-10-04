import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.asset(
                AppImages.welcomeBg,
                width: 121,
                height: 121,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              bottom: -5,
              right: -5,
              child: IconButton(
                onPressed: () {},
                icon: Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.whiteColor,
                  ),

                  child: SvgPicture.asset(AppImages.cameraSvg),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

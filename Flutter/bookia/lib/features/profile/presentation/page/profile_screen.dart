import 'dart:developer';

import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/local_helper.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    log('profile screen');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(AppImages.logoutSvg),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(children: [ProfileHeader()]),
      ),
    );
  }
}

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({super.key});

  @override
  State<ProfileHeader> createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {
  @override
  Widget build(BuildContext context) {
    var userData = LocalHelper.getUserData();
    return Row(
      children: [
        ClipOval(
          child: CachedNetworkImage(
            imageUrl: userData?.image ?? '',
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
        Gap(13),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                userData?.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.getSize18(fontSize: 20),
              ),
              Gap(6),
              Text(
                userData?.email ?? '',
                style: TextStyles.getSize12(color: AppColors.greyColor),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: () {
            pushTo(context, Routes.editProfile).then((value) {
              setState(() {});
              // call any method in cubit
            });
          },
          icon: Icon(Icons.edit),
        ),
      ],
    );
  }
}

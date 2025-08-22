import 'dart:io';

import 'package:flutter/material.dart';
import 'package:taskati/core/services/local_helper.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${(LocalHelper.getData(LocalHelper.kName) as String).split(' ').first}',
                style: TextStyles.getTitle(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text('Have a Nice Day', style: TextStyles.getBody()),
            ],
          ),
        ),
        CircleAvatar(
          radius: 24,
          backgroundColor: AppColors.primaryColor,
          child: CircleAvatar(
            radius: 22,
            backgroundImage: LocalHelper.getData(LocalHelper.kImage) != null
                ? FileImage(File(LocalHelper.getData(LocalHelper.kImage)))
                : AssetImage('assets/images/user.png'),
          ),
        ),
      ],
    );
  }
}

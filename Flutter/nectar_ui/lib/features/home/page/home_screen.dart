import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nectar_ui/core/constants/app_assets.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';
import 'package:nectar_ui/features/home/widgets/all_orders_builder.dart';
import 'package:nectar_ui/features/home/widgets/recent_orders.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SvgPicture.asset(
          AppAssets.logoSvg,
          width: 140,
          colorFilter: ColorFilter.mode(
            AppColors.primaryColor,
            BlendMode.srcIn,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              RecentOrdersBuilder(),
              SizedBox(height: 20),
              AllOrdersBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}

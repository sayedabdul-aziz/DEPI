import 'package:bookia/core/constants/app_images.dart';
import 'package:bookia/core/routes/navigation.dart';
import 'package:flutter/material.dart';

class AppBarWithBack extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWithBack({super.key, this.actionWidget});

  final Widget? actionWidget;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      automaticallyImplyLeading: false,
      title: GestureDetector(
        onTap: () {
          pop(context);
        },
        child: Image.asset(AppImages.back, width: 41, height: 41),
      ),
      actions: [actionWidget ?? const SizedBox()],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

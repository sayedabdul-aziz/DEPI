import 'package:bookia/core/constants/app_fonts.dart';
import 'package:bookia/core/utils/colors.dart';
import 'package:bookia/core/utils/text_styles.dart';
import 'package:flutter/material.dart';

class AppThemes {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.whiteColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.whiteColor,
      foregroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyles.getSize24(color: AppColors.primaryColor),
    ),
    fontFamily: AppFonts.dMSerifDisplayFont,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.whiteColor,
      showUnselectedLabels: false,
      showSelectedLabels: false,
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: AppColors.darkColor,
      ),
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.accentColor,
      hintStyle: TextStyles.getSize16(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

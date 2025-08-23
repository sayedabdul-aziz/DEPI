import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';
import 'package:taskati/core/utils/text_styles.dart';

class AppThemes {
  static get lightTheme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyles.getTitle(color: AppColors.primaryColor),
    ),
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.darkColor,
    ),
    datePickerTheme: DatePickerThemeData(backgroundColor: Colors.white),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getBody(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
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
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  static get darkTheme => ThemeData(
    scaffoldBackgroundColor: AppColors.darkColor,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.darkColor,
      foregroundColor: AppColors.primaryColor,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: TextStyles.getTitle(color: AppColors.primaryColor),
    ),
    fontFamily: 'Poppins',
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      onSurface: AppColors.whiteColor,
    ),
    datePickerTheme: DatePickerThemeData(
      backgroundColor: AppColors.darkColor,
      headerForegroundColor: AppColors.primaryColor,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: AppColors.darkColor,
      dialBackgroundColor: AppColors.darkColor,
      hourMinuteColor: AppColors.darkColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyles.getBody(color: AppColors.greyColor),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
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
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}

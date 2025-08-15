import 'package:flutter/material.dart';
import 'package:nectar_ui/core/utils/app_colors.dart';

class TextStyles {
  getHeadline({
    Color color = AppColors.darkColor,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 24,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static TextStyle getTitle({
    Color color = AppColors.darkColor,
    FontWeight fontWeight = FontWeight.w600,
    double fontSize = 18,
  }) {
    return TextStyle(fontSize: fontSize, fontWeight: fontWeight, color: color);
  }

  static TextStyle getBody({
    double fontSize = 16,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.darkColor,
    );
  }

  static TextStyle getSmall({
    double fontSize = 14,
    FontWeight? fontWeight,
    Color? color,
  }) {
    return TextStyle(
      fontSize: fontSize,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.darkColor,
    );
  }
}

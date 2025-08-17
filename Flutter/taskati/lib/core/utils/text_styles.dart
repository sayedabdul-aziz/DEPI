import 'package:flutter/material.dart';
import 'package:taskati/core/utils/colors.dart';

class TextStyles {
  static TextStyle getTitle({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 18,
      fontWeight: fontWeight ?? FontWeight.bold,
      color: color ?? AppColors.darkColor,
    );
  }

  static TextStyle getBody({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.darkColor,
    );
  }

  static TextStyle getSmall({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(
      fontSize: fontSize ?? 14,
      fontWeight: fontWeight ?? FontWeight.normal,
      color: color ?? AppColors.greyColor,
    );
  }
}

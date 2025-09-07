import 'package:flutter/material.dart';

class TextStyles {
  static TextStyle getSize30({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 30, color: color);
  }

  static TextStyle getSize26({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 26, color: color);
  }

  static TextStyle getSize24({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 24, color: color);
  }

  static TextStyle getSize18({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 18, color: color);
  }

  static TextStyle getSize16({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 16, color: color);
  }

  static TextStyle getSize12({
    Color? color,
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    return TextStyle(fontSize: fontSize ?? 12, color: color);
  }
}

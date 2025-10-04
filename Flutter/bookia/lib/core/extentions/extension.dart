import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension LocalizationExtension on BuildContext {
  bool get isArabic => locale.languageCode == 'ar';
}

// Push(context, route), // method
// context.push(route), // extension

// SizedBox(height: 20)
// verticalSpace(20)
// 20.h,

verticalSpace(double height) {
  return SizedBox(height: height);
}

extension SizedBoxEx on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}

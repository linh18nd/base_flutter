import 'package:base_flutter/core/utils/screen_util_extensions.dart';
import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF1565C0);
  static const Color primaryDark = Color(0xFF003c8f);
  static const Color primaryLight = Color(0xFF5e92f3);

  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;

  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFF9A825);
  static const Color error = Color(0xFFD32F2F);
}

class AppTextStyle {
  static TextStyle common(
    double? fontSize,
    FontWeight? fontWeight,
    Color? color, [
    TextDecoration? decoration = TextDecoration.none,
    double? height = 1.25,
  ]) {
    return TextStyle(
      color: color,
      fontWeight: fontWeight,
      fontSize: fontSize?.sp,
      decoration: decoration,
      height: height,
      fontFamily: 'NotoSansJP',
    );
  }

  static TextStyle t10w400([Color? color, double? height]) {
    return common(10, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w400([Color? color, double? height]) {
    return common(12, FontWeight.w400, color, null, height);
  }

  static TextStyle t12w500([Color? color, double? height]) {
    return common(12, FontWeight.w500, color, null, height);
  }

  static TextStyle t12w700([Color? color, double? height]) {
    return common(12, FontWeight.w700, color, null, height);
  }

  static TextStyle t14w400([Color? color, double? height]) {
    return common(14, FontWeight.w400, color, null, height);
  }

  static TextStyle t14w500([Color? color, double? height]) {
    return common(14, FontWeight.w500, color, null, height);
  }

  static TextStyle t14w700([Color? color, double? height]) {
    return common(14, FontWeight.w700, color, null, height);
  }

  static TextStyle t16w400([Color? color, double? height]) {
    return common(16, FontWeight.w400, color, null, height);
  }

  static TextStyle t16w500([Color? color, double? height]) {
    return common(16, FontWeight.w500, color, null, height);
  }

  static TextStyle t16w700([Color? color, double? height]) {
    return common(16, FontWeight.w700, color, null, height);
  }

  static TextStyle t18w400([Color? color, double? height]) {
    return common(18, FontWeight.w400, color, null, height);
  }

  static TextStyle t18w700([Color? color, double? height]) {
    return common(18, FontWeight.w700, color, null, height);
  }

  static TextStyle t20w700([Color? color, double? height]) {
    return common(20, FontWeight.w700, color, null, height);
  }

  static TextStyle t24w400([Color? color, double? height]) {
    return common(24, FontWeight.w400, color, null, height);
  }

  static TextStyle t24w700([Color? color, double? height]) {
    return common(24, FontWeight.w700, color, null, height);
  }

  static TextStyle t28w700([Color? color, double? height]) {
    return common(28, FontWeight.w700, color, null, height);
  }

  static TextStyle t32w700([Color? color, double? height]) {
    return common(32, FontWeight.w700, color, null, height);
  }
}

import 'package:ayletna_restaurant_app/core/core_fonts.dart';
import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

/// Viewport-scaled text styles.
abstract final class CoreTypography {
  static TextStyle headlineLarge(BuildContext context, Color color) {
    final size = UtilitySizer.band(context, 30, 36, 42);
    return _base(
      fontSize: size,
      fontWeight: FontWeight.w800,
      height: 1.08,
      letterSpacing: -0.35,
      color: color,
    );
  }

  static TextStyle headlineSmall(BuildContext context, Color color) {
    final size = UtilitySizer.band(context, 22, 24, 27);
    return _base(
      fontSize: size,
      fontWeight: FontWeight.w700,
      height: 1.18,
      letterSpacing: -0.15,
      color: color,
    );
  }

  static TextStyle titleMedium(BuildContext context, Color color) {
    final size = UtilitySizer.band(context, 16, 18, 20);
    return _base(
      fontSize: size,
      fontWeight: FontWeight.w600,
      height: 1.24,
      color: color,
    );
  }

  static TextStyle bodyMedium(BuildContext context, Color color) {
    final size = UtilitySizer.band(context, 14, 15, 16);
    return _base(
      fontSize: size,
      fontWeight: FontWeight.w400,
      height: 1.58,
      color: color,
    );
  }

  static TextStyle caption(BuildContext context, Color color) {
    final size = UtilitySizer.band(context, 11.5, 12, 13);
    return _base(
      fontSize: size,
      fontWeight: FontWeight.w500,
      height: 1.34,
      letterSpacing: 0.08,
      color: color,
    );
  }

  static TextStyle link(BuildContext context, Color color) {
    return bodyMedium(context, color).copyWith(
      fontWeight: FontWeight.w600,
      decoration: TextDecoration.underline,
      decorationColor: color,
    );
  }

  static TextStyle muted(BuildContext context, {required bool isDark}) {
    final base =
        isDark ? CoreColors.textSecondaryDark : CoreColors.textSecondaryLight;
    return titleMedium(context, base.withAlpha65);
  }

  static TextStyle _base({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return CoreFonts.style(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      height: height,
      letterSpacing: letterSpacing,
    );
  }

}

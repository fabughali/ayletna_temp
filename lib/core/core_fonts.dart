import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// App-wide font loading via Google Fonts (Latin + Arabic fallback).
abstract final class CoreFonts {
  static const _arabicFallback = ['Noto Sans Arabic'];

  static TextStyle style({
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    double? height,
    double? letterSpacing,
  }) {
    return GoogleFonts.notoSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      height: height,
      letterSpacing: letterSpacing,
      color: color,
    ).copyWith(fontFamilyFallback: _arabicFallback);
  }

  static TextTheme textTheme(TextTheme base, Color onSurface) {
    return GoogleFonts.notoSansTextTheme(base).apply(
      bodyColor: onSurface,
      displayColor: onSurface,
      fontFamilyFallback: _arabicFallback,
    );
  }
}

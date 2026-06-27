import 'dart:ui' show lerpDouble;

import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:flutter/material.dart';

@immutable
class CoreThemeExtensions extends ThemeExtension<CoreThemeExtensions> {
  const CoreThemeExtensions({
    required this.buttonMinHeight,
    required this.buttonPaddingH,
    required this.iconButtonSize,
    required this.splashGradientTop,
    required this.splashGradientBottom,
    required this.dividerAccentWidth,
  });

  final double buttonMinHeight;
  final double buttonPaddingH;
  final double iconButtonSize;
  final Color splashGradientTop;
  final Color splashGradientBottom;
  final double dividerAccentWidth;

  @override
  CoreThemeExtensions copyWith({
    double? buttonMinHeight,
    double? buttonPaddingH,
    double? iconButtonSize,
    Color? splashGradientTop,
    Color? splashGradientBottom,
    double? dividerAccentWidth,
  }) {
    return CoreThemeExtensions(
      buttonMinHeight: buttonMinHeight ?? this.buttonMinHeight,
      buttonPaddingH: buttonPaddingH ?? this.buttonPaddingH,
      iconButtonSize: iconButtonSize ?? this.iconButtonSize,
      splashGradientTop: splashGradientTop ?? this.splashGradientTop,
      splashGradientBottom: splashGradientBottom ?? this.splashGradientBottom,
      dividerAccentWidth: dividerAccentWidth ?? this.dividerAccentWidth,
    );
  }

  @override
  CoreThemeExtensions lerp(
    ThemeExtension<CoreThemeExtensions>? other,
    double t,
  ) {
    if (other is! CoreThemeExtensions) {
      return this;
    }
    return CoreThemeExtensions(
      buttonMinHeight:
          lerpDouble(buttonMinHeight, other.buttonMinHeight, t) ??
          buttonMinHeight,
      buttonPaddingH:
          lerpDouble(buttonPaddingH, other.buttonPaddingH, t) ?? buttonPaddingH,
      iconButtonSize:
          lerpDouble(iconButtonSize, other.iconButtonSize, t) ?? iconButtonSize,
      splashGradientTop:
          Color.lerp(splashGradientTop, other.splashGradientTop, t) ??
          splashGradientTop,
      splashGradientBottom:
          Color.lerp(splashGradientBottom, other.splashGradientBottom, t) ??
          splashGradientBottom,
      dividerAccentWidth:
          lerpDouble(dividerAccentWidth, other.dividerAccentWidth, t) ??
          dividerAccentWidth,
    );
  }

  static CoreThemeExtensions forBand(ContentBand band, bool isDark) {
    final buttonH = switch (band) {
      ContentBand.mobile => 48.0,
      ContentBand.tablet => 50.0,
      ContentBand.web => 52.0,
    };
    final padH = switch (band) {
      ContentBand.mobile => 20.0,
      ContentBand.tablet => 24.0,
      ContentBand.web => 28.0,
    };
    final iconButtonSize = buttonH;
    if (isDark) {
      return CoreThemeExtensions(
        buttonMinHeight: buttonH,
        buttonPaddingH: padH,
        iconButtonSize: iconButtonSize,
        splashGradientTop: CoreColors.surfaceDark,
        splashGradientBottom: CoreColors.cardDark,
        dividerAccentWidth: 72,
      );
    }
    return CoreThemeExtensions(
      buttonMinHeight: buttonH,
      buttonPaddingH: padH,
      iconButtonSize: iconButtonSize,
      splashGradientTop: CoreColors.backgroundLight,
      splashGradientBottom: CoreColors.splashGradientBottomLight,
      dividerAccentWidth: 72,
    );
  }
}

extension CoreThemeExtensionsX on BuildContext {
  CoreThemeExtensions get coreTheme =>
      Theme.of(this).extension<CoreThemeExtensions>()!;
}

/// Band-aware button metrics (ui_design_prompt).
abstract final class CoreButtonStyles {
  static double minHeight(ContentBand band) => switch (band) {
    ContentBand.mobile => 48,
    ContentBand.tablet => 50,
    ContentBand.web => 52,
  };
}

/// Typography aliases for theme layer.
abstract final class CoreTextStyles {
  static TextStyle headline(BuildContext context, Color color) =>
      CoreTypography.headlineSmall(context, color);

  static TextStyle body(BuildContext context, Color color) =>
      CoreTypography.bodyMedium(context, color);
}

/// OTP cell sizing per content band.
abstract final class CoreOtpStyle {
  static double cellSize(ContentBand band) => switch (band) {
    ContentBand.mobile => 44,
    ContentBand.tablet => 48,
    ContentBand.web => 52,
  };
}

/// Shared Material decorations (inputs, cards).
abstract final class CoreDecorations {
  static InputDecoration input(
    BuildContext context, {
    required String label,
    IconData? icon,
  }) {
    return InputDecoration(
      labelText: label,
      prefixIcon: icon != null ? Icon(icon) : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusInput),
      ),
    );
  }
}

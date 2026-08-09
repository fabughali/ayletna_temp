import 'dart:ui' show lerpDouble;

import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_typography.dart';
import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
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
    final width = switch (band) {
      ContentBand.mobile => UtilitySizer.designWidth,
      ContentBand.tablet => 768.0,
      ContentBand.web => 1280.0,
    };
    return forWidth(width, isDark);
  }

  /// Viewport-scaled button / icon-button metrics.
  static CoreThemeExtensions forWidth(double width, bool isDark) {
    final buttonH = UtilitySizer.bandForWidth(width, 44, 50, 52);
    final padH = UtilitySizer.bandForWidth(width, 16, 24, 28);
    final iconButtonSize = buttonH;
    if (isDark) {
      return CoreThemeExtensions(
        buttonMinHeight: buttonH,
        buttonPaddingH: padH,
        iconButtonSize: iconButtonSize,
        splashGradientTop: CoreColors.surfaceDark,
        splashGradientBottom: CoreColors.cardDark,
        dividerAccentWidth: UtilitySizer.ofWidth(width, 72),
      );
    }
    return CoreThemeExtensions(
      buttonMinHeight: buttonH,
      buttonPaddingH: padH,
      iconButtonSize: iconButtonSize,
      splashGradientTop: CoreColors.backgroundLight,
      splashGradientBottom: CoreColors.splashGradientBottomLight,
      dividerAccentWidth: UtilitySizer.ofWidth(width, 72),
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
    ContentBand.mobile => UtilitySizer.bandForWidth(UtilitySizer.designWidth, 44, 50, 52),
    ContentBand.tablet => UtilitySizer.bandForWidth(768, 44, 50, 52),
    ContentBand.web => UtilitySizer.bandForWidth(1280, 44, 50, 52),
  };

  static double minHeightOf(BuildContext context) =>
      UtilitySizer.band(context, 44, 50, 52);
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

  static double cellSizeOf(BuildContext context) =>
      UtilitySizer.band(context, 40, 48, 52);
}

/// Shared Material decorations (inputs, cards).
abstract final class CoreDecorations {
  /// Vertical padding so a single-line field matches [CoreThemeExtensions.buttonMinHeight].
  static EdgeInsets inputContentPadding(BuildContext context) {
    final controlH = context.coreTheme.buttonMinHeight;
    final lineH = UtilitySizer.band(context, 20, 22, 24);
    final vertical = ((controlH - lineH) / 2).clamp(10.0, 18.0);
    return EdgeInsets.symmetric(
      horizontal: UtilitySizer.of(context, 16),
      vertical: vertical,
    );
  }

  static InputDecoration input(
    BuildContext context, {
    required String label,
    IconData? icon,
    bool showLabel = true,
    bool matchControlHeight = true,
  }) {
    final controlH = context.coreTheme.buttonMinHeight;
    return InputDecoration(
      isDense: true,
      labelText: showLabel ? label : null,
      floatingLabelBehavior:
          showLabel
              ? FloatingLabelBehavior.auto
              : FloatingLabelBehavior.never,
      prefixIcon:
          icon != null
              ? Icon(icon, size: UtilitySizer.of(context, 22))
              : null,
      contentPadding: inputContentPadding(context),
      constraints:
          matchControlHeight
              ? BoxConstraints(minHeight: controlH)
              : null,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(CoreSpacing.radiusInputOf(context)),
      ),
    );
  }
}

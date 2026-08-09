import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/core/core_fonts.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_theme_extensions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

export 'core_colors.dart';
export 'core_color_scheme.dart';
export 'core_content_sizes.dart';
export 'core_spacing.dart';
export 'core_theme_extensions.dart';
export 'core_typography.dart';

/// Role-aware Material 3 themes (ui_design_prompt · color_list).
abstract final class CoreTheme {
  static ThemeData themeFor(
    AppRole role,
    Brightness brightness, {
    double? width,
  }) {
    final resolvedWidth = width ?? UtilitySizer.designWidth;
    final isDark = brightness == Brightness.dark;
    final scheme = CoreColorScheme.build(role: role, brightness: brightness);
    final extensions = CoreThemeExtensions.forWidth(resolvedWidth, isDark);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: _scaffoldBackground(role, isDark),
      extensions: [extensions],
      textTheme: _scaledTextTheme(resolvedWidth, scheme.onSurface, brightness),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(0, extensions.buttonMinHeight),
          maximumSize: Size(double.infinity, extensions.buttonMinHeight),
          fixedSize: Size.fromHeight(extensions.buttonMinHeight),
          padding: EdgeInsets.symmetric(horizontal: extensions.buttonPaddingH),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: CoreFonts.style(
            fontSize: UtilitySizer.bandForWidth(resolvedWidth, 14, 15, 16),
            fontWeight: FontWeight.w700,
            color: scheme.onPrimary,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              UtilitySizer.ofWidth(resolvedWidth, CoreSpacing.radiusButton),
            ),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: Size(0, extensions.buttonMinHeight),
          maximumSize: Size(double.infinity, extensions.buttonMinHeight),
          fixedSize: Size.fromHeight(extensions.buttonMinHeight),
          padding: EdgeInsets.symmetric(horizontal: extensions.buttonPaddingH),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          minimumSize: Size(0, extensions.buttonMinHeight),
          maximumSize: Size(double.infinity, extensions.buttonMinHeight),
          fixedSize: Size.fromHeight(extensions.buttonMinHeight),
          padding: EdgeInsets.symmetric(horizontal: extensions.buttonPaddingH),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          // Soft minimum only — never lock fixed/max size so compact controls
          // (steppers, chips, card actions) can shrink with UtilitySizer.
          minimumSize: Size.square(extensions.iconButtonSize * 0.75),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            UtilitySizer.ofWidth(resolvedWidth, 4),
          ),
        ),
        side: BorderSide(
          color: scheme.outlineVariant,
          width: UtilitySizer.ofWidth(resolvedWidth, 1.6),
        ),
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return scheme.outlineVariant.withValues(alpha: 0.32);
          }
          if (states.contains(WidgetState.selected)) {
            return CoreColors.brandOlive;
          }
          return scheme.surface;
        }),
        checkColor: WidgetStateProperty.all(scheme.surface),
        overlayColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed) ||
              states.contains(WidgetState.hovered) ||
              states.contains(WidgetState.focused)) {
            return CoreColors.brandOlive.withValues(alpha: 0.10);
          }
          return null;
        }),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: scheme.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            UtilitySizer.ofWidth(resolvedWidth, CoreSpacing.radiusCard),
          ),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        contentPadding: EdgeInsets.symmetric(
          horizontal: UtilitySizer.ofWidth(resolvedWidth, 16),
          vertical: ((extensions.buttonMinHeight -
                      UtilitySizer.bandForWidth(resolvedWidth, 20, 22, 24)) /
                  2)
              .clamp(0.0, 18.0),
        ),
        constraints: BoxConstraints(minHeight: extensions.buttonMinHeight),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            UtilitySizer.ofWidth(resolvedWidth, CoreSpacing.radiusInput),
          ),
        ),
        filled: true,
        fillColor: isDark ? CoreColors.cardDark : CoreColors.surfaceLight,
      ),
    );
  }

  static Color _scaffoldBackground(AppRole role, bool isDark) {
    if (isDark) {
      return switch (role) {
        AppRole.admin => const Color(0xFF0E1214),
        AppRole.operator => const Color(0xFF101418),
        AppRole.owner => const Color(0xFF15120D),
        AppRole.support => const Color(0xFF0F141A),
        AppRole.marketing => const Color(0xFF161018),
        AppRole.cashier => const Color(0xFF1A1410),
        AppRole.kitchen => const Color(0xFF1A1010),
        AppRole.delivery => const Color(0xFF0F141A),
        AppRole.inventory => const Color(0xFF101610),
        AppRole.staff => const Color(0xFF151018),
        AppRole.customer || AppRole.guest => CoreColors.backgroundDark,
      };
    }

    return switch (role) {
      AppRole.admin => const Color(0xFFF2F4F5),
      AppRole.operator => const Color(0xFFF4F6F8),
      AppRole.owner => const Color(0xFFFBF8F1),
      AppRole.support => const Color(0xFFF3F7FC),
      // Warm cream tint (not purple) — hub accent lives in tertiary only.
      AppRole.marketing => const Color(0xFFFFF8F2),
      AppRole.cashier => const Color(0xFFFFF8F0),
      // Pass-board light: cooler ink paper for ticket contrast (not soft cream).
      AppRole.kitchen => const Color(0xFFF3EBE6),
      AppRole.delivery => const Color(0xFFF4F9FF),
      AppRole.inventory => const Color(0xFFF4FFF4),
      AppRole.staff => const Color(0xFFF7F6F0),
      AppRole.customer || AppRole.guest => CoreColors.backgroundLight,
    };
  }

  /// Material text theme with UtilitySizer-scaled sizes (390 design width).
  static TextTheme _scaledTextTheme(
    double width,
    Color onSurface,
    Brightness brightness,
  ) {
    final base = CoreFonts.textTheme(
      ThemeData(brightness: brightness).textTheme,
      onSurface,
    );
    TextStyle scaled(
      double mobile,
      double tablet,
      double web, {
      FontWeight weight = FontWeight.w400,
      double height = 1.4,
    }) {
      return CoreFonts.style(
        fontSize: UtilitySizer.bandForWidth(width, mobile, tablet, web),
        fontWeight: weight,
        color: onSurface,
        height: height,
      );
    }

    return base.copyWith(
      displayLarge: scaled(30, 36, 42, weight: FontWeight.w800, height: 1.08),
      displayMedium: scaled(26, 30, 34, weight: FontWeight.w800, height: 1.1),
      displaySmall: scaled(22, 24, 27, weight: FontWeight.w700, height: 1.18),
      headlineLarge: scaled(30, 36, 42, weight: FontWeight.w800, height: 1.08),
      headlineMedium: scaled(24, 28, 32, weight: FontWeight.w700, height: 1.15),
      headlineSmall: scaled(22, 24, 27, weight: FontWeight.w700, height: 1.18),
      titleLarge: scaled(18, 20, 22, weight: FontWeight.w700, height: 1.22),
      titleMedium: scaled(16, 18, 20, weight: FontWeight.w600, height: 1.24),
      titleSmall: scaled(14, 15, 16, weight: FontWeight.w600, height: 1.28),
      bodyLarge: scaled(15, 16, 17, weight: FontWeight.w400, height: 1.5),
      bodyMedium: scaled(14, 15, 16, weight: FontWeight.w400, height: 1.58),
      bodySmall: scaled(12, 13, 14, weight: FontWeight.w400, height: 1.4),
      labelLarge: scaled(14, 15, 16, weight: FontWeight.w700, height: 1.2),
      labelMedium: scaled(12, 13, 14, weight: FontWeight.w600, height: 1.25),
      labelSmall: scaled(11, 12, 13, weight: FontWeight.w500, height: 1.3),
    );
  }
}

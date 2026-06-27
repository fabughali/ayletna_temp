import 'package:ayletna_restaurant_app/core/core_color_scheme.dart';
import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:ayletna_restaurant_app/core/core_fonts.dart';
import 'package:ayletna_restaurant_app/core/core_spacing.dart';
import 'package:ayletna_restaurant_app/core/core_theme_extensions.dart';
import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
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
    final band =
        width != null
            ? UtilityResponsiveBreakpoints.contentBandFromWidth(width)
            : ContentBand.mobile;
    final isDark = brightness == Brightness.dark;
    final scheme = CoreColorScheme.build(role: role, brightness: brightness);
    final extensions = CoreThemeExtensions.forBand(band, isDark);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      scaffoldBackgroundColor: _scaffoldBackground(role, isDark),
      extensions: [extensions],
      textTheme: CoreFonts.textTheme(
        ThemeData(brightness: brightness).textTheme,
        scheme.onSurface,
      ),
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size.fromHeight(extensions.buttonMinHeight),
          padding: EdgeInsets.symmetric(horizontal: extensions.buttonPaddingH),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CoreSpacing.radiusButton),
          ),
        ),
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          fixedSize: Size.square(extensions.iconButtonSize),
          minimumSize: Size.square(extensions.iconButtonSize),
          maximumSize: Size.square(extensions.iconButtonSize),
          padding: EdgeInsets.zero,
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        side: BorderSide(color: scheme.outlineVariant, width: 1.6),
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
          borderRadius: BorderRadius.circular(CoreSpacing.radiusCard),
          side: BorderSide(color: scheme.outline.withValues(alpha: 0.35)),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CoreSpacing.radiusInput),
        ),
        filled: true,
        fillColor: isDark ? CoreColors.cardDark : CoreColors.surfaceLight,
      ),
    );
  }

  static Color _scaffoldBackground(AppRole role, bool isDark) {
    if (isDark) {
      return switch (role) {
        AppRole.operator => const Color(0xFF101418),
        AppRole.owner => const Color(0xFF15120D),
        AppRole.cashier => const Color(0xFF1A1410),
        AppRole.kitchen => const Color(0xFF1A1010),
        AppRole.delivery => const Color(0xFF0F141A),
        AppRole.inventory => const Color(0xFF101610),
        AppRole.staff => const Color(0xFF151018),
        AppRole.customer || AppRole.guest => CoreColors.backgroundDark,
      };
    }

    return switch (role) {
      AppRole.operator => const Color(0xFFF4F6F8),
      AppRole.owner => const Color(0xFFFBF8F1),
      AppRole.cashier => const Color(0xFFFFF8F0),
      AppRole.kitchen => const Color(0xFFFFF5F5),
      AppRole.delivery => const Color(0xFFF4F9FF),
      AppRole.inventory => const Color(0xFFF4FFF4),
      AppRole.staff => const Color(0xFFFAF5FF),
      AppRole.customer || AppRole.guest => CoreColors.backgroundLight,
    };
  }
}

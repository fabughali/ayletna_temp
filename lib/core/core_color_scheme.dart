import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:flutter/material.dart';

/// PRD §3.1 roles for [CoreTheme.themeFor].
enum AppRole {
  customer,
  guest,
  owner,
  operator,
  admin,
  support,
  marketing,
  cashier,
  kitchen,
  delivery,
  inventory,
  staff,
}

/// PRD order types — colors from [CoreColors], not role primary.
enum OrderType { dineIn, takeaway, delivery, platedDelivery }

extension OrderTypeColors on OrderType {
  Color get color => switch (this) {
    OrderType.dineIn => CoreColors.orderTypeDineIn,
    OrderType.takeaway => CoreColors.orderTypeTakeaway,
    OrderType.delivery => CoreColors.orderTypeDelivery,
    OrderType.platedDelivery => CoreColors.orderTypePlated,
  };
}

class RolePalette {
  const RolePalette({
    required this.primary,
    required this.onPrimary,
    required this.secondary,
    required this.accent,
    required this.background,
    required this.surface,
  });

  final Color primary;
  final Color onPrimary;
  final Color secondary;
  /// Hub tint only (drawer header / tertiary) — never replaces brand primary.
  final Color accent;
  final Color background;
  final Color surface;
}

abstract final class CoreColorScheme {
  static ColorScheme build({
    required AppRole role,
    required Brightness brightness,
  }) {
    final palette = _paletteFor(role, brightness);
    final isDark = brightness == Brightness.dark;

    return ColorScheme(
      brightness: brightness,
      primary: palette.primary,
      onPrimary: palette.onPrimary,
      secondary: palette.secondary,
      onSecondary: isDark ? CoreColors.textPrimaryDark : Colors.white,
      tertiary: palette.accent,
      onTertiary: palette.onPrimary,
      error: CoreColors.semanticError,
      onError: Colors.white,
      surface: palette.surface,
      onSurface:
          isDark ? CoreColors.textPrimaryDark : CoreColors.textPrimaryLight,
      onSurfaceVariant:
          isDark ? CoreColors.textSecondaryDark : CoreColors.textSecondaryLight,
      outline: isDark ? CoreColors.dividerDark : CoreColors.dividerLight,
      surfaceContainerHighest:
          isDark ? CoreColors.cardDark : CoreColors.dividerLight,
    );
  }

  /// Hub accent for drawer header tint (DS §5). Brand primary stays gold.
  static Color hubAccentFor(AppRole role, Brightness brightness) {
    return _paletteFor(role, brightness).accent;
  }

  static RolePalette _brandBase({
    required Color hubAccent,
    required Brightness brightness,
    Color? backgroundLight,
  }) {
    final isDark = brightness == Brightness.dark;
    return RolePalette(
      primary: isDark ? CoreColors.brandGoldDarkUi : CoreColors.brandGold,
      onPrimary: isDark ? CoreColors.textPrimaryLight : CoreColors.brandBrown,
      secondary: isDark ? CoreColors.brandOliveLight : CoreColors.brandOlive,
      accent: hubAccent,
      background:
          isDark
              ? CoreColors.backgroundDark
              : (backgroundLight ?? CoreColors.backgroundLight),
      surface: isDark ? CoreColors.surfaceDark : CoreColors.surfaceLight,
    );
  }

  static RolePalette _paletteFor(AppRole role, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (role) {
      AppRole.customer || AppRole.guest => _brandBase(
        hubAccent: isDark ? CoreColors.brandOrange : CoreColors.brandOrange,
        brightness: brightness,
      ),
      AppRole.operator => _brandBase(
        hubAccent: isDark ? const Color(0xFF5B728A) : const Color(0xFF2C3E50),
        brightness: brightness,
        backgroundLight: const Color(0xFFF4F6F8),
      ),
      AppRole.owner => _brandBase(
        hubAccent: isDark ? const Color(0xFFC49A4E) : const Color(0xFF6A4E23),
        brightness: brightness,
        backgroundLight: const Color(0xFFFBF8F1),
      ),
      AppRole.admin => _brandBase(
        hubAccent:
            isDark ? CoreColors.hubAdminAccent : CoreColors.hubAdminAccentDark,
        brightness: brightness,
        backgroundLight: const Color(0xFFF2F4F5),
      ),
      AppRole.support => _brandBase(
        // DS Support hub `#1565C0` — must not collide with dine-in teal `#00897B`.
        hubAccent: isDark ? const Color(0xFF64B5F6) : const Color(0xFF1565C0),
        brightness: brightness,
        backgroundLight: const Color(0xFFF3F7FC),
      ),
      AppRole.marketing => _brandBase(
        // DS hub Marketing accent — tint only, not ColorScheme.primary.
        hubAccent: CoreColors.hubMarketingAccent,
        brightness: brightness,
        backgroundLight: const Color(0xFFFFF8F2),
      ),
      AppRole.cashier => _brandBase(
        hubAccent: isDark ? const Color(0xFFF39C3D) : const Color(0xFFE67E22),
        brightness: brightness,
        backgroundLight: const Color(0xFFFFF8F0),
      ),
      AppRole.kitchen => _brandBase(
        // Urgency as hub tint chips, not whole-app red primary.
        hubAccent: isDark ? const Color(0xFFEF5350) : const Color(0xFFC62828),
        brightness: brightness,
        backgroundLight: const Color(0xFFFFF8F5),
      ),
      AppRole.delivery => _brandBase(
        hubAccent: isDark ? const Color(0xFF64B5F6) : const Color(0xFF1565C0),
        brightness: brightness,
        backgroundLight: const Color(0xFFF4F9FF),
      ),
      AppRole.inventory => _brandBase(
        hubAccent: isDark ? const Color(0xFF66BB6A) : const Color(0xFF2E7D32),
        brightness: brightness,
        backgroundLight: const Color(0xFFF4FFF4),
      ),
      AppRole.staff => _brandBase(
        // Olive hub (avoid purple primary anti-pattern).
        hubAccent: isDark ? CoreColors.brandOliveLight : CoreColors.brandOlive,
        brightness: brightness,
        backgroundLight: const Color(0xFFF7F6F0),
      ),
    };
  }

  /// ui_design_prompt alias for [build].
  static ColorScheme buildCoreColorScheme({
    required AppRole role,
    required Brightness brightness,
  }) => build(role: role, brightness: brightness);
}

/// ui_design_prompt alias for [RolePalette].
typedef RoleAccentColors = RolePalette;

/// ui_design_prompt top-level alias for [CoreColorScheme.build].
ColorScheme buildCoreColorScheme({
  required AppRole role,
  required Brightness brightness,
}) => CoreColorScheme.build(role: role, brightness: brightness);

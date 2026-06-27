import 'package:ayletna_restaurant_app/core/core_colors.dart';
import 'package:flutter/material.dart';

/// PRD §3.1 roles for [CoreTheme.themeFor].
enum AppRole {
  customer,
  guest,
  operator,
  owner,
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

  static RolePalette _paletteFor(AppRole role, Brightness brightness) {
    final isDark = brightness == Brightness.dark;
    return switch (role) {
      AppRole.customer || AppRole.guest =>
        isDark
            ? const RolePalette(
              primary: Color(0xFFD8A15C),
              onPrimary: Color(0xFF2B211A),
              secondary: Color(0xFF8E8A4E),
              accent: Color(0xFFE7A06D),
              background: CoreColors.backgroundDark,
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: CoreColors.brandGold,
              onPrimary: CoreColors.brandBrown,
              secondary: CoreColors.brandOlive,
              accent: CoreColors.brandOrange,
              background: CoreColors.backgroundLight,
              surface: CoreColors.surfaceLight,
            ),
      AppRole.operator =>
        isDark
            ? const RolePalette(
              primary: Color(0xFF5B728A),
              onPrimary: Colors.white,
              secondary: Color(0xFF7A624D),
              accent: CoreColors.brandGoldDarkUi,
              background: Color(0xFF101418),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFF2C3E50),
              onPrimary: Colors.white,
              secondary: CoreColors.brandBrown,
              accent: CoreColors.brandGold,
              background: Color(0xFFF4F6F8),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.owner =>
        isDark
            ? const RolePalette(
              primary: Color(0xFFC49A4E),
              onPrimary: Color(0xFF2B211A),
              secondary: CoreColors.textSecondaryDark,
              accent: Color(0xFFD4AF37),
              background: Color(0xFF15120D),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFF6A4E23),
              onPrimary: Colors.white,
              secondary: CoreColors.brandGold,
              accent: Color(0xFFD4AF37),
              background: Color(0xFFFBF8F1),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.cashier =>
        isDark
            ? const RolePalette(
              primary: Color(0xFFF39C3D),
              onPrimary: Color(0xFF2B211A),
              secondary: CoreColors.brandGoldDarkUi,
              accent: Color(0xFF42C777),
              background: Color(0xFF1A1410),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFFE67E22),
              onPrimary: Colors.white,
              secondary: CoreColors.brandGold,
              accent: CoreColors.semanticSuccess,
              background: Color(0xFFFFF8F0),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.kitchen =>
        isDark
            ? const RolePalette(
              primary: Color(0xFFEF5350),
              onPrimary: Colors.white,
              secondary: Color(0xFFFF8A80),
              accent: CoreColors.brandGoldDarkUi,
              background: Color(0xFF1A1010),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFFC62828),
              onPrimary: Colors.white,
              secondary: Color(0xFFE57373),
              accent: CoreColors.brandGold,
              background: Color(0xFFFFF5F5),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.delivery =>
        isDark
            ? const RolePalette(
              primary: Color(0xFF64B5F6),
              onPrimary: Color(0xFF2B211A),
              secondary: Color(0xFF90CAF9),
              accent: CoreColors.brandGoldDarkUi,
              background: Color(0xFF0F141A),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFF1565C0),
              onPrimary: Colors.white,
              secondary: Color(0xFF42A5F5),
              accent: CoreColors.brandGold,
              background: Color(0xFFF4F9FF),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.inventory =>
        isDark
            ? const RolePalette(
              primary: Color(0xFF66BB6A),
              onPrimary: Color(0xFF2B211A),
              secondary: Color(0xFFA5D6A7),
              accent: CoreColors.brandGoldDarkUi,
              background: Color(0xFF101610),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFF2E7D32),
              onPrimary: Colors.white,
              secondary: Color(0xFF81C784),
              accent: CoreColors.brandGold,
              background: Color(0xFFF4FFF4),
              surface: CoreColors.surfaceLight,
            ),
      AppRole.staff =>
        isDark
            ? const RolePalette(
              primary: Color(0xFFB47AD3),
              onPrimary: Color(0xFF2B211A),
              secondary: Color(0xFFCE93D8),
              accent: CoreColors.brandGoldDarkUi,
              background: Color(0xFF151018),
              surface: CoreColors.surfaceDark,
            )
            : const RolePalette(
              primary: Color(0xFF8E44AD),
              onPrimary: Colors.white,
              secondary: Color(0xFFBA68C8),
              accent: CoreColors.brandGold,
              background: Color(0xFFFAF5FF),
              surface: CoreColors.surfaceLight,
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

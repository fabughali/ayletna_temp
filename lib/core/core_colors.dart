import 'package:flutter/material.dart';

/// Brand, semantic, and order-type colors from color_list_chat_gpt.txt.
abstract final class CoreColors {
  // Brand
  static const Color brandGold = Color(0xFFC98A42);
  static const Color brandBrown = Color(0xFF4A3325);
  static const Color brandOlive = Color(0xFF6E6A35);
  static const Color brandOliveLight = Color(0xFFA6A16A);
  static const Color brandOrange = Color(0xFFD88A52);

  // Light surfaces
  static const Color backgroundLight = Color(0xFFF9F6F0);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color splashGradientBottomLight = Color(0xFFF5E6D3);
  static const Color dividerLight = Color(0xFFE8E1D6);
  static const Color textPrimaryLight = Color(0xFF2B211A);
  static const Color textSecondaryLight = Color(0xFF6D5C4D);
  static const Color textDisabledLight = Color(0xFFA79A8C);

  // Dark surfaces
  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);
  static const Color cardDark = Color(0xFF252525);
  static const Color dividerDark = Color(0xFF3A3A3A);
  static const Color textPrimaryDark = Color(0xFFF5F5F5);
  static const Color textSecondaryDark = Color(0xFFC5C5C5);
  static const Color textDisabledDark = Color(0xFF8B8B8B);

  static const Color brandGoldDarkUi = Color(0xFFD8A15C);

  // Order types (PRD §2.5 — not role primaries)
  static const Color orderTypeDineIn = Color(0xFF00897B);
  static const Color orderTypeTakeaway = Color(0xFFF9A825);
  static const Color orderTypeDelivery = Color(0xFF1976D2);
  static const Color orderTypePlated = Color(0xFF7B1FA2);

  // Semantics
  static const Color semanticTip = Color(0xFF6E6A35);
  static const Color semanticDeposit = Color(0xFF5D4037);
  static const Color semanticRevenue = Color(0xFFC98A42);
  static const Color semanticSuccess = Color(0xFF27AE60);
  static const Color semanticWarning = Color(0xFFF9A825);
  static const Color semanticError = Color(0xFFC62828);

  // PWA
  static const Color themeColorWeb = Color(0xFFC98A42);
  static const Color backgroundColorWeb = Color(0xFFF9F6F0);
}

/// Opacity helpers — prefer [withValues] over legacy opacity APIs in widgets.
extension ColorOpacityExtensions on Color {
  Color get withAlpha08 => withValues(alpha: 0.08);
  Color get withAlpha12 => withValues(alpha: 0.12);
  Color get withAlpha20 => withValues(alpha: 0.20);
  Color get withAlpha65 => withValues(alpha: 0.65);
}

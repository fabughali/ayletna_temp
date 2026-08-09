import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

/// Responsive spacing and radii (ui_design_prompt).
abstract final class CoreSpacing {
  static const double radiusButton = 12;
  static const double radiusCard = 16;
  static const double radiusInput = 12;
  static const double radiusImage = 12;
  static const double radiusChip = 20;

  static double radiusButtonOf(BuildContext context) =>
      UtilitySizer.of(context, radiusButton);
  static double radiusCardOf(BuildContext context) =>
      UtilitySizer.of(context, radiusCard);
  static double radiusInputOf(BuildContext context) =>
      UtilitySizer.of(context, radiusInput);
  static double radiusImageOf(BuildContext context) =>
      UtilitySizer.of(context, radiusImage);
  static double radiusChipOf(BuildContext context) =>
      UtilitySizer.of(context, radiusChip);

  static double xs(BuildContext context) => UtilitySizer.band(context, 4, 6, 8);
  static double sm(BuildContext context) =>
      UtilitySizer.band(context, 8, 10, 12);
  static double md(BuildContext context) =>
      UtilitySizer.band(context, 12, 16, 20);
  static double lg(BuildContext context) =>
      UtilitySizer.band(context, 16, 24, 32);
  static double xl(BuildContext context) =>
      UtilitySizer.band(context, 24, 32, 40);
  static double xxl(BuildContext context) =>
      UtilitySizer.band(context, 32, 48, 64);
}

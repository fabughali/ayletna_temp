import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:flutter/material.dart';

/// Responsive spacing and radii (ui_design_prompt).
abstract final class CoreSpacing {
  static const double radiusButton = 12;
  static const double radiusCard = 16;
  static const double radiusInput = 12;
  static const double radiusImage = 12;
  static const double radiusChip = 20;

  static double xs(BuildContext context) => _band(context, 4, 6, 8);
  static double sm(BuildContext context) => _band(context, 8, 10, 12);
  static double md(BuildContext context) => _band(context, 12, 16, 20);
  static double lg(BuildContext context) => _band(context, 16, 24, 32);
  static double xl(BuildContext context) => _band(context, 24, 32, 40);
  static double xxl(BuildContext context) => _band(context, 32, 48, 64);

  static double _band(
    BuildContext context,
    double mobile,
    double tablet,
    double web,
  ) {
    return switch (UtilityResponsiveBreakpoints.contentBandOf(context)) {
      ContentBand.mobile => mobile,
      ContentBand.tablet => tablet,
      ContentBand.web => web,
    };
  }
}

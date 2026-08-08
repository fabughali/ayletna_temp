import 'dart:ui' show lerpDouble;

import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:flutter/material.dart';

/// Viewport-relative sizing for every UI metric (buttons, icons, type, cards).
///
/// Design tokens are authored for [designWidth]. Prefer [of] for a single
/// design size and [band] for mobile/tablet/web semantic targets. Layout width
/// is capped by the content column so wide Chrome does not inflate chrome.
abstract final class UtilitySizer {
  /// Reference phone width used as the 1.0 scale.
  static const double designWidth = 390;

  static const double minScale = 0.70;
  static const double maxScale = 1.18;

  /// Layout width used for scaling — viewport capped by content max width.
  static double layoutWidthOf(BuildContext context) {
    return layoutWidthFor(MediaQuery.sizeOf(context).width);
  }

  static double layoutWidthFor(double viewportWidth) {
    final contentMax =
        UtilityResponsiveBreakpoints.maxContentWidthForWidth(viewportWidth);
    return viewportWidth < contentMax ? viewportWidth : contentMax;
  }

  static double scaleOf(BuildContext context) {
    return scaleForWidth(layoutWidthOf(context));
  }

  static double scaleForWidth(double width) {
    final layout = layoutWidthFor(width);
    return (layout / designWidth).clamp(minScale, maxScale);
  }

  /// Scale a design-token size to the current content column.
  static double of(BuildContext context, double designSize) {
    return designSize * scaleOf(context);
  }

  /// Scale from an explicit width (theme rebuild path).
  static double ofWidth(double width, double designSize) {
    return designSize * scaleForWidth(width);
  }

  /// Mobile → tablet → web tokens, continuously interpolated.
  ///
  /// On phones (≤ mobileMax) values also shrink below the authored mobile
  /// token when the viewport is narrower than [designWidth].
  static double band(
    BuildContext context,
    double mobile,
    double tablet,
    double web,
  ) {
    return bandForWidth(layoutWidthOf(context), mobile, tablet, web);
  }

  static double bandForWidth(
    double width,
    double mobile,
    double tablet,
    double web,
  ) {
    final layout = layoutWidthFor(width);
    if (layout <= UtilityResponsiveBreakpoints.mobileMax) {
      return mobile * (layout / designWidth).clamp(minScale, 1.0);
    }
    if (layout <= UtilityResponsiveBreakpoints.tabletMax) {
      final t =
          (layout - UtilityResponsiveBreakpoints.mobileMax) /
          (UtilityResponsiveBreakpoints.tabletMax -
              UtilityResponsiveBreakpoints.mobileMax);
      return lerpDouble(mobile, tablet, t)!;
    }
    final t =
        ((layout - UtilityResponsiveBreakpoints.tabletMax) / 400).clamp(
          0.0,
          1.0,
        );
    return lerpDouble(tablet, web, t)!;
  }
}

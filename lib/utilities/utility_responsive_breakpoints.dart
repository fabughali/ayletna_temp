import 'package:flutter/material.dart';

/// Device category from viewport width.
enum DeviceType { mobile, tablet, web }

/// Content density band for typography and spacing.
enum ContentBand { mobile, tablet, web }

/// Single source of truth for responsive breakpoints (ui_design_prompt).
abstract final class UtilityResponsiveBreakpoints {
  static const double mobileMax = 479;
  static const double tabletMax = 991;

  static DeviceType deviceTypeFromWidth(double width) {
    if (width <= mobileMax) {
      return DeviceType.mobile;
    }
    if (width <= tabletMax) {
      return DeviceType.tablet;
    }
    return DeviceType.web;
  }

  static ContentBand contentBandFromWidth(double width) {
    switch (deviceTypeFromWidth(width)) {
      case DeviceType.mobile:
        return ContentBand.mobile;
      case DeviceType.tablet:
        return ContentBand.tablet;
      case DeviceType.web:
        return ContentBand.web;
    }
  }

  static double maxContentWidthForWidth(double width) {
    return switch (contentBandFromWidth(width)) {
      ContentBand.mobile => width,
      ContentBand.tablet => 720,
      ContentBand.web => 960,
    };
  }

  static ContentBand contentBandOf(BuildContext context) {
    return contentBandFromWidth(MediaQuery.sizeOf(context).width);
  }
}

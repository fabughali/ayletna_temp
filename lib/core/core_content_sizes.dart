import 'package:ayletna_restaurant_app/utilities/utility_responsive_breakpoints.dart';
import 'package:flutter/material.dart';

abstract final class CoreContentSizes {
  static double logoWelcome(BuildContext context) {
    return _band(context, 96, 112, 128);
  }

  static double logoCard(BuildContext context) {
    return _band(context, 48, 56, 64);
  }

  static double authCardMaxWidth(BuildContext context) {
    return _band(context, 420, 430, 440);
  }

  static double loadingIndicator(BuildContext context) {
    return _band(context, 32, 36, 40);
  }

  static double heroImageHeight(BuildContext context) {
    return _band(context, 160, 200, 240);
  }

  static double categoryRailHeight(BuildContext context) {
    return _band(context, 44, 48, 52);
  }

  static double productHeroIcon(BuildContext context) {
    return _band(context, 56, 64, 72);
  }

  static double financialIndicatorWidth(BuildContext context) {
    return _band(context, 4, 4, 5);
  }

  static double financialIndicatorHeight(BuildContext context) {
    return _band(context, 20, 22, 24);
  }

  static double amountIndicatorWidth(BuildContext context) {
    return _band(context, 4, 4, 5);
  }

  static double amountIndicatorHeight(BuildContext context) {
    return _band(context, 18, 20, 22);
  }

  static double orderTypeIndicatorWidth(BuildContext context) {
    return _band(context, 4, 4, 5);
  }

  static double orderTypeIndicatorHeight(BuildContext context) {
    return _band(context, 24, 26, 28);
  }

  static double orderTypeIndicatorRadius(BuildContext context) {
    return _band(context, 2, 2, 3);
  }

  static double timelineIcon(BuildContext context) {
    return _band(context, 22, 24, 26);
  }

  static double timelineLineWidth(BuildContext context) {
    return _band(context, 2, 2, 3);
  }

  static double timelineLineHeight(BuildContext context) {
    return _band(context, 32, 36, 40);
  }

  static double emptyStateIcon(BuildContext context) {
    return _band(context, 48, 56, 64);
  }

  static double buttonIcon(BuildContext context) {
    return _band(context, 20, 22, 24);
  }

  static double buttonIconGap(BuildContext context) {
    return _band(context, 8, 10, 12);
  }

  static double successIcon(BuildContext context) {
    return _band(context, 72, 80, 88);
  }

  static double listDividerHeight(BuildContext context) {
    return _band(context, 1, 1, 1);
  }

  static double splashDividerHeight(BuildContext context) {
    return _band(context, 3, 3, 4);
  }

  static double splashDividerRadius(BuildContext context) {
    return _band(context, 2, 2, 3);
  }

  static double orderTypeIcon(BuildContext context) {
    return _band(context, 18, 20, 22);
  }

  static double profileAvatarRadius(BuildContext context) {
    return _band(context, 36, 40, 44);
  }

  static double profileAvatarIcon(BuildContext context) {
    return _band(context, 36, 40, 44);
  }

  static double kpiIcon(BuildContext context) {
    return _band(context, 22, 24, 26);
  }

  static double adminChartHeight(BuildContext context) {
    return _band(context, 96, 112, 128);
  }

  static double adminChartBarRadius(BuildContext context) {
    return _band(context, 3, 4, 5);
  }

  static double adminStatusIcon(BuildContext context) {
    return _band(context, 20, 22, 24);
  }

  static double posCategoryRailWidth(BuildContext context) {
    return _band(context, 76, 96, 112);
  }

  static double posOrderPanelWidth(BuildContext context) {
    return _band(context, 232, 300, 340);
  }

  static double posCategoryIcon(BuildContext context) {
    return _band(context, 28, 32, 36);
  }

  static double posEmptyIcon(BuildContext context) {
    return _band(context, 64, 72, 80);
  }

  static double categoryMenuImageHeight(BuildContext context) {
    return _band(context, 150, 180, 210);
  }

  static double categoryMenuImageIcon(BuildContext context) {
    return _band(context, 52, 60, 68);
  }

  static double categoryHeroHeight(BuildContext context) {
    return _band(context, 300, 360, 420);
  }

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

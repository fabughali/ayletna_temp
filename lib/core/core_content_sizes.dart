import 'package:ayletna_restaurant_app/utilities/utility_sizer.dart';
import 'package:flutter/material.dart';

abstract final class CoreContentSizes {
  static double logoWelcome(BuildContext context) {
    return UtilitySizer.band(context, 96, 112, 128);
  }

  static double logoCard(BuildContext context) {
    return UtilitySizer.band(context, 48, 56, 64);
  }

  static double authCardMaxWidth(BuildContext context) {
    return UtilitySizer.band(context, 420, 430, 440);
  }

  static double loadingIndicator(BuildContext context) {
    return UtilitySizer.band(context, 32, 36, 40);
  }

  static double heroImageHeight(BuildContext context) {
    return UtilitySizer.band(context, 160, 200, 240);
  }

  static double categoryRailHeight(BuildContext context) {
    return UtilitySizer.band(context, 44, 48, 52);
  }

  static double productHeroIcon(BuildContext context) {
    return UtilitySizer.band(context, 56, 64, 72);
  }

  static double financialIndicatorWidth(BuildContext context) {
    return UtilitySizer.band(context, 4, 4, 5);
  }

  static double financialIndicatorHeight(BuildContext context) {
    return UtilitySizer.band(context, 20, 22, 24);
  }

  static double amountIndicatorWidth(BuildContext context) {
    return UtilitySizer.band(context, 4, 4, 5);
  }

  static double amountIndicatorHeight(BuildContext context) {
    return UtilitySizer.band(context, 18, 20, 22);
  }

  static double orderTypeIndicatorWidth(BuildContext context) {
    return UtilitySizer.band(context, 4, 4, 5);
  }

  static double orderTypeIndicatorHeight(BuildContext context) {
    return UtilitySizer.band(context, 24, 26, 28);
  }

  static double orderTypeIndicatorRadius(BuildContext context) {
    return UtilitySizer.band(context, 2, 2, 3);
  }

  static double timelineIcon(BuildContext context) {
    return UtilitySizer.band(context, 22, 24, 26);
  }

  static double timelineLineWidth(BuildContext context) {
    return UtilitySizer.band(context, 2, 2, 3);
  }

  static double timelineLineHeight(BuildContext context) {
    return UtilitySizer.band(context, 32, 36, 40);
  }

  static double emptyStateIcon(BuildContext context) {
    return UtilitySizer.band(context, 48, 56, 64);
  }

  static double buttonIcon(BuildContext context) {
    return UtilitySizer.band(context, 20, 22, 24);
  }

  /// Compact icons inside chips, tags, badges, and dense rows.
  static double chipIcon(BuildContext context) {
    return UtilitySizer.band(context, 14, 15, 16);
  }

  static double badgeIcon(BuildContext context) {
    return UtilitySizer.band(context, 12, 13, 14);
  }

  static double mediaTagIcon(BuildContext context) {
    return UtilitySizer.band(context, 15, 16, 17);
  }

  static double compactIconButton(BuildContext context) {
    return UtilitySizer.band(context, 32, 36, 40);
  }

  static double cartBadgeDiameter(BuildContext context) {
    return UtilitySizer.band(context, 18, 20, 22);
  }

  static double checkoutStepDot(BuildContext context) {
    return UtilitySizer.band(context, 28, 30, 32);
  }

  static double checkoutStepDotActive(BuildContext context) {
    return UtilitySizer.band(context, 22, 24, 26);
  }

  static double sheetGrabberWidth(BuildContext context) {
    return UtilitySizer.band(context, 44, 48, 52);
  }

  static double sheetGrabberHeight(BuildContext context) {
    return UtilitySizer.band(context, 4, 4, 5);
  }

  static double appBarHeight(BuildContext context) {
    return UtilitySizer.band(context, 52, 56, 60);
  }

  static double buttonIconGap(BuildContext context) {
    return UtilitySizer.band(context, 8, 10, 12);
  }

  static double successIcon(BuildContext context) {
    return UtilitySizer.band(context, 72, 80, 88);
  }

  static double listDividerHeight(BuildContext context) {
    return UtilitySizer.band(context, 1, 1, 1);
  }

  static double splashDividerHeight(BuildContext context) {
    return UtilitySizer.band(context, 3, 3, 4);
  }

  static double splashDividerRadius(BuildContext context) {
    return UtilitySizer.band(context, 2, 2, 3);
  }

  static double orderTypeIcon(BuildContext context) {
    return UtilitySizer.band(context, 18, 20, 22);
  }

  static double profileAvatarRadius(BuildContext context) {
    return UtilitySizer.band(context, 36, 40, 44);
  }

  static double profileAvatarIcon(BuildContext context) {
    return UtilitySizer.band(context, 36, 40, 44);
  }

  /// Camera / edit badge diameter on the profile avatar (keep ≪ avatar).
  static double profileAvatarEditBadge(BuildContext context) {
    return UtilitySizer.band(context, 22, 24, 26);
  }

  static double profileAvatarEditIcon(BuildContext context) {
    return UtilitySizer.band(context, 12, 13, 14);
  }

  static double kpiIcon(BuildContext context) {
    return UtilitySizer.band(context, 22, 24, 26);
  }

  static double adminChartHeight(BuildContext context) {
    return UtilitySizer.band(context, 96, 112, 128);
  }

  static double adminChartBarRadius(BuildContext context) {
    return UtilitySizer.band(context, 3, 4, 5);
  }

  static double adminStatusIcon(BuildContext context) {
    return UtilitySizer.band(context, 20, 22, 24);
  }

  static double posCategoryRailWidth(BuildContext context) {
    return UtilitySizer.band(context, 76, 96, 112);
  }

  static double posOrderPanelWidth(BuildContext context) {
    return UtilitySizer.band(context, 232, 300, 340);
  }

  static double posCategoryIcon(BuildContext context) {
    return UtilitySizer.band(context, 28, 32, 36);
  }

  static double posEmptyIcon(BuildContext context) {
    return UtilitySizer.band(context, 64, 72, 80);
  }

  static double categoryMenuImageHeight(BuildContext context) {
    return UtilitySizer.band(context, 150, 180, 210);
  }

  static double categoryMenuImageIcon(BuildContext context) {
    return UtilitySizer.band(context, 52, 60, 68);
  }

  static double categoryHeroHeight(BuildContext context) {
    return UtilitySizer.band(context, 300, 360, 420);
  }

  /// Thumbnail width for multi-image catalog editors.
  static double catalogThumbWidth(BuildContext context) {
    return UtilitySizer.band(context, 100, 120, 136);
  }

  /// Stadium / pill radius (fully rounded ends).
  static double pillRadius(BuildContext context) {
    return UtilitySizer.of(context, 999);
  }

  /// Product detail / sheet hero media height.
  static double productDetailHeroHeight(BuildContext context) {
    return UtilitySizer.band(context, 200, 230, 260);
  }

  /// Compact metric / tip rail tile width.
  static double tipRailTileWidth(BuildContext context) {
    return UtilitySizer.band(context, 136, 160, 184);
  }
}

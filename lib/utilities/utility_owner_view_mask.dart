import 'package:ayletna_restaurant_app/data/models/model_owner_view_config.dart';
import 'package:ayletna_restaurant_app/utilities/utility_format_jod.dart';

abstract final class UtilityOwnerViewMask {
  static String formatJod(
    double value, {
    required OwnerViewMask mask,
    required bool sensitive,
    String suffix = ' JOD',
  }) {
    if (mask.netProfitOnly && sensitive) return '••••••';
    if (mask.hideRawCosts && sensitive) return '••••••';
    return UtilityFormatJod.format(value, suffix: suffix);
  }

  static String formatPercent(double value, {required OwnerViewMask mask}) {
    if (mask.netProfitOnly) return '—';
    return '${value.toStringAsFixed(0)}%';
  }

  static bool shouldHideStaffSection(OwnerViewMask mask) =>
      mask.hideStaffSalaries || mask.netProfitOnly;

  static bool shouldHideRawCostRow(OwnerViewMask mask) =>
      mask.hideRawCosts || mask.netProfitOnly;
}

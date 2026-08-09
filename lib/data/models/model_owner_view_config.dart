/// Owner report visibility preset (set by app admin, linked from profile).
class OwnerViewConfig {
  const OwnerViewConfig({
    required this.id,
    required this.labelAr,
    required this.labelEn,
    this.hideRawCosts = true,
    this.hideStaffSalaries = true,
    this.netProfitOnly = false,
  });

  final String id;
  final String labelAr;
  final String labelEn;
  final bool hideRawCosts;
  final bool hideStaffSalaries;
  final bool netProfitOnly;

  String label(bool isAr) => isAr ? labelAr : labelEn;
}

/// Active mask applied when owner views read-only finance/reports.
class OwnerViewMask {
  const OwnerViewMask({
    this.hideRawCosts = false,
    this.hideStaffSalaries = false,
    this.netProfitOnly = false,
    this.configId,
  });

  final bool hideRawCosts;
  final bool hideStaffSalaries;
  final bool netProfitOnly;
  final String? configId;

  static const none = OwnerViewMask();

  factory OwnerViewMask.fromConfig(OwnerViewConfig config) => OwnerViewMask(
        hideRawCosts: config.hideRawCosts,
        hideStaffSalaries: config.hideStaffSalaries,
        netProfitOnly: config.netProfitOnly,
        configId: config.id,
      );

  String formatAmount(double value, {required bool sensitive}) {
    if (netProfitOnly && sensitive) return '••••••';
    if (hideRawCosts && sensitive) return '••••••';
    return value.toStringAsFixed(2);
  }
}

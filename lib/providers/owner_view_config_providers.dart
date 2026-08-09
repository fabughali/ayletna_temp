import 'package:ayletna_restaurant_app/data/models/model_owner_view_config.dart';
import 'package:ayletna_restaurant_app/providers/admin_session_providers.dart';
import 'package:ayletna_restaurant_app/providers/user_profile_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _presets = [
  OwnerViewConfig(
    id: 'cfg-standard',
    labelAr: 'قياسي',
    labelEn: 'Standard',
    hideRawCosts: true,
    hideStaffSalaries: true,
    netProfitOnly: false,
  ),
  OwnerViewConfig(
    id: 'cfg-limited',
    labelAr: 'محدود',
    labelEn: 'Limited',
    hideRawCosts: true,
    hideStaffSalaries: true,
    netProfitOnly: true,
  ),
  OwnerViewConfig(
    id: 'cfg-full',
    labelAr: 'كامل',
    labelEn: 'Full visibility',
    hideRawCosts: false,
    hideStaffSalaries: false,
    netProfitOnly: false,
  ),
];

final ownerViewConfigCatalogProvider = Provider<List<OwnerViewConfig>>(
  (ref) => _presets,
);

final ownerViewConfigByIdProvider = Provider.family<OwnerViewConfig?, String>((
  ref,
  id,
) {
  for (final config in _presets) {
    if (config.id == id) return config;
  }
  return null;
});

/// Merges profile-linked preset with live admin growth privacy toggles (cfg-standard).
final effectiveOwnerViewMaskProvider = Provider<OwnerViewMask>((ref) {
  final profile = ref.watch(userProfileProvider);
  final configId = profile.ownerViewConfigId ?? 'cfg-standard';
  final preset =
      ref.watch(ownerViewConfigByIdProvider(configId)) ?? _presets.first;

  if (configId == 'cfg-standard') {
    final live = ref.watch(adminGrowthConfigProvider);
    return OwnerViewMask(
      hideRawCosts: live.hideRawCosts,
      hideStaffSalaries: live.hideStaffSalaries,
      netProfitOnly: live.netProfitOnly,
      configId: configId,
    );
  }

  return OwnerViewMask.fromConfig(preset);
});

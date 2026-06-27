import 'package:ayletna_restaurant_app/l10n/app_localizations.dart';

String cartOptionLabel(String key, AppLocalizations l10n) {
  return switch (key) {
    'single' => l10n.productSinglePlatter,
    'family' => l10n.productFamilySize,
    'extra_jameed' => l10n.productExtraJameed,
    'extra_almonds' => l10n.productExtraAlmonds,
    'no_pine_nuts' => l10n.productNoPineNuts,
    _ => key,
  };
}

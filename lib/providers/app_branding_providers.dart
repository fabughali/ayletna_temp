import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Admin-editable restaurant branding (EN + AR). Defaults match current brand.
class AppBrandingConfig {
  const AppBrandingConfig({
    this.nameEn = 'Ayletna Restaurant',
    this.nameAr = 'مطعم عيلتنا',
    this.sloganEn = 'Premium Levantine Cuisine',
    this.sloganAr = 'مأكولات شامية فاخرة',
    this.logoUrl,
  });

  final String nameEn;
  final String nameAr;
  final String sloganEn;
  final String sloganAr;

  /// Optional network/asset override. Null → default falafel asset logo.
  final String? logoUrl;

  String name(bool isAr) => isAr ? nameAr : nameEn;
  String slogan(bool isAr) => isAr ? sloganAr : sloganEn;

  AppBrandingConfig copyWith({
    String? nameEn,
    String? nameAr,
    String? sloganEn,
    String? sloganAr,
    String? logoUrl,
    bool clearLogoUrl = false,
  }) {
    return AppBrandingConfig(
      nameEn: nameEn ?? this.nameEn,
      nameAr: nameAr ?? this.nameAr,
      sloganEn: sloganEn ?? this.sloganEn,
      sloganAr: sloganAr ?? this.sloganAr,
      logoUrl: clearLogoUrl ? null : (logoUrl ?? this.logoUrl),
    );
  }
}

class AppBrandingNotifier extends StateNotifier<AppBrandingConfig> {
  AppBrandingNotifier() : super(const AppBrandingConfig());

  void update(AppBrandingConfig next) => state = next;

  void resetDefaults() => state = const AppBrandingConfig();
}

final appBrandingProvider =
    StateNotifierProvider<AppBrandingNotifier, AppBrandingConfig>(
      (ref) => AppBrandingNotifier(),
    );
